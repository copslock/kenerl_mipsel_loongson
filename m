Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2003 06:04:25 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:45080
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225205AbTKZGEN>; Wed, 26 Nov 2003 06:04:13 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 26 Nov 2003 06:04:41 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hAQ64Tnd015570;
	Wed, 26 Nov 2003 15:04:32 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Wed, 26 Nov 2003 15:07:19 +0900 (JST)
Message-Id: <20031126.150719.104026850.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] TX49Lx support
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

Some TX49 do not have FPU.  We can tell such CPUs by bit3 of PrID.
Here is a patch for 2.4 tree.  The first hunk can also be used for 2.6
tree.  Please apply.  Thank you.

diff -ur linux-mips/arch/mips/kernel/cpu-probe.c linux/arch/mips/kernel/cpu-probe.c
--- linux-mips/arch/mips/kernel/cpu-probe.c	Tue Nov  4 16:57:34 2003
+++ linux/arch/mips/kernel/cpu-probe.c	Wed Nov 26 10:35:47 2003
@@ -297,6 +297,8 @@
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 		             MIPS_CPU_LLSC;
+		if (c->processor_id & 0x08)	/* TX49Lx: no FPU */
+			c->options &= ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_R5000:
diff -ur linux-mips/arch/mips64/kernel/cpu-probe.c linux/arch/mips64/kernel/cpu-probe.c
--- linux-mips/arch/mips64/kernel/cpu-probe.c	Tue Nov  4 16:57:37 2003
+++ linux/arch/mips64/kernel/cpu-probe.c	Wed Nov 26 10:35:50 2003
@@ -622,6 +622,8 @@
 			c->isa_level = MIPS_CPU_ISA_III;
 			c->options = R4K_OPTS | MIPS_CPU_FPU | MIPS_CPU_32FPR |
 			             MIPS_CPU_LLSC;
+			if (c->processor_id & 0x08)	/* TX49Lx: no FPU */
+				c->options &= ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
 			c->tlbsize = 48;
 			break;
 		case PRID_IMP_R5000:
---
Atsushi Nemoto
