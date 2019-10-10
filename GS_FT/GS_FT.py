# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 09:21:48 2019

@author: Siyuan Liu
"""
import numpy as np
import matplotlib.pyplot as plt
from numpy import fft
from numpy import pi

import skimage.io as io
from skimage import transform
import os




def gaussian1(res=64,w0=3e-3,L=12e-3):
    '''    
    res为分辨率，
    w0为光斑半径
    L为监视区域的边长
    单位m
    返回高斯光束电场强度
    '''
    x2=np.linspace(-L/2,L/2,res);                           #采样周期
    [X,Y]=np.meshgrid(x2,x2);
    r=np.sqrt(X**2+Y**2);
    E=np.exp(-r**2/w0**2).astype('complex128');                #电场高斯函数

    return E




res=64
target=io.imread('xiaolian.png')
target=transform.resize(target,(64,64),mode='constant')


iteration_time=100
E=gaussian1()
ang=np.random.randn(res,res)

for i in range(iteration_time):
    after_slm=np.exp(1j*ang)*E
    after_len=fft.fftshift(fft.fft2(after_slm))
    ang=np.angle(after_len)
    
    buffer=target*np.exp(1j*ang)
    before_len=fft.ifft2(fft.ifftshift(buffer))
    ang=np.angle(before_len)
    

ang=np.mod(ang/2/pi,1)
afterslm_end=np.exp(1j*ang*2*pi)*E
result=fft.fftshift(fft.fft2(afterslm_end))
nom_result=np.abs(result)/np.max(np.abs(result))

plt.figure(1)
plt.imshow(ang)

plt.figure(2)
plt.imshow(nom_result)

MSE=1/res*1/res*np.sum((nom_result-target)**2)
print('MSE= %f'%MSE)

io.imsave('aaa.tiff',ang)

















