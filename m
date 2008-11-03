Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 15:28:13 +0000 (GMT)
Received: from be1ssnxpe1.nxp.com ([57.67.164.69]:39314 "EHLO
	be1ssnxpe1.nxp.com") by ftp.linux-mips.org with ESMTP
	id S23057046AbYKCP2L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 3 Nov 2008 15:28:11 +0000
Received: from EU1RDCRDC1VW025.exi.nxp.com ([134.27.176.170])
	by be1ssnxpe1.nxp.com (8.13.8/8.13.8) with ESMTP id mA3FS5XE031174
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Mon, 3 Nov 2008 16:28:05 +0100
Received: from EU1RDCRDC1WX029.exi.nxp.com ([134.27.176.238]) by
 EU1RDCRDC1VW025.exi.nxp.com ([134.27.176.170]) with mapi; Mon, 3 Nov 2008
 16:27:37 +0100
From:	Daniel J Laird <daniel.j.laird@nxp.com>
To:	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:	Mon, 3 Nov 2008 16:28:06 +0100
Subject: [PATCH] Enabling PNX8XXX serial for NXP devices other than PNX8550.
Thread-Topic: [PATCH] Enabling PNX8XXX serial for NXP devices other than
 PNX8550.
Thread-Index: Ack9yMUZBESO4IE3S3eEIpWztVvPKA==
Message-ID: <C13DBBE85AD6974B85C118C35890CA5F13B22CBA46@EU1RDCRDC1WX029.exi.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.7400:2.4.4,1.2.40,4.0.164 definitions=2008-11-03_07:2008-10-10,2008-11-03,2008-11-03 signatures=0
Return-Path: <daniel.j.laird@nxp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

NXP PNX83XX SOCs use the same serial IP block as PNX8550 yet cannot select it
due to KConfig dependencies.  This patch enables support for PNX8550 and PNX83XX SoCs.

Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Signed-off-by: daniel.j.laird <daniel.j.laird@nxp.com>

diff -urN linux.git.orig/drivers/serial/Kconfig linux.git.new/drivers/serial/Kconfig
--- linux.git.orig/drivers/serial/Kconfig	2008-10-27 14:40:31.000000000 +0000
+++ linux.git.new/drivers/serial/Kconfig	2008-11-03 15:01:54.000000000 +0000
@@ -959,10 +959,10 @@
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as PNX8550 or PNX8330/2/5
 	  and you want to use serial ports, say Y.  Otherwise, say N.
 
 config SERIAL_PNX8XXX_CONSOLE
@@ -970,7 +970,7 @@
 	depends on SERIAL_PNX8XXX
 	select SERIAL_CORE_CONSOLE
 	help
-	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
+	  If you have a MIPS-based NXP SoC such as PNX8550 or PNX8330/2/5
 	  and you want to use serial console, say Y. Otherwise, say N.
 
 config SERIAL_CORE
