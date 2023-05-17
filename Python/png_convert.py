from PIL import Image
import os

# 定义要处理的目录
dir_path = './'

# 获取目录下所有RAW二进制文件的文件名列表
file_list = [f for f in os.listdir(dir_path) if f.endswith('.png')]

print(file_list)

# 遍历每个文件并处理
for file_name in file_list:
    # 构造输入和输出文件路径
    input_file_path = os.path.join(dir_path, file_name)
    output_file_path = os.path.splitext(input_file_path)[0] + '.txt'
    # 读入PNG图像
    img = Image.open(file_name)

    # 获取图像的像素值
    pixels = img.load()

    # 将像素值写入文本文件
    with open(output_file_path, 'w') as f:
        for y in range(img.height):
            for x in range(img.width):
                # 获取像素值
                pixel_value = pixels[x, y] >> 4

                # 将像素值写入文件，每个像素一行
                f.write(f'{pixel_value}\n')