Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2003 08:14:36 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:59921
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224985AbTKEIOE>; Wed, 5 Nov 2003 08:14:04 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 5 Nov 2003 08:14:25 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hA58EG9X061126;
	Wed, 5 Nov 2003 17:14:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 05 Nov 2003 17:17:01 +0900 (JST)
Message-Id: <20031105.171701.42767326.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: define check_gcc before used (Re: CVS Update@-mips.org: linux)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20031021232555Z8225529-1272+8229@linux-mips.org>
References: <20031021232555Z8225529-1272+8229@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 22 Oct 2003 00:25:50 +0100, ralf@linux-mips.org said:
ralf> CVSROOT:	/home/cvs
ralf> Module name:	linux
ralf> Changes by:	ralf@ftp.linux-mips.org	03/10/22 00:25:50

ralf> Modified files:
ralf> 	arch/mips      : Tag: linux_2_4 Makefile 
ralf> 	arch/mips64    : Tag: linux_2_4 Makefile 

ralf> Log message:
ralf> 	Make gcc try inlining functions really hard.

It seems mips64 Makefile does not pass "-finline-limit=100000" to gcc.
The "check_gcc" must be defined before used ?

diff -u linux-mips-cvs/arch/mips64/Makefile linux/arch/mips64/Makefile
--- linux-mips-cvs/arch/mips64/Makefile	Tue Nov  4 16:57:37 2003
+++ linux/arch/mips64/Makefile	Wed Nov  5 16:50:40 2003
@@ -24,6 +24,8 @@
 CROSS_COMPILE	= $(tool-prefix)
 endif
 
+check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
+
 #
 # The ELF GCC uses -G 0 -mabicalls -fpic as default.  We don't need PIC
 # code in the kernel since it only slows down the whole thing.  For the
@@ -47,8 +49,6 @@
 endif
 endif
 
-check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
-
 #
 # CPU-dependent compiler/assembler options for optimization.
 #
---
Atsushi Nemoto
