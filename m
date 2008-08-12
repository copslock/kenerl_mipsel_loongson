Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 06:48:32 +0100 (BST)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:25291 "EHLO
	smtp14.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S20024455AbYHLFsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 06:48:25 +0100
Received: from [192.168.1.3] (PPPax964.tokyo-ip.dti.ne.jp [210.159.155.214]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m7C5mGbb010822 for <linux-mips@linux-mips.org>; Tue, 12 Aug 2008 14:48:20 +0900 (JST)
Message-ID: <48A12420.9090904@ruby.dti.ne.jp>
Date:	Tue, 12 Aug 2008 14:48:16 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [MIPS] Add missing GPL references of some asm headers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---
Hi list,

I don't want to be a nitpicker, nor don't have the right to mention the
header licenses, but I have trouble with some asm headers not having GPL
reference. For example, I was going to make use of <asm/cpu.h> in U-Boot
project, but the patch was rejected due to the lack of GPL references.

I've looked closely into all <asm/[foo/]bar.h> files, it seems there're
lots of headers without GPL reference. Basically, I'm not going to talk
about all of them. Some are board-dependent, some are used as pipe- or
proxy-method, etc. These headers might not be worth doing so.

However, some asm headers which include core MIPS defines, useful macros,
useful inline assemblers, etc. will be also useful for other projects
than Linux. And it's highly appreciated if such header has proper GPL
referense in it.

I've created the following patch for an example. Is there any chance
such changes are accepted?  Any comments are appreciated.

Thanks in advance,

  Shinya

 include/asm-mips/asmmacro-32.h |    4 ++++
 include/asm-mips/asmmacro-64.h |    4 ++++
 include/asm-mips/bugs.h        |    4 ++++
 include/asm-mips/cmp.h         |   10 +++++++---
 include/asm-mips/cpu.h         |    4 ++++
 include/asm-mips/dma.h         |    4 ++++
 include/asm-mips/highmem.h     |    4 ++++
 include/asm-mips/mips_mt.h     |    4 ++++
 include/asm-mips/mipsmtregs.h  |    5 +++++
 include/asm-mips/smtc.h        |    9 ++++++---
 include/asm-mips/smtc_ipi.h    |    4 ++++
 include/asm-mips/smtc_proc.h   |    5 +++++
 include/asm-mips/smvp.h        |   10 +++++++---
 include/asm-mips/thread_info.h |    7 ++++++-
 14 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/include/asm-mips/asmmacro-32.h b/include/asm-mips/asmmacro-32.h
index 5de3963..8ac6703 100644
--- a/include/asm-mips/asmmacro-32.h
+++ b/include/asm-mips/asmmacro-32.h
@@ -1,6 +1,10 @@
 /*
  * asmmacro.h: Assembler macros to make things easier to read.
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1998, 1999, 2003 Ralf Baechle
  */
diff --git a/include/asm-mips/asmmacro-64.h b/include/asm-mips/asmmacro-64.h
index 225feef..ab821ba 100644
--- a/include/asm-mips/asmmacro-64.h
+++ b/include/asm-mips/asmmacro-64.h
@@ -1,6 +1,10 @@
 /*
  * asmmacro.h: Assembler macros to make things easier to read.
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1998, 1999 Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
diff --git a/include/asm-mips/bugs.h b/include/asm-mips/bugs.h
index 9dc10df..fb33373 100644
--- a/include/asm-mips/bugs.h
+++ b/include/asm-mips/bugs.h
@@ -1,6 +1,10 @@
 /*
  * This is included by init/main.c to check for architecture-dependent bugs.
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2007  Maciej W. Rozycki
  *
  * Needs:
diff --git a/include/asm-mips/cmp.h b/include/asm-mips/cmp.h
index 89a73fb..88f6861 100644
--- a/include/asm-mips/cmp.h
+++ b/include/asm-mips/cmp.h
@@ -1,9 +1,13 @@
-#ifndef _ASM_CMP_H
-#define _ASM_CMP_H
-
 /*
  * Definitions for CMP multitasking on MIPS cores
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
+#ifndef _ASM_CMP_H
+#define _ASM_CMP_H
+
 struct task_struct;
 
 extern void cmp_smp_setup(void);
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index 229a786..dc2db1b 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -2,6 +2,10 @@
  * cpu.h: Values of the PRId register used to match up
  *        various MIPS cpu types.
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 2004  Maciej W. Rozycki
  */
diff --git a/include/asm-mips/dma.h b/include/asm-mips/dma.h
index 1353c81..864f24a 100644
--- a/include/asm-mips/dma.h
+++ b/include/asm-mips/dma.h
@@ -4,6 +4,10 @@
  * High DMA channel support & info by Hannu Savolainen
  * and John Boyd, Nov. 1992.
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * NOTE: all this is true *only* for ISA/EISA expansions on Mips boards
  * and can only be used for expansion cards. Onboard DMA controllers, such
  * as the R4030 on Jazz boards behave totally different!
diff --git a/include/asm-mips/highmem.h b/include/asm-mips/highmem.h
index 4374ab2..6f65131 100644
--- a/include/asm-mips/highmem.h
+++ b/include/asm-mips/highmem.h
@@ -1,6 +1,10 @@
 /*
  * highmem.h: virtual kernel memory mappings for high memory
  *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Used in CONFIG_HIGHMEM systems for memory pages which
  * are not addressable by direct kernel virtual addresses.
  *
diff --git a/include/asm-mips/mips_mt.h b/include/asm-mips/mips_mt.h
index ac79352..d996a42 100644
--- a/include/asm-mips/mips_mt.h
+++ b/include/asm-mips/mips_mt.h
@@ -2,6 +2,10 @@
  * Definitions and decalrations for MIPS MT support
  * that are common between SMTC, VSMP, and/or AP/SP
  * kernel models.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
 #ifndef __ASM_MIPS_MT_H
 #define __ASM_MIPS_MT_H
diff --git a/include/asm-mips/mipsmtregs.h b/include/asm-mips/mipsmtregs.h
index c9420aa..2e64af4 100644
--- a/include/asm-mips/mipsmtregs.h
+++ b/include/asm-mips/mipsmtregs.h
@@ -1,5 +1,10 @@
 /*
  * MT regs definitions, follows on from mipsregs.h
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright (C) 2004 - 2005 MIPS Technologies, Inc.  All rights reserved.
  * Elizabeth Clarke et. al.
  *
diff --git a/include/asm-mips/smtc.h b/include/asm-mips/smtc.h
index 3639b28..63ad742 100644
--- a/include/asm-mips/smtc.h
+++ b/include/asm-mips/smtc.h
@@ -1,9 +1,12 @@
-#ifndef _ASM_SMTC_MT_H
-#define _ASM_SMTC_MT_H
-
 /*
  * Definitions for SMTC multitasking on MIPS MT cores
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
+#ifndef _ASM_SMTC_MT_H
+#define _ASM_SMTC_MT_H
 
 #include <asm/mips_mt.h>
 
diff --git a/include/asm-mips/smtc_ipi.h b/include/asm-mips/smtc_ipi.h
index 8ce5175..eaf154a 100644
--- a/include/asm-mips/smtc_ipi.h
+++ b/include/asm-mips/smtc_ipi.h
@@ -1,5 +1,9 @@
 /*
  * Definitions used in MIPS MT SMTC "Interprocessor Interrupt" code.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
 #ifndef __ASM_SMTC_IPI_H
 #define __ASM_SMTC_IPI_H
diff --git a/include/asm-mips/smtc_proc.h b/include/asm-mips/smtc_proc.h
index 25da651..9788f71 100644
--- a/include/asm-mips/smtc_proc.h
+++ b/include/asm-mips/smtc_proc.h
@@ -1,5 +1,10 @@
 /*
  * Definitions for SMTC /proc entries
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
  * Copyright(C) 2005 MIPS Technologies Inc.
  */
 #ifndef __ASM_SMTC_PROC_H
diff --git a/include/asm-mips/smvp.h b/include/asm-mips/smvp.h
index 0d0e80a..a8ba14b 100644
--- a/include/asm-mips/smvp.h
+++ b/include/asm-mips/smvp.h
@@ -1,9 +1,13 @@
-#ifndef _ASM_SMVP_H
-#define _ASM_SMVP_H
-
 /*
  * Definitions for SMVP multitasking on MIPS MT cores
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
+#ifndef _ASM_SMVP_H
+#define _ASM_SMVP_H
+
 struct task_struct;
 
 extern void smvp_smp_setup(void);
diff --git a/include/asm-mips/thread_info.h b/include/asm-mips/thread_info.h
index bb30606..6c06478 100644
--- a/include/asm-mips/thread_info.h
+++ b/include/asm-mips/thread_info.h
@@ -1,4 +1,9 @@
-/* thread_info.h: MIPS low-level thread information
+/*
+ * thread_info.h: MIPS low-level thread information
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  *
  * Copyright (C) 2002  David Howells (dhowells@redhat.com)
  * - Incorporating suggestions made by Linus Torvalds and Dave Miller
