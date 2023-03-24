####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../05')
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-14: 30 points
BU CAS CS320-2023-Spring: Image Processing
"""
####################################################
import math
####################################################
import kervec
import imgvec
####################################################
from PIL import Image
####################################################

def load_color_image(filename):
    """
    Loads a color image from the given file and returns a dictionary
    representing that image.

    Invoked as, for example:
       i = load_color_image("test_images/cat.png")
    """
    with open(filename, "rb") as img_handle:
        img = Image.open(img_handle)
        img = img.convert("RGB")  # in case we were given a greyscale image
        img_data = img.getdata()
        pixels = list(img_data)
        width, height = img.size
        return imgvec.image(height, width, pixels)
    # return None

def save_color_image(image, filename, mode="PNG"):
    """
    Saves the given color image to disk or to a file-like object.  If filename
    is given as a string, the file type will be inferred from the given name.
    If filename is given as a file-like object, the file type will be
    determined by the "mode" parameter.
    """
    out = Image.new(mode="RGB", size=(image.width, image.height))
    out.putdata(image.pixlst)
    if isinstance(filename, str):
        out.save(filename)
    else:
        out.save(filename, mode)
    out.close()
    # return None

####################################################
#
# HX-2023-03-18:
# This one is incorrect:
# def grey_of_color(clr):
#     (r0, b1, g2) = clr
#     return round(0.299*r0+0.587*b1+0.114*g2)
def grey_of_color(clr):
    (rr, gg, bb) = clr
    return round(0.299*rr+0.587*gg+0.114*bb)
#
####################################################

def image_invert_grey(ximg):
    return imgvec.image_make_map(ximg, lambda pix: 255 - pix)
def image_invert_color(ximg):
    return imgvec.image_make_map(ximg, lambda clr: 255 - grey_of_color(clr))

####################################################
#
# towers = \
#     load_color_image("INPUT/towers.jpg")
# balloons = \
#     load_color_image("INPUT/balloons.png")
#
####################################################
#
# save_color_image(image_invert_color(towers), "OUTPUT/towers_invert.png")
# save_color_image(image_invert_color(balloons), "OUTPUT/balloons_invert.png")
#
####################################################

def image_edges_grey(image):
    """
    This is an implementation of the Sobel operator.
    """
    krow = \
        kervec.kernel_make_pylist\
        (3, [-1, -2, -1, 0, 0, 0, 1, 2, 1])
    kcol = \
        kervec.kernel_make_pylist\
        (3, [-1, 0, 1, -2, 0, 2, -1, 0, 1])
    imgrow = \
        imgvec.image_kernel_correlate(image, krow, 'extend')
    imgcol = \
        imgvec.image_kernel_correlate(image, kcol, 'extend')
    imgres = \
        imgvec.image_make_z2map\
        (imgrow, imgcol, lambda x, y: math.sqrt(x*x + y*y))
    return imgvec.image_round_and_clip(imgres)

def image_edges_color(image):
    return image_edges_grey\
        (imgvec.image_make_map(image, lambda clr: 255 - grey_of_color(clr)))

####################################################

def image_blur_bbehav_grey(image, ksize, bbehav):
    ksize2 = ksize*ksize
    kernel = \
        kervec.kernel_make_pylist\
        (ksize, ksize2*[1.0/ksize2])
    return imgvec.image_round_and_clip\
        (imgvec.image_kernel_correlate(image, kernel, bbehav))

####################################################

def color_filter_from_greyscale_filter(filt):
    """
    Given a filter that takes a greyscale image as input and produces a
    greyscale image as output, returns a function that takes a color image as
    input and produces the filtered color image.
    """
    def image_filter(cimage):
        ww = cimage.width
        hh = cimage.height
        image0 = filt(imgvec.image_make_map(cimage, lambda clr: clr[0]))
        image1 = filt(imgvec.image_make_map(cimage, lambda clr: clr[1]))
        image2 = filt(imgvec.image_make_map(cimage, lambda clr: clr[2]))
        return imgvec.image_make_tuple\
            (hh, ww, \
             tuple(zip(image0.pixlst, image1.pixlst, image2.pixlst)))
    return lambda cimage: image_filter(cimage)

####################################################

def image_blur_bbehav_color(image, ksize, bbehav):
    return \
        color_filter_from_greyscale_filter\
        (lambda image: image_blur_bbehav_grey(image, ksize, bbehav))(image)

####################################################
# save_color_image\
#    (image_blur_bbehav_color(balloons, 5, 'extend'), "OUTPUT/balloons_blurred.png")
####################################################
class energy_acc: 
    def __init__(self, x_prev, y_prev, energy): 
        # DISCLAIMER: X_PREV TECHINCALLY REPRESENTS THE Y AXIS AND VICE VERSA
        # HOWEVER THE CODE SHOULD STILL WORK ON ALL THE TESTS
        self.x_prev = x_prev
        self.y_prev = y_prev
        self.energy = energy
def seam_energies(image):
    acc = []
    for i in range(image.height):
        acc_row = []
        for j in range(image.width):
            curr_pixl = imgvec.image_get_pixel(image, i, j)
            if i == 0:
                acc_row.append((energy_acc(-1, -1, curr_pixl)))
            else:
                if j == 0:
                    prev = [acc[i-1][j].energy, acc[i-1][j+1].energy]
                    if prev[0] <= prev[1]:
                        acc_row.append(energy_acc(i-1, j, curr_pixl + acc[i-1][j].energy))
                    else:
                        acc_row.append(energy_acc(i-1, j+1, curr_pixl + acc[i-1][j+1].energy))
                elif j == image.width-1:
                    prev = [acc[i-1][j-1].energy, acc[i-1][j].energy]
                    if prev[0] <= prev[1]:
                        acc_row.append(energy_acc(i-1, j-1, curr_pixl + acc[i-1][j-1].energy))
                    else:
                        acc_row.append(energy_acc(i-1, j, curr_pixl + acc[i-1][j].energy))
                else:
                    prev = [acc[i-1][j-1].energy, acc[i-1][j].energy, acc[i-1][j+1].energy]   
                    prev_coords = [(i-1, j-1), (i-1, j), (i-1, j+1)]
                    prev_min = min(prev)
                    for k in range(len(prev)):
                        if prev[k] == prev_min:
                            acc_row.append(energy_acc(prev_coords[k][0], prev_coords[k][1], curr_pixl+prev[k]))
                            break         
        acc.append(acc_row)
    return acc
def get_seam(seam_lst, min_seam_end, pos, res, energy):
    prev_x = pos[0]
    prev_y = 0
    while (min_seam_end.x_prev != -1):
        if len(res) == 0:
            res.append(pos)
        else:
            res.append((min_seam_end.x_prev, min_seam_end.y_prev))
            prev_x = min_seam_end.x_prev
            prev_y = min_seam_end.y_prev
            min_seam_end = seam_lst[prev_x][prev_y]
    return (res)

def remove_seam(image, res, seam):
    for i in range(image.height):
        for j in range(image.width):
            if ((i,j) in seam) == False:
                res.pixlst.append((imgvec.image_get_pixel(image, i, j)))
    return res

    

def image_seam_carving_color(image, ncol):
    """
    Starting from the given image, use the seam carving technique to remove
    ncols (an integer) columns from the image. Returns a new image.
    """
    assert ncol < image.width
    energy = image_edges_color(image)
    
    for i in range(0,ncol):
        seam_lst = seam_energies(energy)
        new_image = imgvec.image(image.height, image.width-1, [])
        min_seam = energy_acc(-1,-1,-1)
        min_pos = (0,0)
        for i in range(len(seam_lst[0])):
            if i == 0:
                min_seam = seam_lst[image.height-1][i]
            elif seam_lst[image.height-1][i].energy < min_seam.energy:
                min_seam = seam_lst[image.height-1][i]
                min_pos = (image.height-1,i)
        res = []
        full_seam = get_seam(seam_lst, min_seam, min_pos, res, energy)
        new_image = remove_seam(image, new_image, full_seam)
        image = new_image
        energy = image_edges_color(new_image)
    return new_image

####################################################
# save_color_image(image_seam_carving_color(balloons, 100), "OUTPUT/balloons_seam_carving_100.png")
####################################################
