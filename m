Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:58:29 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:41225 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133394AbVJTG4e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:56:34 +0100
Received: from 10.10.64.121 by MMS3.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:56:23 -0700
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:56:21 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10824; Wed, 19 Oct 2005 23:56:20 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA28176 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:56:20
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6uKov008694 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:56:20 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6uK523956 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:56:20 -0700
Date:	Wed, 19 Oct 2005 23:56:20 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 4/12]  sb1a-support
Message-ID: <20051020065619.GD23899@broadcom.com>
References: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20051020065320.GA23857@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E01D4NK4416121-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Add support for SB-1A CPU.

Signed-Off-By: Andy Isaacson <adi@broadcom.com>

 arch/mips/kernel/cpu-probe.c |    3 +++
 arch/mips/kernel/proc.c      |    1 +
 arch/mips/mm/tlbex.c         |    1 +
 include/asm-mips/addrspace.h |    2 +-
 include/asm-mips/cpu.h       |    4 +++-
 5 files changed, 9 insertions(+), 2 deletions(-)

Index: lmo/arch/mips/mm/tlbex.c
===================================================================
--- lmo.orig/arch/mips/mm/tlbex.c	2005-10-19 22:34:08.000000000 -0700
+++ lmo/arch/mips/mm/tlbex.c	2005-10-19 22:34:12.000000000 -0700
@@ -854,6 +854,7 @@
 	case CPU_R12000:
 	case CPU_4KC:
 	case CPU_SB1:
+	case CPU_SB1A:
 	case CPU_4KSC:
 	case CPU_20KC:
 	case CPU_25KF:
Index: lmo/arch/mips/kernel/cpu-probe.c
===================================================================
--- lmo.orig/arch/mips/kernel/cpu-probe.c	2005-10-19 22:34:10.000000000 -0700
+++ lmo/arch/mips/kernel/cpu-probe.c	2005-10-19 22:34:12.000000000 -0700
@@ -629,6 +629,9 @@
 		c->options &= ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
 #endif
 		break;
+	case PRID_IMP_SB1A:
+		c->cputype = CPU_SB1A;
+		break;
 	}
 }
 
Index: lmo/arch/mips/kernel/proc.c
===================================================================
--- lmo.orig/arch/mips/kernel/proc.c	2005-10-19 22:34:08.000000000 -0700
+++ lmo/arch/mips/kernel/proc.c	2005-10-19 22:34:12.000000000 -0700
@@ -56,6 +56,7 @@
         [CPU_5KC]	= "MIPS 5Kc",
 	[CPU_R4310]	= "R4310",
 	[CPU_SB1]	= "SiByte SB1",
+	[CPU_SB1A]	= "SiByte SB1A",
 	[CPU_TX3912]	= "TX3912",
 	[CPU_TX3922]	= "TX3922",
 	[CPU_TX3927]	= "TX3927",
Index: lmo/include/asm-mips/cpu.h
===================================================================
--- lmo.orig/include/asm-mips/cpu.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/cpu.h	2005-10-19 22:34:12.000000000 -0700
@@ -93,6 +93,7 @@
  */
 
 #define PRID_IMP_SB1            0x0100
+#define PRID_IMP_SB1A           0x1100
 
 /*
  * These are the PRID's for when 23:16 == PRID_COMP_SANDCRAFT
@@ -194,7 +195,8 @@
 #define CPU_AU1200		59
 #define CPU_34K			60
 #define CPU_PR4450		61
-#define CPU_LAST		61
+#define CPU_SB1A		62
+#define CPU_LAST		62
 
 /*
  * ISA Level encodings
Index: lmo/include/asm-mips/addrspace.h
===================================================================
--- lmo.orig/include/asm-mips/addrspace.h	2005-10-19 22:34:08.000000000 -0700
+++ lmo/include/asm-mips/addrspace.h	2005-10-19 22:34:12.000000000 -0700
@@ -162,7 +162,7 @@
 #define TO_PHYS_MASK	_LLCONST_(0x000000ffffffffff)	/* 2^^40 - 1 */
 #endif
 
-#if defined(CONFIG_CPU_SB1)
+#if defined(CONFIG_CPU_SB1) || defined(CONFIG_CPU_SB1A)
 #define KUSIZE		_LLCONST_(0x0000100000000000)	/* 2^^44 */
 #define KUSIZE_64	_LLCONST_(0x0000100000000000)	/* 2^^44 */
 #define K0SIZE		_LLCONST_(0x0000100000000000)	/* 2^^44 */
