Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2004 08:37:16 +0000 (GMT)
Received: from relay-3m.club-internet.fr ([IPv6:::ffff:194.158.104.42]:30377
	"EHLO relay-3m.club-internet.fr") by linux-mips.org with ESMTP
	id <S8225482AbUCTIhM> convert rfc822-to-8bit; Sat, 20 Mar 2004 08:37:12 +0000
Received: from club-internet.fr (flashmail-2m.cs.clubint.net [172.16.20.61])
	by relay-3m.club-internet.fr (Postfix) with SMTP id 3FE14E0C7
	for <linux-mips@linux-mips.org>; Sat, 20 Mar 2004 09:37:11 +0100 (CET)
Received: from [218.233.102.150] by flashmail-2m.club-internet.fr via html
	interface
From: pinotj@club-internet.fr
To: linux-mips@linux-mips.org
Subject: [PATCH] Typo Kconfig
Date: Sat, 20 Mar 2004 09:37:11 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1079771831.27405.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <pinotj@club-internet.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pinotj@club-internet.fr
Precedence: bulk
X-list: linux-mips

Just a typo correction

Regards,

Jerome Pinot

diff -Nru a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	2004-03-11 11:55:27.000000000 +0900
+++ b/arch/mips/Kconfig	2004-03-17 14:14:11.000000000 +0900
@@ -247,7 +247,7 @@
 	  Momentum Computer <http://www.momenco.com/>.
 
 config PMC_YOSEMITE
-	bool "Support for PMC-Siera Yosemite eval board"
+	bool "Support for PMC-Sierra Yosemite eval board"
 	help
 	  Yosemite is an evaluation board for the RM9000x2 processor
 	  manufactured by PMC-Sierra
