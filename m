Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA4MWAI31814
	for linux-mips-outgoing; Sun, 4 Nov 2001 14:32:10 -0800
Received: from mail.gmx.net (sproxy.gmx.de [213.165.64.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA4MVa031805
	for <linux-mips@oss.sgi.com>; Sun, 4 Nov 2001 14:31:36 -0800
Received: (qmail 27779 invoked by uid 0); 4 Nov 2001 22:31:28 -0000
Received: from pd953a76d.dip.t-dialin.net (HELO bogon.ms20.nix) (217.83.167.109)
  by mail.gmx.net (mp005-rz3) with SMTP; 4 Nov 2001 22:31:28 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id B80E0B807; Sun,  4 Nov 2001 23:32:19 +0100 (CET)
Date: Sun, 4 Nov 2001 23:32:19 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Cc: ralf@gnu.org
Subject: arcboot patches
Message-ID: <20011104233218.A15847@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com, ralf@gnu.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

attached is a first set of patches to make arcboot somewhat work for
big endian mips, mostly:
 - compile with -fno-pic, since the IP22 PROMs can't handle this
 - IP22 uses ARCS not ARC (MEMORYTYPE)
 - IP22 is big endian (LARGEINTEGER)
 - move everything into KSEG0
 - make function prototypes same as in libc
 - remove i386 references
 - convert some ARCS errorcodes to EXT2_ET_ errors, since
   ARCS errorcodes let ext2fs_strerror crash.
It does still not boot the kernel correctly, but it's quiet close...
Regards,
 -- Guido

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="arcboot-2001-11-04.diff"

Index: arclib/Makefile
===================================================================
RCS file: /cvs/arcboot/arclib/Makefile,v
retrieving revision 1.1
diff -u -u -r1.1 Makefile
--- arclib/Makefile	2001/03/20 02:44:56	1.1
+++ arclib/Makefile	2001/11/04 22:06:28
@@ -1,7 +1,9 @@
 #
 # Copyright 1999 Silicon Graphics, Inc.
 #
-CFLAGS = -O
+CFLAGS = -O -Werror -Wall -mno-abicalls -G 0 -fno-pic 
+ASFLAGS= -mno-abicalls -G 0 -fno-pic
+
 OBJECTS = arc.o	stdio.o stdlib.o string.o
 
 all:  libarc.a
Index: arclib/arc.h
===================================================================
RCS file: /cvs/arcboot/arclib/arc.h,v
retrieving revision 1.2
diff -u -u -r1.2 arc.h
--- arclib/arc.h	2001/03/20 02:55:56	1.2
+++ arclib/arc.h	2001/11/04 22:06:28
@@ -1,5 +1,6 @@
 /*
  * Copyright 1999 Silicon Graphics, Inc.
+ *           2001 Guido Guenther <agx@sixcpu.org>
  */
 #ifndef _ARC_H_
 #define _ARC_H_
@@ -109,15 +110,16 @@
 	UCHAR ProductId[8];
 } SYSTEMID;
 
+/* This is ARCS not ARC */
 typedef enum {
 	ExceptionBlock,
 	SystemParameterBlock,
+	FreeContiguous,
 	FreeMemory,
 	BadMemory,
 	LoadedProgram,
 	FirmwareTemporary,
 	FirmwarePermanent,
-	FreeContiguous
 } MEMORYTYPE;
 
 typedef struct {
@@ -157,8 +159,13 @@
 } OPENMODE;
 
 typedef struct {
+#ifdef __MIPSEL__
 	ULONG LowPart;
+	*LONG HighPart;
+#else /* !(__MIPSEL__) */
 	LONG HighPart;
+	ULONG LowPart;
+#endif
 } LARGEINTEGER;
 
 typedef enum {
Index: arclib/spb.h
===================================================================
RCS file: /cvs/arcboot/arclib/spb.h,v
retrieving revision 1.2
diff -u -u -r1.2 spb.h
--- arclib/spb.h	2001/03/20 02:55:56	1.2
+++ arclib/spb.h	2001/11/04 22:06:28
@@ -90,7 +90,7 @@
 	ADAPTER Adapters[1];
 } SPB;
 
-#define SystemParameterBlock	((SPB *) 0x1000)
+#define SystemParameterBlock	((SPB *) 0xA0001000UL) 
 #define FVector		(SystemParameterBlock->FirmwareVector)
 
 #endif /* _SPB_H_ */
Index: arclib/stdlib.c
===================================================================
RCS file: /cvs/arcboot/arclib/stdlib.c,v
retrieving revision 1.2
diff -u -u -r1.2 stdlib.c
--- arclib/stdlib.c	2001/03/20 02:55:56	1.2
+++ arclib/stdlib.c	2001/11/04 22:06:29
@@ -2,6 +2,7 @@
  * Copyright 1999 Silicon Graphics, Inc.
  */
 #include "stdlib.h"
+#include "string.h"
 #include "arc.h"
 
 
@@ -43,7 +44,7 @@
 }
 
 
