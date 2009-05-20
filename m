Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:13:11 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:49322 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025222AbZETWNF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:13:05 +0100
Received: by pzk40 with SMTP id 40so632598pzk.22
        for <multiple recipients>; Wed, 20 May 2009 15:12:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=suolxxIbJGZy8CZ81FRUczttMzg+MsqbjDEdP0joBqc=;
        b=N2/5FM0j04msqx0zA5tHEJS8hTFKWjkgmgEDbRZkrtA6nUgz3S5eRWst/xkZUq4Gry
         T5E+OBmzy4LPfcPl/UfmK2juSMHcVR7J5H0lqX5bR7x/aO7wpPCgbvB7Dfv2lX6w1Dpk
         cE/I0S+Fn5vnRhv0F/75r03iGLADxj1oo8su8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RRUzPgzCox6uu4qhqAXV/3Jy+AssFvTu6ghLWATPM6iHHRNhZDIAXrUiDx1HG8Wlde
         XZGL9qL4t9W7zjoZxlUM65Pem7rj4x7kQoIiX6XIKiLo/FFjJ4/G8P4Glb88Wz+E0u++
         amDIX1okb02r55W5wgyNbzAYWVHn/EpkyFt4Q=
Received: by 10.142.214.12 with SMTP id m12mr691259wfg.22.1242857578651;
        Wed, 20 May 2009 15:12:58 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm752253wfi.20.2009.05.20.15.12.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 15:12:57 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	IDE/ATA development list <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 24/27] fixup for FUJITSU disk
Date:	Thu, 21 May 2009 06:12:46 +0800
Message-Id: <a998340033c8f89ec028b354ebe2956239144049.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This is originally from the to-mips branch from
http://dev.lemote.com/code/linux_loongson

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/ide/amd74xx.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 77267c8..8f488b8 100644
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
@@ -112,6 +117,19 @@ static void amd_set_pio_mode(ide_drive_t *drive, const u8 pio)
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
@@ -194,6 +212,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t *hwif)
 static const struct ide_port_ops amd_port_ops = {
 	.set_pio_mode		= amd_set_pio_mode,
 	.set_dma_mode		= amd_set_drive,
+	.quirkproc		= amd_quirkproc,
 	.cable_detect		= amd_cable_detect,
 };
 
-- 
1.6.2.1
