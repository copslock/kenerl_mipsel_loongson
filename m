Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2009 15:55:49 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:61262 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492955AbZLJOzj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2009 15:55:39 +0100
Received: by pwj1 with SMTP id 1so2300911pwj.24
        for <multiple recipients>; Thu, 10 Dec 2009 06:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=4KUHlP1P7U+R6ZnGSESxCWuZeidYz2GXE0ETnQABMmM=;
        b=LLggD2B0IUGH6v902qZrFqL2jRHbDznjvpd9XkkNB6863GUdpLmUu71T1phD/mm5FX
         hUuKkeGrx5qZuu32ZJP4M0bQEHuIo/vrdN28Y3tf5k8esOayjmLJ/bnjkKf9cxUTWsjQ
         DBRI8BbTXwhrvTFvISG6XkBry8PW4MkRmLG+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lx3ZA/NNzHHDXzJmwTy3Iti5hrPTfBgv5sdez4uBtu75qkBBgS+Bh2lueRWc/e+6Tn
         6/VGq7WdS6Ha/oF2S5yTqGXgpOeZU5+3Mg8cbcnOuRIiCeEOAw/+rLccNO/PxKHspq0P
         QDdSZufkjC5lnejK5DNCIetQOfiHkBS5QJFW4=
Received: by 10.141.125.6 with SMTP id c6mr24691rvn.16.1260456931117;
        Thu, 10 Dec 2009 06:55:31 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm973613pzk.0.2009.12.10.06.55.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Dec 2009 06:55:30 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: Cleanup and Fixup of compressed kernel support
Date:   Thu, 10 Dec 2009 22:55:13 +0800
Message-Id: <1260456913-7822-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes:

    o Remove the .initrd section
    the initrd section is put in vmlinux, not need to handle it here.

    o Move .MIPS.options, .options, .pdr, .reginfo, .comment, .note from
    Makefile to the /DSICARD/ of ld.script
    If not move the .MIPS.options, the kernel compiled with gcc
    3.4.6 will not boot.

    o Clean up the file format.
    o Remove several other un-needed sections.

Have tested this patch with gcc 3.4.6 and gcc 4.4.1, and also with,
without the initrd file system. All of them works well.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/Makefile     |    9 +-
 arch/mips/boot/compressed/decompress.c |   10 --
 arch/mips/boot/compressed/ld.script    |  195 +++++++++-----------------------
 3 files changed, 59 insertions(+), 155 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e27f40b..671d344 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -56,7 +56,7 @@ $(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
 LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
 vmlinuz: $(src)/ld.script $(obj-y) $(obj)/piggy.o
 	$(call if_changed,ld)
-	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) -R .comment -R .stab -R .stabstr -R .initrd -R .sysmap $@
+	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
 
 #
 # Some DECstations need all possible sections of an ECOFF executable
@@ -84,14 +84,11 @@ vmlinuz.ecoff: $(obj)/../elf2ecoff $(VMLINUZ)
 $(obj)/../elf2ecoff: $(src)/../elf2ecoff.c
 	$(Q)$(HOSTCC) -o $@ $^
 
-drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
-strip-flags	= $(addprefix --remove-section=,$(drop-sections))
-
-OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary $(strip-flags)
+OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary
 vmlinuz.bin: vmlinuz
 	$(call if_changed,objcopy)
 
-OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec $(strip-flags)
+OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
 	$(call if_changed,objcopy)
 
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index 67330c2..e48fd72 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -28,8 +28,6 @@ char *zimage_start;
 
 /* The linker tells us where the image is. */
 extern unsigned char __image_begin, __image_end;
-extern unsigned char __ramdisk_begin, __ramdisk_end;
-unsigned long initrd_size;
 
 /* debug interfaces  */
 extern void puts(const char *s);
@@ -102,14 +100,6 @@ void decompress_kernel(unsigned long boot_heap_start)
 	puthex((unsigned long)(zimage_size + zimage_start));
 	puts("\n");
 
-	if (initrd_size) {
-		puts("initrd at:     ");
-		puthex((unsigned long)(&__ramdisk_begin));
-		puts(" ");
-		puthex((unsigned long)(&__ramdisk_end));
-		puts("\n");
-	}
-
 	/* this area are prepared for mallocing when decompressing */
 	free_mem_ptr = boot_heap_start;
 	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
