Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2004 05:06:56 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:37383
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224839AbUJGEGw>; Thu, 7 Oct 2004 05:06:52 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 7 Oct 2004 04:06:50 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 4373A239E23; Thu,  7 Oct 2004 13:09:29 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9746g8G029667;
	Thu, 7 Oct 2004 13:06:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 07 Oct 2004 13:05:38 +0900 (JST)
Message-Id: <20041007.130538.71082967.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: sdc1 $f0 in r4k_switch.S
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found a bug in resume() in 2.6 kernel.  $f0 register may not be
saved on context switch in 64bit kernel.  Here is a quick fix.

Or moving "sdc1 $f0" to fpu_save_16even might be better fix.

diff -u linux-mips/arch/mips/kernel/r4k_switch.S linux/arch/mips/kernel/r4k_switch.S
--- linux-mips/arch/mips/kernel/r4k_switch.S	1 Sep 2004 08:03:31 -0000	1.11
+++ linux/arch/mips/kernel/r4k_switch.S	7 Oct 2004 03:27:56 -0000
@@ -81,10 +81,10 @@
 #ifdef CONFIG_MIPS64
 	sll	t2, t0, 5
 	bgez	t2, 2f
-	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
         fpu_save_16odd a0
 2:
         fpu_save_16even a0 t1                   # clobbers t1
+	sdc1	$f0, (THREAD_FPU + 0x00)(a0)
 #endif
 1:
 

---
Atsushi Nemoto
