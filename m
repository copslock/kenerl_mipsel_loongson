Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5D8BHnC024481
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 13 Jun 2002 01:11:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5D8BHq9024480
	for linux-mips-outgoing; Thu, 13 Jun 2002 01:11:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from msr.hinet.net (msr96.hinet.net [168.95.4.196])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5D8AunC024476
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 01:10:57 -0700
Received: from sam (61-220-89-134.HINET-IP.hinet.net [61.220.89.134])
	by msr.hinet.net (8.9.3/8.9.3) with SMTP id QAA05012
	for <linux-mips@oss.sgi.com>; Thu, 13 Jun 2002 16:13:26 +0800 (CST)
Message-ID: <004801c212b2$295c7900$780411ac@sam>
From: "Sam" <iskoo@ms45.hinet.net>
To: <linux-mips@oss.sgi.com>
Subject: # ld.script syntax
Date: Thu, 13 Jun 2002 16:13:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi everybody,

I try to find the relation about the setup of ramdisk initrd
>From the sample of Philp Nino, I found the ld.script.in on /arch/mips/
But I do not understand the syntax of ld script,
Does anybody tell me where to find the relevent document to understand the
file,

thanks all,
--Sam


====
OUTPUT_ARCH(mips)
ENTRY(kernel_entry)
SECTIONS
{
  /* Read-only sections, merged into text segment: */
  . = @@LOADADDR@@;
  .init          : { *(.init)  } =0
  .text      :
  {
    _ftext = . ;
    *(.text)
    *(.rodata)
    *(.rodata1)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
  } =0
  .kstrtab : { *(.kstrtab) }

  . = ALIGN(16);  /* Exception table */
  __start___ex_table = .;
  __ex_table : { *(__ex_table) }
  __stop___ex_table = .;

  __start___dbe_table = .; /* Exception table for data bus errors */
  __dbe_table : { *(__dbe_table) }
  __stop___dbe_table = .;

  __start___ksymtab = .; /* Kernel symbol table */
  __ksymtab : { *(__ksymtab) }
  __stop___ksymtab = .;

  _etext = .;

  . = ALIGN(8192);
  .data.init_task : { *(.data.init_task) }

  /* Startup code */
  . = ALIGN(4096);
  __init_begin = .;
  .text.init : { *(.text.init) }
  .data.init : { *(.data.init) }
  . = ALIGN(16);
  __setup_start = .;
  .setup.init : { *(.setup.init) }
  __setup_end = .;
  __initcall_start = .;
  .initcall.init : { *(.initcall.init) }
  __initcall_end = .;
  . = ALIGN(4096); /* Align double page for init_task_union */
  __init_end = .;

  . = ALIGN(4096);
  .data.page_aligned : { *(.data.idt) }

  . = ALIGN(32);
  .data.cacheline_aligned : { *(.data.cacheline_aligned) }

  .fini      : { *(.fini)    } =0
  .reginfo : { *(.reginfo) }
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  It would
     be more correct to do this:
       . = .;
     The current expression does not correctly handle the case of a
     text segment ending precisely at the end of a page; it causes the
     data segment to skip a page.  The above expression does not have
     this problem, but it will currently (2/95) cause BFD to allocate
     a single segment, combining both text and data, for this case.
     This will prevent the text segment from being shared among
     multiple executions of the program; I think that is more
     important than losing a page of the virtual address space (note
     that no actual memory is lost; the page which is skipped can not
     be referenced).  */
  . = .;
  .data    :
  {
    _fdata = . ;
    *(.data)

   /* Align the initial ramdisk image (INITRD) on page boundaries. */
   . = ALIGN(4096);
   __rd_start = .;
   *(.initrd)
   __rd_end = .;
   . = ALIGN(4096);

    CONSTRUCTORS
  }
  .data1   : { *(.data1) }
  _gp = . + 0x8000;
  .lit8 : { *(.lit8) }
  .lit4 : { *(.lit4) }
  .ctors         : { *(.ctors)   }
  .dtors         : { *(.dtors)   }
  .got           : { *(.got.plt) *(.got) }
  .dynamic       : { *(.dynamic) }
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  .sdata     : { *(.sdata) }
  . = ALIGN(4);
  _edata  =  .;
  PROVIDE (edata = .);

  __bss_start = .;
  _fbss = .;
  .sbss      : { *(.sbss) *(.scommon) }
  .bss       :
  {
   *(.dynbss)
   *(.bss)
   *(COMMON)
   .  = ALIGN(4);
  _end = . ;
  PROVIDE (end = .);
  }

  /* Sections to be discarded */
  /DISCARD/ :
  {
        *(.text.exit)
        *(.data.exit)
        *(.exitcall.exit)
  }

  /* This is the MIPS specific mdebug section.  */
  .mdebug : { *(.mdebug) }
  /* These are needed for ELF backends which have not yet been
     converted to the new style linker.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  /* DWARF debug sections.
     Symbols in the .debug DWARF section are relative to the beginning of
the
     section so we begin .debug at 0.  It's not clear yet what needs to
happen
     for the others.   */
  .debug          0 : { *(.debug) }
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  .line           0 : { *(.line) }
  /* These must appear regardless of  .  */
  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
  .comment : { *(.comment) }
  .note : { *(.note) }
}
====
