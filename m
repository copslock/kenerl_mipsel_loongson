Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 08:42:47 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:37925
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225242AbUAIImq>; Fri, 9 Jan 2004 08:42:46 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 9 Jan 2004 08:43:31 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i098hM1x029985;
	Fri, 9 Jan 2004 17:43:23 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Fri, 09 Jan 2004 17:43:53 +0900 (JST)
Message-Id: <20040109.174353.26978826.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: CONFIG_MAGIC_SYSRQ and CONFIG_DUMMY_KEYB
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 3886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The 2.4 kernel could not be built with both CONFIG_MAGIC_SYSRQ and
CONFIG_DUMMY_KEYB enabled.  This configuration should be possible
since we can use Magic SysRq with serial driver.

Here is a patch.

diff -u linux-mips/drivers/char/dummy_keyb.c linux/drivers/char/dummy_keyb.c
--- linux-mips/drivers/char/dummy_keyb.c	Thu Jun 12 10:14:55 2003
+++ linux/drivers/char/dummy_keyb.c	Fri Jan  9 17:28:37 2004
@@ -140,3 +140,7 @@
 {
 	printk("Dummy keyboard driver installed.\n");
 }
+#ifdef CONFIG_MAGIC_SYSRQ
+unsigned char kbd_sysrq_key;
+unsigned char kbd_sysrq_xlate[128];
+#endif
---
Atsushi Nemoto
