Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2007 22:34:39 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:48047 "EHLO pasmtpB.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20022322AbXIOVea (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2007 22:34:30 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id A1320E3251B;
	Sat, 15 Sep 2007 23:34:27 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 979A7580D2; Sat, 15 Sep 2007 23:35:53 +0200 (CEST)
Date:	Sat, 15 Sep 2007 23:35:53 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips: beautify vmlinux.lds
Message-ID: <20070915213553.GA15463@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

Introduce a consistent style for vmlinux.lds.
This style will be consitent with all other arch's - soon.

In addition:
- Moved a few labels inside brackets for the sections they specify
  to prevent that linker alignmnet made them point before the section start

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
Patch is not even buildtested due to lack of a toolchain :-(

	Sam

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 60bbaec..84f9a4c 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -6,161 +6,202 @@
 OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 jiffies = JIFFIES;
+
 SECTIONS
 {
 #ifdef CONFIG_BOOT_ELF64
-  /* Read-only sections, merged into text segment: */
-  /* . = 0xc000000000000000; */
+	/* Read-only sections, merged into text segment: */
+	/* . = 0xc000000000000000; */
 
-  /* This is the value for an Origin kernel, taken from an IRIX kernel.  */
-  /* . = 0xc00000000001c000; */
+	/* This is the value for an Origin kernel, taken from an IRIX kernel.  */
+	/* . = 0xc00000000001c000; */
 
-  /* Set the vaddr for the text segment to a value
-        >= 0xa800 0000 0001 9000 if no symmon is going to configured
-        >= 0xa800 0000 0030 0000 otherwise  */
+	/* Set the vaddr for the text segment to a value
+	 *   >= 0xa800 0000 0001 9000 if no symmon is going to configured
+	 *   >= 0xa800 0000 0030 0000 otherwise
+	 */
 
-  /* . = 0xa800000000300000; */
-  /* . = 0xa800000000300000; */
-  . = 0xffffffff80300000;
+	/* . = 0xa800000000300000; */
+	/* . = 0xa800000000300000; */
+	. = 0xffffffff80300000;
 #endif
-  . = LOADADDR;
-  /* read-only */
-  _text = .;			/* Text and read-only data */
-  .text : {
-    TEXT_TEXT
-    SCHED_TEXT
-    LOCK_TEXT
-    *(.fixup)
-    *(.gnu.warning)
-  } =0
-
-  _etext = .;			/* End of text section */
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
-  RODATA
-
-  /* writeable */
-  .data : {			/* Data */
-    . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
-    /*
-     * This ALIGN is needed as a workaround for a bug a gcc bug upto 4.1 which
-     * limits the maximum alignment to at most 32kB and results in the following
-     * warning:
-     *
-     *  CC      arch/mips/kernel/init_task.o
-     * arch/mips/kernel/init_task.c:30: warning: alignment of ‘init_thread_union’
-     * is greater than maximum object file alignment.  Using 32768
-     */
-    . = ALIGN(_PAGE_SIZE);
-    *(.data.init_task)
-
-    DATA_DATA
-
-    CONSTRUCTORS
-  }
-  _gp = . + 0x8000;
-  .lit8 : { *(.lit8) }
-  .lit4 : { *(.lit4) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-
-  . = ALIGN(_PAGE_SIZE);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(_PAGE_SIZE);
-  __nosave_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  _edata =  .;			/* End of data section */
-
-  /* will be freed after init */
-  . = ALIGN(_PAGE_SIZE);		/* Init code and data */
-  __init_begin = .;
-  .init.text : {
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  .init.data : { *(.init.data) }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-
-  __initcall_start = .;
-  .initcall.init : {
-	INITCALLS
-  }
-  __initcall_end = .;
-
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-  SECURITY_INIT
-    /* .exit.text is discarded at runtime, not link time, to deal with
-     references from .rodata */
-  .exit.text : { *(.exit.text) }
-  .exit.data : { *(.exit.data) }
+	. = LOADADDR;
+	/* read-only */
+	_text = .;	/* Text and read-only data */
+	.text : {
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		*(.fixup)
+		*(.gnu.warning)
+	} =0
+	_etext = .;	/* End of text section */
+
+	/* Exception table */
+	. = ALIGN(16);
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
+
+	/* Exception table for data bus errors */
+	__dbe_table : {
+		__start___dbe_table = .;
+		*(__dbe_table)
+		__stop___dbe_table = .;
+	}
+	RODATA
+
+	/* writeable */
+	.data : {	/* Data */
+	  . = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
+	  /*
+	   * This ALIGN is needed as a workaround for a bug a gcc bug upto 4.1 which
+	   * limits the maximum alignment to at most 32kB and results in the following
+	   * warning:
+	   *
+	   *  CC      arch/mips/kernel/init_task.o
+	   * arch/mips/kernel/init_task.c:30: warning: alignment of ‘init_thread_union’
+	   * is greater than maximum object file alignment.  Using 32768
+	   */
+	  . = ALIGN(_PAGE_SIZE);
+	  *(.data.init_task)
+
+	  DATA_DATA
+	  CONSTRUCTORS
+	}
+	_gp = . + 0x8000;
+	.lit8 : {
+		*(.lit8)
+	}
+	.lit4 : {
+		*(.lit4)
+	}
+	/* We want the small data sections together, so single-instruction offsets
+	   can access them all, and initialized data all before uninitialized, so
+	   we can shorten the on-disk segment size.  */
+	.sdata : {
+		*(.sdata)
+	}
+
+	. = ALIGN(_PAGE_SIZE);
+	.data_nosave : {
+		__nosave_begin = .;
+		*(.data.nosave)
+	}
+	. = ALIGN(_PAGE_SIZE);
+	__nosave_end = .;
+
+	. = ALIGN(32);
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
+	_edata =  .;			/* End of data section */
+
+	/* will be freed after init */
+	. = ALIGN(_PAGE_SIZE);		/* Init code and data */
+	__init_begin = .;
+	.init.text : {
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+	.init.data : {
+		*(.init.data)
+	}
+	. = ALIGN(16);
+	.init.setup : {
+		__setup_start = .;
+		*(.init.setup)
+		__setup_end = .;
+	}
+
+	.initcall.init : {
+		__initcall_start = .;
+		INITCALLS
+		__initcall_end = .;
+	}
+
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+	SECURITY_INIT
+
+	/* .exit.text is discarded at runtime, not link time, to deal with
+	 * references from .rodata
+	 */
+	.exit.text : {
+		*(.exit.text)
+	}
+	.exit.data : {
+		*(.exit.data)
+	}
 #if defined(CONFIG_BLK_DEV_INITRD)
-  . = ALIGN(_PAGE_SIZE);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
+	. = ALIGN(_PAGE_SIZE);
+	.init.ramfs : {
+		__initramfs_start = .;
+		*(.init.ramfs)
+		__initramfs_end = .;
+	}
 #endif
-  PERCPU(_PAGE_SIZE)
-  . = ALIGN(_PAGE_SIZE);
-  __init_end = .;
-  /* freed after init ends here */
-
-  __bss_start = .;		/* BSS */
-  .sbss      : {
-    *(.sbss)
-    *(.scommon)
-  }
-  .bss : {
-    *(.bss)
-    *(COMMON)
-  }
-  __bss_stop = .;
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-        *(.exitcall.exit)
-
-	/* ABI crap starts here */
-	*(.MIPS.options)
-	*(.options)
-	*(.pdr)
-	*(.reginfo)
-  }
-
-  /* These mark the ABI of the kernel for debuggers.  */
-  .mdebug.abi32 : { KEEP(*(.mdebug.abi32)) }
-  .mdebug.abi64 : { KEEP(*(.mdebug.abi64)) }
-
-  /* This is the MIPS specific mdebug section.  */
-  .mdebug : { *(.mdebug) }
-
-  STABS_DEBUG
-
-  DWARF_DEBUG
-
-  /* These must appear regardless of  .  */
-  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
-  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
-  .note : { *(.note) }
+	PERCPU(_PAGE_SIZE)
+	. = ALIGN(_PAGE_SIZE);
+	__init_end = .;
+	/* freed after init ends here */
+
+	__bss_start = .;	/* BSS */
+	.sbss  : {
+		*(.sbss)
+		*(.scommon)
+	}
+	.bss : {
+		*(.bss)
+		*(COMMON)
+	}
+	__bss_stop = .;
+
+	_end = . ;
+
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		*(.exitcall.exit)
+
+		/* ABI crap starts here */
+		*(.MIPS.options)
+		*(.options)
+		*(.pdr)
+		*(.reginfo)
+	}
+
+	/* These mark the ABI of the kernel for debuggers.  */
+	.mdebug.abi32 : {
+		KEEP(*(.mdebug.abi32))
+	}
+	.mdebug.abi64 : {
+		KEEP(*(.mdebug.abi64))
+	}
+
+	/* This is the MIPS specific mdebug section.  */
+	.mdebug : {
+		*(.mdebug)
+	}
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	/* These must appear regardless of  .  */
+	.gptab.sdata : {
+		*(.gptab.data)
+		*(.gptab.sdata)
+	}
+	.gptab.sbss : {
+		*(.gptab.bss)
+		*(.gptab.sbss)
+	}
+	.note : {
+		*(.note)
+	}
 }
