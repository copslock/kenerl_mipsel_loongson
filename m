Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2003 13:49:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:28353 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225192AbTEQMtq>; Sat, 17 May 2003 13:49:46 +0100
Received: from localhost (p0446-ip01funabasi.chiba.ocn.ne.jp [211.130.235.192])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D7516374A; Sat, 17 May 2003 21:49:42 +0900 (JST)
Date: Sat, 17 May 2003 21:58:06 +0900 (JST)
Message-Id: <20030517.215806.92590717.anemo@mba.ocn.ne.jp>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: nemoto@toshiba-tops.co.jp
Subject: please give ieee1394 a chance
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
X-archive-position: 2411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now ieee1394 drivers (at least ohci1394 and sbp2) will work on mips.
Please give them a chance.

diff -u linux-mips-cvs/arch/mips/config-shared.in linux.new/arch/mips/
--- linux-mips-cvs/arch/mips/config-shared.in	Mon May  5 21:31:50 2003
+++ linux.new/arch/mips/config-shared.in	Sat May 17 21:50:35 2003
@@ -876,6 +876,8 @@
 fi
 endmenu
 
+source drivers/ieee1394/Config.in
+
 if [ "$CONFIG_PCI" = "y" ]; then
    source drivers/message/i2o/Config.in
 fi
---
Atsushi Nemoto
