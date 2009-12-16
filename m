Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2009 03:53:39 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:44905 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1495079AbZLPBfZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Dec 2009 02:35:25 +0100
Received: by yxe42 with SMTP id 42so595399yxe.22
        for <multiple recipients>; Tue, 15 Dec 2009 17:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=2oW+jsSLGs1RrRprMRkuMiH4eji65/QVOzzTs8IcIK0=;
        b=xwv8fYkTzLjDp4uFMZ5gbKBwo7zlC0lMqLbApqu4eiS+22eUbSRgISsrkssN7qmdBQ
         YkANNtERB0Qv9WP2WidV2Bwfk8krf6lAr59T7paWif108eQBqRmUrcV8SOFM7dDhH5gR
         OEw0B2BUp7VON/8W+yGFsVCNdRtGtSk2N79Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=i6Hu+zCNUv0bOysHbHoqdSmEyI1OTMM8aETSxb11mevnjOvxE8Wzl8dCSbo5trxCxf
         fDRbJEGtxgM6saV0CHJO1ANCfmvU/GqIthvMVNNcfumxZzFFMg2ByjGMA7Bh28QQrVsY
         IwOX57itboBqal0cK67ttJv/ApLndxWana8CM=
Received: by 10.150.37.36 with SMTP id k36mr607482ybk.335.1260927315287;
        Tue, 15 Dec 2009 17:35:15 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm175008ywh.16.2009.12.15.17.35.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Dec 2009 17:35:13 -0800 (PST)
Subject: Re: [PATCH] MIPS: Cleanup and Fixup of compressed kernel support
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
In-Reply-To: <1260456913-7822-1-git-send-email-wuzhangjin@gmail.com>
References: <1260456913-7822-1-git-send-email-wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 16 Dec 2009 09:34:34 +0800
Message-ID: <1260927274.1935.1.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25407
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

Is it possible to upstream this patch for 2.6.33? this is urgent,
thanks!

Best Regards,
	Wu Zhangjin

