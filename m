Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 11:29:10 +0000 (GMT)
Received: from royk.itea.ntnu.no ([IPv6:::ffff:129.241.190.230]:9193 "EHLO
	royk.itea.ntnu.no") by linux-mips.org with ESMTP
	id <S8225205AbULTL3F>; Mon, 20 Dec 2004 11:29:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by royk.itea.ntnu.no (Postfix) with ESMTP id 6D098672C9
	for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 12:28:52 +0100 (CET)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.179.15])
	by royk.itea.ntnu.no (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 12:28:52 +0100 (CET)
Received: from invalid.ed.ntnu.no (localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9) with ESMTP id iBKBSq18003738
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 12:28:52 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.12.9p2/8.12.9/Submit) with ESMTP id iBKBSpcA003735
	for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 12:28:52 +0100 (CET)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date: Mon, 20 Dec 2004 12:28:51 +0100 (CET)
From: Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To: linux-mips@linux-mips.org
Subject: [Patch] Au1550 PSC SPI irq mask fix
Message-ID: <20041220122328.M3626@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

The ALLMASK define for SPI interrupts is missing two bits.

diff -u -r1.1.2.6 au1xxx_psc.h
--- linux/include/asm-mips/au1xxx_psc.h 18 Sep 2004 22:07:37 -0000 
1.1.2.6
+++ linux/include/asm-mips/au1xxx_psc.h 20 Dec 2004 11:18:23 -0000
@@ -359,7 +359,8 @@
  #define PSC_SPIMSK_SD          (1 << 5)
  #define PSC_SPIMSK_MD          (1 << 4)
  #define PSC_SPIMSK_ALLMASK     (PSC_SPIMSK_MM | PSC_SPIMSK_RR | \
-                                PSC_SPIMSK_RO | PSC_SPIMSK_TO | \
+                                PSC_SPIMSK_RO | PSC_SPIMSK_RU | \
+                                PSC_SPIMSK_TR | PSC_SPIMSK_TO | \
                                  PSC_SPIMSK_TU | PSC_SPIMSK_SD | \
                                  PSC_SPIMSK_MD)