-void *free(void *ptr)
+void free(void *ptr)
 {
 	if (ptr != NULL) {
 		Node *mem = ((Node *) ptr) - 1;
Index: arclib/stdlib.h
===================================================================
RCS file: /cvs/arcboot/arclib/stdlib.h,v
retrieving revision 1.2
diff -u -u -r1.2 stdlib.h
--- arclib/stdlib.h	2001/03/20 02:55:56	1.2
+++ arclib/stdlib.h	2001/11/04 22:06:29
@@ -8,7 +8,7 @@
 #include "types.h"
 
 extern void *malloc(size_t size);
-extern void *free(void *ptr);
+extern void free(void *ptr);
 extern void *realloc(void *ptr, size_t size);
 
 extern void arclib_malloc_add(ULONG start, ULONG size);
Index: arclib/string.c
===================================================================
RCS file: /cvs/arcboot/arclib/string.c,v
retrieving revision 1.2
diff -u -u -r1.2 string.c
--- arclib/string.c	2001/03/20 02:55:56	1.2
+++ arclib/string.c	2001/11/04 22:06:29
@@ -101,6 +101,7 @@
 
 	while (n-- > 0)
 		*(mem++) = (char) c;
+	return s;
 }
 
 void __bzero(char *p, int len)
Index: ext2load/Makefile
===================================================================
RCS file: /cvs/arcboot/ext2load/Makefile,v
retrieving revision 1.2
diff -u -u -r1.2 Makefile
--- ext2load/Makefile	2001/03/20 02:55:56	1.2
+++ ext2load/Makefile	2001/11/04 22:06:29
@@ -1,33 +1,37 @@
 #
 # Copyright 1999 Silicon Graphics, Inc.
+#           2001 Guido Guenther <agx@sigxcpu.org>
 #
 EXT2_OBJS = loader.o ext2io.o run.o
-LARC_OBJS = larc.o
+LARC_OBJS = larc.o run.o
 OBJECTS = $(EXT2_OBJS) $(LARC_OBJS)
 
 ARCLIBDIR = ../arclib
 ARCLIB = $(ARCLIBDIR)/libarc.a
 
-EXT2LIB = /usr/lib/libext2fs.a
+#EXT2LIB = /usr/lib/libext2fs.a
+EXT2LIB = ../../e2fslib/e2fsprogs-1.25/lib/libext2fs.a
 
-CFLAGS = -O -I$(ARCLIBDIR)
-# LD must be a an i386pe-capable ld
-# LD = /home/bh/bu291/bin/ld -m i386pe
-#LD = /gnu/bin/ld -m i386pe
+CFLAGS = -O -I$(ARCLIBDIR) -Wall -mno-abicalls -G 0 -fno-pic 
+ASFLAGS= -mno-abicalls -G 0 -fno-pic
+
+# uncomment for debugging
+CFLAGS+=-DDEBUG
+
 LD = ld
-LDFLAGS = -e _start
+LDFLAGS = -T ld.script
 
-TARGETS = ext2load.exe larc.exe
+TARGETS = ext2load larc
 
 all:  $(TARGETS)
 
-larc.exe:  larc.o run.o $(ARCLIB)
+larc:  $(LARC_OBJS) $(ARCLIB)
 	rm -f $@
-	$(LD) $(LDFLAGS) -o $@ larc.o run.o $(ARCLIB)
+	$(LD) $(LDFLAGS) -o $@ $(LARC_OBJS) $(ARCLIB)
 
-ext2load.exe:  $(EXT2_OBJS) $(ARCLIB)
+ext2load:  $(EXT2_OBJS) $(ARCLIB)
 	rm -f $@
 	$(LD) $(LDFLAGS) -o $@ $(EXT2_OBJS) $(EXT2LIB) $(ARCLIB)
 
 clean:
-	rm -f $(TARGETS) $(OBJECTS)
+	rm -f $(TARGETS) $(OBJECTS) tags
Index: ext2load/ext2io.c
===================================================================
RCS file: /cvs/arcboot/ext2load/ext2io.c,v
retrieving revision 1.2
diff -u -u -r1.2 ext2io.c
--- ext2load/ext2io.c	2001/03/20 02:55:56	1.2
+++ ext2load/ext2io.c	2001/11/04 22:06:29
@@ -2,6 +2,7 @@
  * extio.c
  *
  * Copyright 1999 Silicon Graphics, Inc.
+ *           2001 Guido Guenther <agx@sigxcpu.org>
  *
  * Derived from e2fsprogs lib/ext2fs/unix_io.c
  * Copyright (C) 1993, 1994, 1995 Theodore Ts'o.
@@ -91,6 +92,9 @@
 				status =
 				    ArcOpen((char *) name, priv->mode,
 					    &priv->fileID);
+				if( status ) {
+					status = EXT2_ET_BAD_DEVICE_NAME;
+				}
 			}
 		}
 	}
@@ -163,7 +167,6 @@
 {
 	struct arc_private_data *priv;
 	LARGEINTEGER position;
-	errcode_t status;
 
 	priv = (struct arc_private_data *) channel->private_data;
 	mul64(block, channel->block_size, &position);
@@ -196,8 +199,9 @@
 			status = (channel->read_error)
 			    (channel, block, count, buf, length, nread, status);
 		}
