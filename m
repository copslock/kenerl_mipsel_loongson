From: WANG Cong <xiyou.wangcong@gmail.com>
Date: Wed, 2 Jan 2008 14:21:36 +0800
Subject: [PATCH] [MIPS] Lasat: Fix built in separate object directory.
Message-ID: <20080102062136.Mf-zVMBUMDGn46LhZZ5Q5u4Af-dJZVYGhtoaEvP5b_Q@z>

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

[Ralf: The LDSCRIPT script needed fixing, too]

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 5332449..7ccd40d 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -12,11 +12,11 @@ endif
 
 MKLASATIMG = mklasatimg
 MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
-KERNEL_IMAGE = $(TOPDIR)/vmlinux
+KERNEL_IMAGE = vmlinux
 KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
 KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
 
-LDSCRIPT= -L$(obj) -Tromscript.normal
+LDSCRIPT= -L$(srctree)/$(obj) -Tromscript.normal
 
 HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
 		-D_kernel_entry=0x$(KERNEL_ENTRY) \
@@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
 		-D TIMESTAMP=$(shell date +%s)
 
 $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
-	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
+	$(CC) -fno-pic $(HEAD_DEFINES) $(LINUXINCLUDE) -c -o $@ $<
 
 OBJECTS = head.o kImage.o
 
