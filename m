Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 May 2006 21:29:20 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:44774 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133558AbWEAU3J (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 May 2006 21:29:09 +0100
Received: (qmail 27240 invoked by uid 101); 1 May 2006 20:28:58 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 1 May 2006 20:28:58 -0000
Received: from duval.pmc-sierra.bc.ca (duval.pmc-sierra.bc.ca [134.87.183.32])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k41KSvf5021911
	for <linux-mips@linux-mips.org>; Mon, 1 May 2006 13:28:58 -0700
From:	Shane McDonald <mcdonald@pmc-sierra.com>
Received: (from mcdonald@localhost)
	by duval.pmc-sierra.bc.ca (8.12.11/8.12.11) id k41KSvsS002784
	for linux-mips@linux-mips.org; Mon, 1 May 2006 14:28:57 -0600
Date:	Mon, 1 May 2006 14:28:57 -0600
Message-Id: <200605012028.k41KSvsS002784@duval.pmc-sierra.bc.ca>
To:	linux-mips@linux-mips.org
Subject: [PATCH] improve readability of arch/mips/Kconfig
Return-Path: <mcdonald@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

From: Shane McDonald <shane_mcdonald@pmc-sierra.com>

The wording of the help entries for CPU_MIPS32_R1, CPU_MIPS32_R2,
CPU_MIPS64_R1, and CPU_MIPS64_R2 was confusing.
The entries have been slightly reworded to improve the readability.

Signed-off-by: Shane McDonald <shane_mcdonald@pmc-sierra.com>

---

diff -uprN a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig 2006-05-01 13:41:40.000000000 -0600
+++ b/arch/mips/Kconfig 2006-05-01 13:54:26.000000000 -0600
@@ -1075,10 +1075,10 @@ config CPU_MIPS32_R1
          Choose this option to build a kernel for release 1 or later of the
          MIPS32 architecture.  Most modern embedded systems with a 32-bit
          MIPS processor are based on a MIPS32 processor.  If you know the
-         specific type of processor in your system, choose those that one
-         otherwise CPU_MIPS32_R1 is a safe bet for any MIPS32 system.
-         Release 2 of the MIPS32 architecture is available since several
-         years so chances are you even have a MIPS32 Release 2 processor
+         specific type of processor in your system, choose that one;
+         otherwise, CPU_MIPS32_R1 is a safe bet for any MIPS32 system.
+         Release 2 of the MIPS32 architecture has been available for
+         several years so chances are you have a MIPS32 Release 2 processor
          in which case you should choose CPU_MIPS32_R2 instead for better
          performance.

@@ -1093,8 +1093,8 @@ config CPU_MIPS32_R2
          Choose this option to build a kernel for release 2 or later of the
          MIPS32 architecture.  Most modern embedded systems with a 32-bit
          MIPS processor are based on a MIPS32 processor.  If you know the
-         specific type of processor in your system, choose those that one
-         otherwise CPU_MIPS32_R1 is a safe bet for any MIPS32 system.
+         specific type of processor in your system, choose that one;
+         otherwise, CPU_MIPS32_R1 is a safe bet for any MIPS32 system.

 config CPU_MIPS64_R1
        bool "MIPS64 Release 1"
@@ -1108,10 +1108,10 @@ config CPU_MIPS64_R1
          Choose this option to build a kernel for release 1 or later of the
          MIPS64 architecture.  Many modern embedded systems with a 64-bit
          MIPS processor are based on a MIPS64 processor.  If you know the
-         specific type of processor in your system, choose those that one
-         otherwise CPU_MIPS64_R1 is a safe bet for any MIPS64 system.
-         Release 2 of the MIPS64 architecture is available since several
-         years so chances are you even have a MIPS64 Release 2 processor
+         specific type of processor in your system, choose that one;
+         otherwise, CPU_MIPS64_R1 is a safe bet for any MIPS64 system.
+         Release 2 of the MIPS64 architecture has been available for
+         several years so chances are you have a MIPS64 Release 2 processor
          in which case you should choose CPU_MIPS64_R2 instead for better
          performance.

@@ -1127,8 +1127,8 @@ config CPU_MIPS64_R2
          Choose this option to build a kernel for release 2 or later of the
          MIPS64 architecture.  Many modern embedded systems with a 64-bit
          MIPS processor are based on a MIPS64 processor.  If you know the
-         specific type of processor in your system, choose those that one
-         otherwise CPU_MIPS64_R1 is a safe bet for any MIPS64 system.
+         specific type of processor in your system, choose that one;
+         otherwise, CPU_MIPS64_R1 is a safe bet for any MIPS64 system.

 config CPU_R3000
        bool "R3000"
