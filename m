Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2003 14:00:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:33738 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225192AbTEQNAe>; Sat, 17 May 2003 14:00:34 +0100
Received: from localhost (p0446-ip01funabasi.chiba.ocn.ne.jp [211.130.235.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 60E76376E; Sat, 17 May 2003 22:00:30 +0900 (JST)
Date: Sat, 17 May 2003 22:08:48 +0900 (JST)
Message-Id: <20030517.220848.71082015.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: TX49 support for mips64 kernel
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

TX49 should be able to run mips64 kernel.  Please add a
CONFIG_CPU_TX49XX entry to arch/mips64/mm/Makefile.

diff -u linux-mips-cvs/arch/mips64/mm/Makefile linux.new/arch/mips64/mm/
--- linux-mips-cvs/arch/mips64/mm/Makefile	Fri Apr 25 23:43:44 2003
+++ linux.new/arch/mips64/mm/Makefile	Sat May 17 21:59:28 2003
@@ -16,6 +16,7 @@
 obj-$(CONFIG_CPU_NEVADA)	+= c-r4k.o pg-r4k.o tlb-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_R5432)		+= c-r4k.o pg-r4k.o tlb-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_RM7000)	+= c-r4k.o pg-r4k.o tlb-r4k.o tlb-glue-r4k.o
+obj-$(CONFIG_CPU_TX49XX)	+= c-r4k.o pg-r4k.o tlb-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_R10000)	+= c-r4k.o pg-r4k.o tlb-andes.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= c-sb1.o pg-sb1.o tlb-sb1.o tlb-glue-sb1.o \
 				   cex-sb1.o cerr-sb1.o
---
Atsushi Nemoto
