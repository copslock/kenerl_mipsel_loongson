Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 11:55:43 +0200 (CEST)
Received: from mailout02.rmx.de ([217.111.120.10]:54837 "EHLO mailout02.rmx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492546AbZF2Jzg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 11:55:36 +0200
Received: from [172.19.17.48] (HELO kdin01.retarus.de)
  by mailout02.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 40885137 for linux-mips@linux-mips.org; Mon, 29 Jun 2009 11:50:39 +0200
Received: from bzvsmg91.dmzext.sys.sphairon.com (mail01.pmns.de [195.243.125.132])
	by kdin01.retarus.de (8.14.2/8.14.2/retarus.custom) with SMTP id n5T9ochh029179
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 11:50:38 +0200
Received: from BZSVEX02.sas.sys.sphairon.com (bzsvex02.sas.sys.sphairon.com [10.158.5.105])
	by bzvsmg91.dmzext.sys.sphairon.com (Postfix) with ESMTP id 07D7160609
	for <linux-mips@linux-mips.org>; Mon, 29 Jun 2009 11:49:24 +0200 (CEST)
Received: from [10.158.7.50] (10.158.7.50) by bzsvex02.sas.sys.sphairon.com
 (10.158.5.105) with Microsoft SMTP Server (TLS) id 8.1.358.0; Mon, 29 Jun
 2009 11:50:32 +0200
Message-ID: <4A488E6B.6020808@sphairon.com>
Date:	Mon, 29 Jun 2009 11:50:35 +0200
From:	Frank Seidel <Frank.Seidel@sphairon.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	<linux-mips@linux-mips.org>
CC:	"Seidel, Frank" <Frank.Seidel@sphairon.com>
Subject: [PATCH] linux-2.4: usb: Add support for Teac HD-35PU
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-RMX-ID: 20090629-115038-n5T9ochh029179-0@kdin01
X-RMX-TRACE: 2009-06-29 11:50:39 RmxMSO@kdin01/mailcc11 [0.1s] 20090629-115038-n5T9ochh029179-0@kdin01 0:00:01
X-RMX-TRACE: 2009-06-29 11:50:39 KdIn@kdin01/mailcc01 [0.5s] 20090629-115038-n5T9ochh029179-0@kdin01 0:00:00
Return-Path: <Frank.Seidel@sphairon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Frank.Seidel@sphairon.com
Precedence: bulk
X-list: linux-mips

Author: Rudolf Svanda <svandar@sphairon.com>

Support for Teac HD-35PU added

Signed-off-by: Rudolf Svanda <svandar@sphairon.com>
Signed-off-by: Frank Seidel <Frank.Seidel@sphairon.com>
---
 drivers/usb/storage/unusual_devs.h |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1012,3 +1012,13 @@ UNUSUAL_DEV(  0x0482, 0x0105, 0x0100, 0x
 		"Finecam L3",
 		US_SC_SCSI, US_PR_BULK, NULL,
 		US_FL_FIX_INQUIRY),
+
+/* Reported by Thomas Baechler <thomas@archlinux.org>
+ * Fixes I/O errors with Teac HD-35PU devices
+ * svr: last param was US_FL_IGNORE_RESIDUE, but unknown in 2.4
+ */
+UNUSUAL_DEV(  0x1652, 0x6600, 0x0201, 0x0201,
+		"Super Top",
+		"USB 2.0  IDE DEVICE",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		0),
