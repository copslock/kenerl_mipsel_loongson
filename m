Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2002 06:55:08 +0200 (CEST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:15398 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S1122978AbSI3EzH>; Mon, 30 Sep 2002 06:55:07 +0200
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; 30 Sep 2002 04:55:05 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id C156AB474; Mon, 30 Sep 2002 13:54:55 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA33773; Mon, 30 Sep 2002 13:54:55 +0900 (JST)
Date: Mon, 30 Sep 2002 13:57:17 +0900 (JST)
Message-Id: <20020930.135717.39150888.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: CVS Update@ftp.linux-mips.org: linux
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20020929014920Z1121744-9213+239@linux-mips.org>
References: <20020929014920Z1121744-9213+239@linux-mips.org>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

It seems some necessary codes for non-r4k CPUs were lost by this change.

> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	02/09/29 03:49:20
> 
> Modified files:
> 	arch/mips/kernel: Tag: linux_2_4 traps.c 
> 	arch/mips/mm   : Tag: linux_2_4 c-sb1.c tlb-sb1.c 
> 	arch/mips64/kernel: Tag: linux_2_4 traps.c 
> 	arch/mips64/mm : Tag: linux_2_4 Makefile c-sb1.c loadmmu.c 
> 	                 tlb-r4k.c tlb-sb1.c tlbex-r4k.S 
> Added files:
> 	arch/mips64/mm : Tag: linux_2_4 c-andes.c c-r4k.c pg-andes.c 
> 	                 pg-r4k.c tlb-andes.c 
> Removed files:
> 	arch/mips64/mm : Tag: linux_2_4 andes.c r4xx0.c 
> 
> Log message:
> 	Reorganize arch/mips64/mm along the line of it's 32-bit equivalent.

This is a patch to revert the change.

diff -ur linux-mips-cvs/arch/mips/kernel/traps.c linux.new/arch/mips/kernel/traps.c
--- linux-mips-cvs/arch/mips/kernel/traps.c	Sun Sep 29 19:45:07 2002
+++ linux.new/arch/mips/kernel/traps.c	Mon Sep 30 13:41:23 2002
@@ -1015,6 +1015,30 @@
 			memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000,
 			       0x80);
 		}
+	} else switch (mips_cpu.cputype) {
+	case CPU_SB1:
+		/*
+		 * XXX - This should be folded in to the "cleaner" handling,
+		 * above
+		 */
+		memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000, 0x80);
+		break;
+	case CPU_R6000:
+	case CPU_R6000A:
+	case CPU_R2000:
+	case CPU_R3000:
+	case CPU_R3000A:
+	case CPU_R3041:
+	case CPU_R3051:
+	case CPU_R3052:
+	case CPU_R3081:
+	case CPU_R3081E:
+	case CPU_TX3912:
+	case CPU_TX3922:
+	case CPU_TX3927:
+	case CPU_TX39XX:
+		memcpy((void *)(KSEG0 + 0x80), &except_vec3_generic, 0x80);
+		break;
 	}
 
 	if (mips_cpu.cputype == CPU_R6000 || mips_cpu.cputype == CPU_R6000A) {
---
Atsushi Nemoto
