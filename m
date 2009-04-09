Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 06:13:00 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:38316 "EHLO lemote.com")
	by ftp.linux-mips.org with ESMTP id S20023834AbZDIFMy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Apr 2009 06:12:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id EA65D34129;
	Thu,  9 Apr 2009 13:09:55 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8CoR-QVvNaw; Thu,  9 Apr 2009 13:09:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 2E51D34131;
	Thu,  9 Apr 2009 13:09:49 +0800 (CST)
Message-ID: <49DD83CA.9000704@lemote.com>
Date:	Thu, 09 Apr 2009 13:12:42 +0800
From:	yanhua <yanh@lemote.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:	=?GB2312?B?xe3Bwb31?= <penglj@lemote.com>,
	"zhangfx@lemote.com" <zhangfx@lemote.com>
Subject: [PATCH 13/14] lemote: fixup for FUJITSU disk
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

---
drivers/ide/amd74xx.c | 20 ++++++++++++++++++++
1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 77267c8..51b888f 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -23,6 +23,11 @@

#define DRV_NAME "amd74xx"

+static const char *am74xx_quirk_drives[] = {
+ "FUJITSU MHZ2160BH G2",
+ NULL
+};
+
enum {
AMD_IDE_CONFIG = 0x41,
AMD_CABLE_DETECT = 0x42,
@@ -112,6 +117,20 @@ static void amd_set_pio_mode(ide_drive_t *drive,
const u8 pio)
amd_set_drive(drive, XFER_PIO_0 + pio);
}

+static void amd_quirkproc(ide_drive_t *drive, const u8 pio)
+{
+ const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
+
+ for (list = am74xx_quirk_drives; *list != NULL; list++)
+ if (strstr(m, *list) != NULL) {
+ drive->quirk_list = 2;
+ return;
+ }
+
+ drive->quirk_list = 0;
+
+}
+
static void amd7409_cable_detect(struct pci_dev *dev)
{
/* no host side cable detection */
@@ -194,6 +213,7 @@ static void __devinit init_hwif_amd74xx(ide_hwif_t
*hwif)
static const struct ide_port_ops amd_port_ops = {
.set_pio_mode = amd_set_pio_mode,
.set_dma_mode = amd_set_drive,
+ .quirkproc = amd_quirkproc,
.cable_detect = amd_cable_detect,
};

-- 
1.5.6.5