index 29e9f4c..0b3fc82 100644
--- a/arch/mips/boot/compressed/ld.script
+++ b/arch/mips/boot/compressed/ld.script
@@ -1,150 +1,67 @@
+/*
+ * ld.script for compressed kernel support of MIPS
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ */
+
 OUTPUT_ARCH(mips)
 ENTRY(start)
 SECTIONS
 {
-  /* Read-only sections, merged into text segment: */
-  .init          : { *(.init)		} =0
-  .text      :
-  {
-    _ftext = . ;
-    *(.text)
-    *(.rodata)
-    *(.rodata1)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-  } =0
-  .kstrtab : { *(.kstrtab) }
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  __start___dbe_table = .;	/* Exception table for data bus errors */
-  __dbe_table : { *(__dbe_table) }
-  __stop___dbe_table = .;
-
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  _etext = .;
-
-  . = ALIGN(8192);
-  .data.init_task : { *(.data.init_task) }
-
-  /* Startup code */
-  . = ALIGN(4096);
-  __init_begin = .;
-  .text.init : { *(.text.init) }
-  .data.init : { *(.data.init) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .setup.init : { *(.setup.init) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : { *(.initcall.init) }
-  __initcall_end = .;
-  . = ALIGN(4096);	/* Align double page for init_task_union */
-  __init_end = .;
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+	/* . = VMLINUZ_LOAD_ADDRESS */
+	/* read-only */
+	_text = .;	/* Text and read-only data */
+	.text	: {
+		_ftext = . ;
+		*(.text)
+		*(.rodata)
+	} = 0
+	_etext = .;	/* End of text section */
 
-  .fini      : { *(.fini)    } =0
-  .reginfo : { *(.reginfo) }
-  /* Adjust the address for the data segment.  We want to adjust up to
-     the same address within the page on the next page up.  It would
-     be more correct to do this:
-       . = .;
-     The current expression does not correctly handle the case of a
-     text segment ending precisely at the end of a page; it causes the
-     data segment to skip a page.  The above expression does not have
-     this problem, but it will currently (2/95) cause BFD to allocate
-     a single segment, combining both text and data, for this case.
-     This will prevent the text segment from being shared among
-     multiple executions of the program; I think that is more
-     important than losing a page of the virtual address space (note
-     that no actual memory is lost; the page which is skipped can not
-     be referenced).  */
-  . = .;
-  .data    :
-  {
-    _fdata = . ;
-    *(.data)
+	/* writable */
+	.data	: {	/* Data */
+		_fdata = . ;
+		*(.data)
+		/* Put the compressed image here, so bss is on the end. */
+		__image_begin = .;
+		*(.image)
+		__image_end = .;
+		CONSTRUCTORS
+	}
+  	.sdata	: { *(.sdata) }
+  	. = ALIGN(4);
+	_edata  =  .;	/* End of data section */
 
-   /* Put the compressed image here, so bss is on the end. */
-   __image_begin = .;
-   *(.image)
-   __image_end = .;
-   /* Align the initial ramdisk image (INITRD) on page boundaries. */
-   . = ALIGN(4096);
-   __ramdisk_begin = .;
-   *(.initrd)
-   __ramdisk_end = .;
-   . = ALIGN(4096);
+	/* BSS */
+	__bss_start = .;
+	_fbss = .;
+	.sbss	: { *(.sbss) *(.scommon) }
+	.bss	: {
+		*(.dynbss)
+		*(.bss)
+		*(COMMON)
+	}
+	.  = ALIGN(4);
+	_end = . ;
 
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  _gp = . + 0x8000;
-  .lit8 : { *(.lit8) }
-  .lit4 : { *(.lit4) }
-  .ctors         : { *(.ctors)   }
-  .dtors         : { *(.dtors)   }
-  .got           : { *(.got.plt) *(.got) }
-  .dynamic       : { *(.dynamic) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  . = ALIGN(4);
-  _edata  =  .;
-  PROVIDE (edata = .);
+	/* These are needed for ELF backends which have not yet been converted
+	 * to the new style linker.  */
 
-  __bss_start = .;
-  _fbss = .;
-  .sbss      : { *(.sbss) *(.scommon) }
-  .bss       :
-  {
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-   .  = ALIGN(4);
-  _end = . ;
-  PROVIDE (end = .);
-  }
+	.stab 0 : { *(.stab) }
+	.stabstr 0 : { *(.stabstr) }
 
-  /* Sections to be discarded */
-  /DISCARD/ :
-  {
-        *(.text.exit)
-        *(.data.exit)
-        *(.exitcall.exit)
-  }
+	/* These must appear regardless of  .  */
+	.gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
+	.gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
 
-  /* This is the MIPS specific mdebug section.  */
-  .mdebug : { *(.mdebug) }
-  /* These are needed for ELF backends which have not yet been
-     converted to the new style linker.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  /* DWARF debug sections.
-     Symbols in the .debug DWARF section are relative to the beginning of the
-     section so we begin .debug at 0.  It's not clear yet what needs to happen
-     for the others.   */
-  .debug          0 : { *(.debug) }
-  .debug_srcinfo  0 : { *(.debug_srcinfo) }
-  .debug_aranges  0 : { *(.debug_aranges) }
-  .debug_pubnames 0 : { *(.debug_pubnames) }
-  .debug_sfnames  0 : { *(.debug_sfnames) }
-  .line           0 : { *(.line) }
-  /* These must appear regardless of  .  */
-  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
-  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
-  .comment : { *(.comment) }
-  .note : { *(.note) }
+	/* Sections to be discarded */
+	/DISCARD/	: {
+		*(.MIPS.options)
+		*(.options)
+		*(.pdr)
+		*(.reginfo)
+		*(.comment)
+		*(.note)
+	}
 }
-- 
1.6.2.1
