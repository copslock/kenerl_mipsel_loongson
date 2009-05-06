Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:37:21 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16893 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021329AbZEFAg1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:36:27 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800006>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:31 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:31 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZQ6q022779;
	Tue, 5 May 2009 17:35:26 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZQW2022778;
	Tue, 5 May 2009 17:35:26 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 7/7] [Staging] Hookup octeon-ethernet driver.
Date:	Tue,  5 May 2009 17:35:22 -0700
Message-Id: <1241570122-22728-7-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:31.0237 (UTC) FILETIME=[8F9AF550:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The previous patch adds the driver files for octeon-ethernet.  Here we
hook them up into the main kernel build system.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/staging/Kconfig  |    2 ++
 drivers/staging/Makefile |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 0dcf9ca..6c2ca23 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -115,5 +115,7 @@ source "drivers/staging/line6/Kconfig"
 
 source "drivers/staging/serqt_usb/Kconfig"
 
+source "drivers/staging/octeon/Kconfig"
+
 endif # !STAGING_EXCLUDE_BUILD
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 47dfd5b..6da9c74 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_PLAN9AUTH)		+= p9auth/
 obj-$(CONFIG_HECI)		+= heci/
 obj-$(CONFIG_LINE6_USB)		+= line6/
 obj-$(CONFIG_USB_SERIAL_QUATECH_ESU100)	+= serqt_usb/
+obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
-- 
1.6.0.6
