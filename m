Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 11:26:35 +0000 (GMT)
Received: from fw01.bwg.de ([IPv6:::ffff:213.69.156.2]:45508 "EHLO fw01.bwg.de")
	by linux-mips.org with ESMTP id <S8225304AbUK2L03>;
	Mon, 29 Nov 2004 11:26:29 +0000
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.11.6p2G/8.11.6) with ESMTP id iATBQSR07975
	for <linux-mips@linux-mips.org>; Mon, 29 Nov 2004 12:26:28 +0100 (CET)
Received: (from localhost) by fw01.bwg.de (MSCAN) id 3/fw01.bwg.de/smtp-gw/mscan; Mon Nov 29 12:26:28 2004
From: =?iso-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
To: <linux-mips@linux-mips.org>
Subject: [PATCH] Fix for signal.c and Toshiba TX49XX TLB refill handler
Date: Mon, 29 Nov 2004 12:26:44 +0100
Message-ID: <NHBBLBCCGMJFJIKAMKLHGEHOCCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

the signal.c (get_sigframe) handler forces my boot process hanging in init
process.
Following patch solves the problem:

Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.79
diff -u -r1.79 signal.c
--- arch/mips/kernel/signal.c	28 Nov 2004 23:20:12 -0000	1.79
+++ arch/mips/kernel/signal.c	29 Nov 2004 11:18:37 -0000
@@ -374,7 +374,7 @@
 	else
 		almask = ALMASK;

-	return (void *)((sp - frame_size) & ~(PLAT_TRAMPOLINE_STUFF_LINE - 1));
+	return (void *)((sp - frame_size) & almask);
 }

 #ifdef CONFIG_TRAD_SIGNALS



without next patch the TX4927 Toshiba processor definitely does not boot.
(My CPU was hanging without any message on the serial console), this means
the panic() message
		panic("No TLB refill handler yet (CPU type: %d)",
		      current_cpu_data.cputype);
could not be seen.

I am not sure, if the place where I inserted the new processor type is
correct.

Index: arch/mips/mm/tlbex.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/tlbex.c,v
retrieving revision 1.7
diff -u -r1.7 tlbex.c
--- arch/mips/mm/tlbex.c	29 Nov 2004 05:31:09 -0000	1.7
+++ arch/mips/mm/tlbex.c	29 Nov 2004 11:23:05 -0000
@@ -763,6 +763,7 @@

 	case CPU_R4600:
 	case CPU_R4700:
+	case CPU_TX49XX:
 	case CPU_R5000:
 	case CPU_R5000A:
 	case CPU_5KC:

The patches included is against 2.6.

Thanks and regards
  Ralf Roesch
