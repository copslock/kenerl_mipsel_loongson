Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:33:43 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:54446 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023417AbZEOWdh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:33:37 +0100
Received: by pxi17 with SMTP id 17so1374096pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:33:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=C4zdZbho82sYoCptziGifYvbVmsDG/KggYAT85P5mus=;
        b=uaF9u/uOd7mmxvnJ0sgKe1n5rIVBPsjkZSX0LLjQyeO9XpQ8BfjlnpcYW52+qSBJY1
         0LLIrFTOuWMsa76rcBz13Ba9x6tb/33fum/WJ7dM9qlKuE8ZQpbEVMV9TrrHMLAeJo2q
         EyEyD1rcIuXhXFj8M1quYroCK9bGLDh5nduv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Tsobob9sl4nMDEzp7Rpeq7C44pqR76M0oFMfva8ZyogO+ff4xkQmxSR1y+Fk9Dj+lN
         7HcNJWuDfI1WjvBDn3XYZSiOqiSkurYTTWRFBNET5t42L5Ols7VwMkQd5Ba7bkHzjbiL
         Hlqy16NVanYgJzox4YMAkUpotFwS7H7Mq2dj0=
Received: by 10.114.152.7 with SMTP id z7mr5595391wad.198.1242426810617;
        Fri, 15 May 2009 15:33:30 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id v32sm1990130wah.59.2009.05.15.15.33.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:33:30 -0700 (PDT)
Subject: [PATCH 28/30] loongson: fixup for FUJITSU disk
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-ide@vger.kernel.org
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:33:23 +0800
Message-Id: <1242426803.10164.179.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From 2bf0cdb93b8b319fea11ee801a466d153667af83 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:57:52 +0800
Subject: [PATCH 28/30] loongson: fixup for FUJITSU disk

---
 drivers/ide/amd74xx.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 77267c8..3e1a487 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -23,6 +23,11 @@
 
 #define DRV_NAME "amd74xx"
 
+static const char *am74xx_quirk_drives[] = {
+	"FUJITSU MHZ2160BH G2",
+	NULL
+};
+
 enum {
 	AMD_IDE_CONFIG		= 0x41,
 	AMD_CABLE_DETECT	= 0x42,
@@ -112,6 +117,19 @@ static void amd_set_pio_mode(ide_drive_t *drive,
const u8 pio)
 	amd_set_drive(drive, XFER_PIO_0 + pio);
 }
 
+static void amd_quirkproc(ide_drive_t *drive)
+{	
+	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
+
+	for (list = am74xx_quirk_drives; *list != NULL; list++)
+			if (strstr(m, *list) != NULL) {
+				drive->quirk_list = 2;
+				return;
+			}
+
+	drive->quirk_list = 0;
+}
+
 static void amd7409_cable_detect(struct pci_dev *dev)
 {
 	/* no host side cable detection */
@@ -194,6 +212,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
*hwif)
 static const struct ide_port_ops amd_port_ops = {
 	.set_pio_mode		= amd_set_pio_mode,
 	.set_dma_mode		= amd_set_drive,
+	.quirkproc		= amd_quirkproc,
 	.cable_detect		= amd_cable_detect,
 };
 
-- 
1.6.2.1
