Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jun 2009 17:45:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54906 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492979AbZF2Ppo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jun 2009 17:45:44 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5TFecmW018825;
	Mon, 29 Jun 2009 16:40:39 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5TFebhf018823;
	Mon, 29 Jun 2009 16:40:37 +0100
Date:	Mon, 29 Jun 2009 16:40:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Willy Tarreau <w@1wt.eu>
Cc:	Frank Seidel <Frank.Seidel@sphairon.com>, linux-mips@linux-mips.org
Subject: [PATCH] linux-2.4: usb: Add support for Teac HD-35PU
Message-ID: <20090629154037.GA18570@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

From: Rudolf Svanda <svandar@sphairon.com>

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
