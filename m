Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Apr 2007 23:06:16 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:25248 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20022276AbXD2WGO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 29 Apr 2007 23:06:14 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l3TM5nLD023559
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 30 Apr 2007 00:05:49 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l3TM5nwb023557;
	Mon, 30 Apr 2007 00:05:49 +0200
Date:	Mon, 30 Apr 2007 00:05:48 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	jejb@steeleye.com, davem@davemloft.net
Cc:	linux-scsi@vger.kernel.org, linux-m68k@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [PATCH] deprecate the old NCR53C9x driver
Message-ID: <20070429220548.GA22666@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

Now that we have the much better esp_scsi driver and low level drivers
are easy to port over deprecate the old NCR53C9x driver.

I've Cc'ed the m68k and mips lists because all but one bus glues are
for these platforms.  Chances stand bad for the remaining driver,
mca_53c9x which hasn't gotten any non-trivial update since it was
merge in late 2.1.x and whos maintainers mail address bounces.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt	2007-04-29 23:44:46.000000000 +0200
+++ linux-2.6/Documentation/feature-removal-schedule.txt	2007-04-29 23:45:55.000000000 +0200
@@ -6,6 +6,13 @@ be removed from this file.
 
 ---------------------------
 
+What:	old NCR53C9x driver
+When:	October 2007
+Why:	Replaced by the much better esp_scsi driver.  Actual low-level
+	driver can ported over almost trivially.
+Who:	David Miller <davem@davemloft.net>
+	Christoph Hellwig <hch@lst.de>
+
 What:	V4L2 VIDIOC_G_MPEGCOMP and VIDIOC_S_MPEGCOMP
 When:	October 2007
 Why:	Broken attempt to set MPEG compression parameters. These ioctls are
