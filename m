Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2009 23:02:33 +0200 (CEST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54578 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493873AbZGaVCD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2009 23:02:03 +0200
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6VKwSsv010919;
	Fri, 31 Jul 2009 16:58:29 -0400 (EDT)
Received: from localhost (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as tabbott@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6VKwSTo019250;
	Fri, 31 Jul 2009 16:58:28 -0400 (EDT)
From:	Tim Abbott <tabbott@ksplice.com>
To:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:	Sam Ravnborg <sam@ravnborg.org>,
	Anders Kaseorg <andersk@ksplice.com>,
	Nelson Elhage <nelhage@ksplice.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3/3] mips: clean up linker script using new linker script macros.
Date:	Fri, 31 Jul 2009 16:58:19 -0400
Message-Id: <1249073899-30145-3-git-send-email-tabbott@ksplice.com>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1249073899-30145-1-git-send-email-tabbott@ksplice.com>
References: <1249073899-30145-1-git-send-email-tabbott@ksplice.com>
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tabbott@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tabbott@ksplice.com
Precedence: bulk
X-list: linux-mips

From: Nelson Elhage <nelhage@ksplice.com>

This patch results in fewer output sections and in some data being
reordered, but should have no functional impact.

Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/vmlinux.lds.S |   86 ++++------------------------------------
 1 files changed, 8 insertions(+), 78 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 6bfdb2e..a6d2c7a 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -43,13 +43,7 @@ SECTIONS
 	} :text = 0
 	_etext = .;	/* End of text section */
 
-	/* Exception table */
-	. = ALIGN(16);
-	__ex_table : {
-		__start___ex_table = .;
-		*(__ex_table)
-		__stop___ex_table = .;
-	}
+	EXCEPTION_TABLE(16)
 
 	/* Exception table for data bus errors */
 	__dbe_table : {
@@ -66,20 +60,10 @@ SECTIONS
 	/* writeable */
 	.data : {	/* Data */
 		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
-		/*
-		 * This ALIGN is needed as a workaround for a bug a
-		 * gcc bug upto 4.1 which limits the maximum alignment
-		 * to at most 32kB and results in the following
-		 * warning:
-		 *
-		 *  CC      arch/mips/kernel/init_task.o
-		 * arch/mips/kernel/init_task.c:30: warning: alignment
-		 * of ‘init_thread_union’ is greater than maximum
-		 * object file alignment.  Using 32768
-		 */
-		. = ALIGN(PAGE_SIZE);
-		*(.data.init_task)
 
+		INIT_TASK_DATA(PAGE_SIZE)
+		NOSAVE_DATA
+		CACHELINE_ALIGNED_DATA(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 		DATA_DATA
 		CONSTRUCTORS
 	}
@@ -96,51 +80,13 @@ SECTIONS
 	.sdata : {
 		*(.sdata)
 	}
-
-	. = ALIGN(PAGE_SIZE);
-	.data_nosave : {
-		__nosave_begin = .;
-		*(.data.nosave)
-	}
-	. = ALIGN(PAGE_SIZE);
-	__nosave_end = .;
-
-	. = ALIGN(1 << CONFIG_MIPS_L1_CACHE_SHIFT);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
-	}
 	_edata =  .;			/* End of data section */
 
 	/* will be freed after init */
 	. = ALIGN(PAGE_SIZE);		/* Init code and data */
 	__init_begin = .;
-	.init.text : {
-		_sinittext = .;
-		INIT_TEXT
-		_einittext = .;
-	}
-	.init.data : {
-		INIT_DATA
-	}
-	. = ALIGN(16);
-	.init.setup : {
-		__setup_start = .;
-		*(.init.setup)
-		__setup_end = .;
-	}
-
-	.initcall.init : {
-		__initcall_start = .;
-		INITCALLS
-		__initcall_end = .;
-	}
-
-	.con_initcall.init : {
-		__con_initcall_start = .;
-		*(.con_initcall.init)
-		__con_initcall_end = .;
-	}
-	SECURITY_INIT
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
 
 	/* .exit.text is discarded at runtime, not link time, to deal with
 	 * references from .rodata
@@ -151,29 +97,13 @@ SECTIONS
 	.exit.data : {
 		EXIT_DATA
 	}
-#if defined(CONFIG_BLK_DEV_INITRD)
-	. = ALIGN(PAGE_SIZE);
-	.init.ramfs : {
-		__initramfs_start = .;
-		*(.init.ramfs)
-		__initramfs_end = .;
-	}
-#endif
+
 	PERCPU(PAGE_SIZE)
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
 	/* freed after init ends here */
 
-	__bss_start = .;	/* BSS */
-	.sbss  : {
-		*(.sbss)
-		*(.scommon)
-	}
-	.bss : {
-		*(.bss)
-		*(COMMON)
-	}
-	__bss_stop = .;
+	BSS_SECTION(0, 0, 0)
 
 	_end = . ;
 
-- 
1.6.3.3
