Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Dec 2004 05:48:25 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:60198
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225202AbUL0FsU>; Mon, 27 Dec 2004 05:48:20 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 27 Dec 2004 05:48:18 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 83CBD239E1A; Mon, 27 Dec 2004 14:48:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBR5m4Mc040580;
	Mon, 27 Dec 2004 14:48:05 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Mon, 27 Dec 2004 14:48:04 +0900 (JST)
Message-Id: <20041227.144804.30188040.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: please export probe_irq_mask
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

Now probe_irq_mask is in kernel/irq/autoprobe.c, but it is not
exported.  Please export it as past.

Here is a patch (or kernel/irq/autoprobe.c should be fixed?)

Thank you.

--- linux-mips/arch/mips/kernel/mips_ksyms.c	2004-09-22 13:27:59.000000000 +0900
+++ linux/arch/mips/kernel/mips_ksyms.c	2004-12-27 14:37:12.524814712 +0900
@@ -60,3 +60,5 @@
 EXPORT_SYMBOL(csum_partial);
 
 EXPORT_SYMBOL(invalid_pte_table);
+extern unsigned int probe_irq_mask(unsigned long val);
+EXPORT_SYMBOL(probe_irq_mask);

---
Atsushi Nemoto
