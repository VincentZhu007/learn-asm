# Makefile for learn-asm

OBJS = c05_mbr.bin

AS = nasm
ASFLAGS = -f bin -l $*.lst

all : $(OBJS)

# 汇编
%.bin : %.asm
	$(AS) $(ASFLAGS) $< -o $@

# 生成bochs所需的软盘镜像文件，并设置.bochsrc配置文件
bochs_% : %.bin
	dd bs=512 count=1 if=$< of=$*.img
	sed -i -n "s/1_44=.*,/1_44=$*.img,/" .bochsrc

.PHONY : clean
clean :
	-rm -rf *.bin *.lst *.img bochsout.txt
