Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 15:43:27 +0100 (BST)
Received: from vervifontaine.sonytel.be ([80.88.33.193]:25539 "EHLO
	vervifontaine.sonycom.com") by ftp.linux-mips.org with ESMTP
	id S22214770AbYJWOnV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 15:43:21 +0100
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 8E90E58ABD;
	Thu, 23 Oct 2008 16:43:13 +0200 (MEST)
Date:	Thu, 23 Oct 2008 16:43:13 +0200 (CEST)
From:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Ralf Baechle <ralf@linux-mips.org>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: [PATCH] txx9: CONFIG_TOSHIBA_RBTX4939 spelling
Message-ID: <Pine.LNX.4.64.0810231641400.11300@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-1716197232-1224772993=:11300"
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Geert.Uytterhoeven@sonycom.com
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1716197232-1224772993=:11300
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Fix a typo in the comment for the TOSHIBA_RBTX4939 config option

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 17052db..4da3af4 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -46,7 +46,7 @@ config TOSHIBA_RBTX4938
 	  support this machine type
 
 config TOSHIBA_RBTX4939
-	bool "Toshiba RBTX4939 bobard"
+	bool "Toshiba RBTX4939 board"
 	depends on MACH_TX49XX
 	select SOC_TX4939
 	help

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1716197232-1224772993=:11300--