+	} else {
+		status = EXT2_ET_BAD_BLOCK_NUM;
 	}
-
 	return status;
 }
 
@@ -277,6 +281,7 @@
 
 		list = list->next;
 	}
+	return NULL;
 }
 
 
Index: ext2load/loader.c
===================================================================
RCS file: /cvs/arcboot/ext2load/loader.c,v
retrieving revision 1.2
diff -u -u -r1.2 loader.c
--- ext2load/loader.c	2001/03/20 02:55:56	1.2
+++ ext2load/loader.c	2001/11/04 22:06:30
@@ -1,6 +1,7 @@
 /*
  * Copyright 1999, 2001 Silicon Graphics, Inc.
  * Copyright 2001 Ralf Baechle
+ *           2001 Guido Guenther <agx@sigxcpu.org>
  */
 #include <stdarg.h>
 #include <stdio.h>
@@ -15,6 +16,8 @@
 #include <linux/ext2_fs.h>
 #include <ext2fs/ext2fs.h>
 
+#include <asm/addrspace.h>
+
 #define ANSI_CLEAR	"\033[2J"
 
 #define PAGE_SIZE	4096
@@ -29,7 +32,7 @@
  *  Reserve this memory for loading kernel
  *  Don't put loader structures there because they would be overwritten
  */
-ULONG reserve_base = 0x0100000;
+ULONG reserve_base = 0x88002000;
 ULONG reserve_size = 0x0200000;
 
 extern const char *ext2fs_strerror(long error);
@@ -68,20 +71,30 @@
 {
 	MEMORYDESCRIPTOR *current = NULL;
 	ULONG stack = (ULONG) & current;
+#ifdef DEBUG
+	printf("stack starts at: 0x%x\n", stack);
+#endif
 
 	current = ArcGetMemoryDescriptor(current);
+	if(! current ) {
+		Fatal("Can't find any valid memory descriptors!\n");
+	}
 	while (current != NULL) {
 		/*
 		 *  The spec says we should have an adjacent FreeContiguous
 		 *  memory area that includes our stack.  It would be much
 		 *  easier to just look for that and give it to malloc, but
-		 *  the 320 only shows FreeMemory areas, no FreeContiguous.
+		 *  the Indy only shows FreeMemory areas, no FreeContiguous.
 		 *  Oh well.
 		 */
 		if (current->Type == FreeMemory) {
-			ULONG start = current->BasePage * PAGE_SIZE;
+			ULONG start = KSEG0ADDR(current->BasePage * PAGE_SIZE);
 			ULONG end =
 			    start + (current->PageCount * PAGE_SIZE);
+#if DEBUG
+			printf("Free Memory(%u) segment found at (0x%x,0x%x).\n",
+					current->Type, start, end); 
+#endif
 
 			/* Leave some space for our stack */
 			if ((stack >= start) && (stack < end))
@@ -89,7 +102,6 @@
 				    (stack -
 				     (STACK_PAGES *
 				      PAGE_SIZE)) & ~(PAGE_SIZE - 1);
-
 			/* Don't use memory from reserved region */
 			if ((start >= reserve_base)
 			    && (start < (reserve_base + reserve_size)))
@@ -98,11 +110,14 @@
 			    && (end <=
 				(reserve_base + reserve_size))) end =
 				    reserve_base;
-
-			if (end > start)
+			if (end > start) {
+#ifdef DEBUG
+				printf("Adding %u bytes at 0x%x to the list of available memory\n", 
+						end-start, start);
+#endif
 				arclib_malloc_add(start, end - start);
+			}
 		}
-
 		current = ArcGetMemoryDescriptor(current);
 	}
 }
@@ -263,8 +279,8 @@
 	if (header.e_ident[EI_CLASS] != ELFCLASS32)
 		Fatal("Not a 32-bit file\n");
 
-	if (header.e_ident[EI_DATA] != ELFDATA2LSB)
-		Fatal("Not a little-endian file\n");
+	if (header.e_ident[EI_DATA] != ELFDATA2MSB)
+		Fatal("Not a big-endian file\n");
 
 	if (header.e_ident[EI_VERSION] != EV_CURRENT)
 		Fatal("Wrong ELF version\n");
@@ -290,7 +306,7 @@
 {
 	extern io_manager arc_io_manager;
 	ext2_filsys fs;
-	ino_t file_inode;
+	ext2_ino_t file_inode;
 	ext2_file_t file;
 	errcode_t status;
 
@@ -322,7 +338,7 @@
 void _start(LONG argc, CHAR * argv[], CHAR * envp[])
 {
 	/* Print identification */
-	printf(ANSI_CLEAR "\nARC Linux ext2fs loader, 07jun99\n\n");
+	printf(ANSI_CLEAR "\narcboot: ARC Linux ext2fs loader, 2001-11-03\n\n");
 
 	InitMalloc();
 

--Q68bSM7Ycu6FN28Q--