On Thu, 2009-12-10 at 22:55 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Changes:
> 
>     o Remove the .initrd section
>     the initrd section is put in vmlinux, not need to handle it here.
> 
>     o Move .MIPS.options, .options, .pdr, .reginfo, .comment, .note from
>     Makefile to the /DSICARD/ of ld.script
>     If not move the .MIPS.options, the kernel compiled with gcc
>     3.4.6 will not boot.
> 
>     o Clean up the file format.
>     o Remove several other un-needed sections.
> 
> Have tested this patch with gcc 3.4.6 and gcc 4.4.1, and also with,
> without the initrd file system. All of them works well.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile     |    9 +-
>  arch/mips/boot/compressed/decompress.c |   10 --
>  arch/mips/boot/compressed/ld.script    |  195 +++++++++-----------------------
>  3 files changed, 59 insertions(+), 155 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index e27f40b..671d344 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -56,7 +56,7 @@ $(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
>  LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
>  vmlinuz: $(src)/ld.script $(obj-y) $(obj)/piggy.o
>  	$(call if_changed,ld)
> -	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) -R .comment -R .stab -R .stabstr -R .initrd -R .sysmap $@
> +	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) $@
>  
>  #
>  # Some DECstations need all possible sections of an ECOFF executable
> @@ -84,14 +84,11 @@ vmlinuz.ecoff: $(obj)/../elf2ecoff $(VMLINUZ)
>  $(obj)/../elf2ecoff: $(src)/../elf2ecoff.c
>  	$(Q)$(HOSTCC) -o $@ $^
>  
> -drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
> -strip-flags	= $(addprefix --remove-section=,$(drop-sections))
> -
> -OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary $(strip-flags)
> +OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary
>  vmlinuz.bin: vmlinuz
>  	$(call if_changed,objcopy)
>  
> -OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec $(strip-flags)
> +OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
>  vmlinuz.srec: vmlinuz
>  	$(call if_changed,objcopy)
>  
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index 67330c2..e48fd72 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -28,8 +28,6 @@ char *zimage_start;
>  
>  /* The linker tells us where the image is. */
>  extern unsigned char __image_begin, __image_end;
> -extern unsigned char __ramdisk_begin, __ramdisk_end;
> -unsigned long initrd_size;
>  
>  /* debug interfaces  */
>  extern void puts(const char *s);
> @@ -102,14 +100,6 @@ void decompress_kernel(unsigned long boot_heap_start)
>  	puthex((unsigned long)(zimage_size + zimage_start));
>  	puts("\n");
>  
> -	if (initrd_size) {
> -		puts("initrd at:     ");
> -		puthex((unsigned long)(&__ramdisk_begin));
> -		puts(" ");
> -		puthex((unsigned long)(&__ramdisk_end));
> -		puts("\n");
> -	}
> -
>  	/* this area are prepared for mallocing when decompressing */
>  	free_mem_ptr = boot_heap_start;
>  	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
> diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
> index 29e9f4c..0b3fc82 100644
> --- a/arch/mips/boot/compressed/ld.script
> +++ b/arch/mips/boot/compressed/ld.script
> @@ -1,150 +1,67 @@
> +/*
> + * ld.script for compressed kernel support of MIPS
> + *
> + * Copyright (C) 2009 Lemote Inc.
> + * Author: Wu Zhangjin <wuzj@lemote.com>
> + */
> +
>  OUTPUT_ARCH(mips)
>  ENTRY(start)
>  SECTIONS
>  {
> -  /* Read-only sections, merged into text segment: */
> -  .init          : { *(.init)		} =0
> -  .text      :
> -  {
> -    _ftext = . ;
> -    *(.text)
> -    *(.rodata)
> -    *(.rodata1)
> -    /* .gnu.warning sections are handled specially by elf32.em.  */
> -    *(.gnu.warning)
> -  } =0
> -  .kstrtab : { *(.kstrtab) }
> -
> -  . = ALIGN(16);		/* Exception table */
> -  __start___ex_table = .;
> -  __ex_table : { *(__ex_table) }
> -  __stop___ex_table = .;
> -
> -  __start___dbe_table = .;	/* Exception table for data bus errors */
> -  __dbe_table : { *(__dbe_table) }
> -  __stop___dbe_table = .;
> -
> -  __start___ksymtab = .;	/* Kernel symbol table */
> -  __ksymtab : { *(__ksymtab) }
> -  __stop___ksymtab = .;
> -
> -  _etext = .;
> -
> -  . = ALIGN(8192);
> -  .data.init_task : { *(.data.init_task) }
> -
> -  /* Startup code */
> -  . = ALIGN(4096);
> -  __init_begin = .;
> -  .text.init : { *(.text.init) }
> -  .data.init : { *(.data.init) }
> -  . = ALIGN(16);
> -  __setup_start = .;
> -  .setup.init : { *(.setup.init) }
> -  __setup_end = .;
> -  __initcall_start = .;
> -  .initcall.init : { *(.initcall.init) }
> -  __initcall_end = .;
> -  . = ALIGN(4096);	/* Align double page for init_task_union */
> -  __init_end = .;
> -
> -  . = ALIGN(4096);
> -  .data.page_aligned : { *(.data.idt) }
> -
> -  . = ALIGN(32);
> -  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
> +	/* . = VMLINUZ_LOAD_ADDRESS */
> +	/* read-only */
> +	_text = .;	/* Text and read-only data */
> +	.text	: {
> +		_ftext = . ;
> +		*(.text)
> +		*(.rodata)
> +	} = 0
> +	_etext = .;	/* End of text section */
>  
> -  .fini      : { *(.fini)    } =0
> -  .reginfo : { *(.reginfo) }
> -  /* Adjust the address for the data segment.  We want to adjust up to
> -     the same address within the page on the next page up.  It would
> -     be more correct to do this:
> -       . = .;
> -     The current expression does not correctly handle the case of a
> -     text segment ending precisely at the end of a page; it causes the
> -     data segment to skip a page.  The above expression does not have
> -     this problem, but it will currently (2/95) cause BFD to allocate
> -     a single segment, combining both text and data, for this case.
> -     This will prevent the text segment from being shared among
> -     multiple executions of the program; I think that is more
> -     important than losing a page of the virtual address space (note
> -     that no actual memory is lost; the page which is skipped can not
> -     be referenced).  */
> -  . = .;
> -  .data    :
> -  {
> -    _fdata = . ;
> -    *(.data)
> +	/* writable */
> +	.data	: {	/* Data */
> +		_fdata = . ;
> +		*(.data)
> +		/* Put the compressed image here, so bss is on the end. */
> +		__image_begin = .;
> +		*(.image)
> +		__image_end = .;
> +		CONSTRUCTORS
> +	}
> +  	.sdata	: { *(.sdata) }
> +  	. = ALIGN(4);
> +	_edata  =  .;	/* End of data section */
>  
> -   /* Put the compressed image here, so bss is on the end. */
> -   __image_begin = .;
> -   *(.image)
> -   __image_end = .;
> -   /* Align the initial ramdisk image (INITRD) on page boundaries. */
> -   . = ALIGN(4096);
> -   __ramdisk_begin = .;
> -   *(.initrd)
> -   __ramdisk_end = .;
> -   . = ALIGN(4096);
> +	/* BSS */
> +	__bss_start = .;
> +	_fbss = .;
> +	.sbss	: { *(.sbss) *(.scommon) }
> +	.bss	: {
> +		*(.dynbss)
> +		*(.bss)
> +		*(COMMON)
> +	}
> +	.  = ALIGN(4);
> +	_end = . ;
>  
> -    CONSTRUCTORS
> -  }
> -  .data1   : { *(.data1) }
> -  _gp = . + 0x8000;
> -  .lit8 : { *(.lit8) }
> -  .lit4 : { *(.lit4) }
> -  .ctors         : { *(.ctors)   }
> -  .dtors         : { *(.dtors)   }
> -  .got           : { *(.got.plt) *(.got) }
> -  .dynamic       : { *(.dynamic) }
> -  /* We want the small data sections together, so single-instruction offsets
> -     can access them all, and initialized data all before uninitialized, so
> -     we can shorten the on-disk segment size.  */
> -  .sdata     : { *(.sdata) }
> -  . = ALIGN(4);
> -  _edata  =  .;
> -  PROVIDE (edata = .);
> +	/* These are needed for ELF backends which have not yet been converted
> +	 * to the new style linker.  */
>  
> -  __bss_start = .;
> -  _fbss = .;
> -  .sbss      : { *(.sbss) *(.scommon) }
> -  .bss       :
> -  {
> -   *(.dynbss)
> -   *(.bss)
> -   *(COMMON)
> -   .  = ALIGN(4);
> -  _end = . ;
> -  PROVIDE (end = .);
> -  }
> +	.stab 0 : { *(.stab) }
> +	.stabstr 0 : { *(.stabstr) }
>  
> -  /* Sections to be discarded */
> -  /DISCARD/ :
> -  {
> -        *(.text.exit)
> -        *(.data.exit)
> -        *(.exitcall.exit)
> -  }
> +	/* These must appear regardless of  .  */
> +	.gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
> +	.gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
>  
> -  /* This is the MIPS specific mdebug section.  */
> -  .mdebug : { *(.mdebug) }
> -  /* These are needed for ELF backends which have not yet been
> -     converted to the new style linker.  */
> -  .stab 0 : { *(.stab) }
> -  .stabstr 0 : { *(.stabstr) }
> -  /* DWARF debug sections.
> -     Symbols in the .debug DWARF section are relative to the beginning of the
> -     section so we begin .debug at 0.  It's not clear yet what needs to happen
> -     for the others.   */
> -  .debug          0 : { *(.debug) }
> -  .debug_srcinfo  0 : { *(.debug_srcinfo) }
> -  .debug_aranges  0 : { *(.debug_aranges) }
> -  .debug_pubnames 0 : { *(.debug_pubnames) }
> -  .debug_sfnames  0 : { *(.debug_sfnames) }
> -  .line           0 : { *(.line) }
> -  /* These must appear regardless of  .  */
> -  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
> -  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
> -  .comment : { *(.comment) }
> -  .note : { *(.note) }
> +	/* Sections to be discarded */
> +	/DISCARD/	: {
> +		*(.MIPS.options)
> +		*(.options)
> +		*(.pdr)
> +		*(.reginfo)
> +		*(.comment)
> +		*(.note)
> +	}
>  }
