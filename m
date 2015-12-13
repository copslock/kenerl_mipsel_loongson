Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:47:07 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35285 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008361AbbLMWrCK6Tu9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:47:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=T3RSHsqt/enmcRkn9bpTNuBnqFvHluM6WVE3LN50xLc=;
        b=j0S4+wu+fMFNNskM0KDtiHJAI/aY3T6Q08iKpXAftnuKTZ+7w+QfkTPqs97pA9snzoxxkUWzxHlArGIjq7SfZpJxBFSLM/vG0sI1HsmpDyMT8Xt3REky39YxaAcP1dZAL8mXmWkvE+BD52BZ3xr1o5lr9Rov6M68PqAqZpAYFiwNrpltKu5W8zOg0arjTdFtQ+6O/z6Co0QG3El51Jevne+UoIovn7ycGvCBpamNJzTfvplCtjlC4wko6NQiYG/bEXxTLTUNNyZdWSr4CWNrpfvn+m6zY/XwVbNdjWfQY6ekKWNd5vjanuA6PPmFCAKyHKkQakUMjFGrwW8DXWeDiA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44495 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FPw-0003rF-Mp (Exim); Sun, 13 Dec 2015 22:47:01 +0000
Subject: [PATCH linux-next v4 03/11] MIPS: bcm963xx: Move Broadcom BCM963xx
 image tag data structure
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <566DF43B.5010400@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DF563.7020602@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:46:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566DF43B.5010400@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Move Broadcom BCM963xx image tag data structure to include/linux/
so that drivers outside of mach-bcm63xx can use it.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 MAINTAINERS                                       |  1 +
 arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h | 96 ----------------------
 drivers/mtd/bcm63xxpart.c                         |  2 +-
 include/linux/bcm963xx_tag.h                      | 98 +++++++++++++++++++++++
 4 files changed, 100 insertions(+), 97 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
 create mode 100644 include/linux/bcm963xx_tag.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ac7de1a..b2ef403 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2392,6 +2392,7 @@ F:	arch/mips/boot/dts/brcm/bcm*.dts*
 F:	drivers/irqchip/irq-bcm7*
 F:	drivers/irqchip/irq-brcmstb*
 F:	include/linux/bcm963xx_nvram.h
+F:	include/linux/bcm963xx_tag.h
 
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Prashant Sreedharan <prashant@broadcom.com>
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
deleted file mode 100644
index 1e6b587..0000000
--- a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
+++ /dev/null
@@ -1,96 +0,0 @@
-#ifndef __BCM963XX_TAG_H
-#define __BCM963XX_TAG_H
-
-#define TAGVER_LEN		4	/* Length of Tag Version */
-#define TAGLAYOUT_LEN		4	/* Length of FlashLayoutVer */
-#define SIG1_LEN		20	/* Company Signature 1 Length */
-#define SIG2_LEN		14	/* Company Signature 2 Length */
-#define BOARDID_LEN		16	/* Length of BoardId */
-#define ENDIANFLAG_LEN		2	/* Endian Flag Length */
-#define CHIPID_LEN		6	/* Chip Id Length */
-#define IMAGE_LEN		10	/* Length of Length Field */
-#define ADDRESS_LEN		12	/* Length of Address field */
-#define DUALFLAG_LEN		2	/* Dual Image flag Length */
-#define INACTIVEFLAG_LEN	2	/* Inactie Flag Length */
-#define RSASIG_LEN		20	/* Length of RSA Signature in tag */
-#define TAGINFO1_LEN		30	/* Length of vendor information field1 in tag */
-#define FLASHLAYOUTVER_LEN	4	/* Length of Flash Layout Version String tag */
-#define TAGINFO2_LEN		16	/* Length of vendor information field2 in tag */
-#define ALTTAGINFO_LEN		54	/* Alternate length for vendor information; Pirelli */
-
-#define NUM_PIRELLI		2
-#define IMAGETAG_CRC_START	0xFFFFFFFF
-
-#define PIRELLI_BOARDS { \
-	"AGPF-S0", \
-	"DWV-S0", \
-}
-
-/*
- * The broadcom firmware assumes the rootfs starts the image,
- * therefore uses the rootfs start (flash_image_address)
- * to determine where to flash the image.  Since we have the kernel first
- * we have to give it the kernel address, but the crc uses the length
- * associated with this address (root_length), which is added to the kernel
- * length (kernel_length) to determine the length of image to flash and thus
- * needs to be rootfs + deadcode (jffs2 EOF marker)
-*/
-
-struct bcm_tag {
-	/* 0-3: Version of the image tag */
-	char tag_version[TAGVER_LEN];
-	/* 4-23: Company Line 1 */
-	char sig_1[SIG1_LEN];
-	/*  24-37: Company Line 2 */
-	char sig_2[SIG2_LEN];
-	/* 38-43: Chip this image is for */
-	char chip_id[CHIPID_LEN];
-	/* 44-59: Board name */
-	char board_id[BOARDID_LEN];
-	/* 60-61: Map endianness -- 1 BE 0 LE */
-	char big_endian[ENDIANFLAG_LEN];
-	/* 62-71: Total length of image */
-	char total_length[IMAGE_LEN];
-	/* 72-83: Address in memory of CFE */
-	char cfe__address[ADDRESS_LEN];
-	/* 84-93: Size of CFE */
-	char cfe_length[IMAGE_LEN];
-	/* 94-105: Address in memory of image start
-	 * (kernel for OpenWRT, rootfs for stock firmware)
-	 */
-	char flash_image_start[ADDRESS_LEN];
-	/* 106-115: Size of rootfs */
-	char root_length[IMAGE_LEN];
-	/* 116-127: Address in memory of kernel */
-	char kernel_address[ADDRESS_LEN];
-	/* 128-137: Size of kernel */
-	char kernel_length[IMAGE_LEN];
-	/* 138-139: Unused at the moment */
-	char dual_image[DUALFLAG_LEN];
-	/* 140-141: Unused at the moment */
-	char inactive_flag[INACTIVEFLAG_LEN];
-	/* 142-161: RSA Signature (not used; some vendors may use this) */
-	char rsa_signature[RSASIG_LEN];
-	/* 162-191: Compilation and related information (not used in OpenWrt) */
-	char information1[TAGINFO1_LEN];
-	/* 192-195: Version flash layout */
-	char flash_layout_ver[FLASHLAYOUTVER_LEN];
-	/* 196-199: kernel+rootfs CRC32 */
-	__u32 fskernel_crc;
-	/* 200-215: Unused except on Alice Gate where is is information */
-	char information2[TAGINFO2_LEN];
-	/* 216-219: CRC32 of image less imagetag (kernel for Alice Gate) */
-	__u32 image_crc;
-	/* 220-223: CRC32 of rootfs partition */
-	__u32 rootfs_crc;
-	/* 224-227: CRC32 of kernel partition */
-	__u32 kernel_crc;
-	/* 228-235: Unused at present */
-	char reserved1[8];
-	/* 236-239: CRC32 of header excluding last 20 bytes */
-	__u32 header_crc;
-	/* 240-255: Unused at present */
-	char reserved2[16];
-};
-
-#endif /* __BCM63XX_TAG_H */
diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 4409369..b5bad1f 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -24,6 +24,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bcm963xx_tag.h>
 #include <linux/crc32.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -34,7 +35,6 @@
 #include <linux/mtd/partitions.h>
 
 #include <asm/mach-bcm63xx/bcm63xx_nvram.h>
-#include <asm/mach-bcm63xx/bcm963xx_tag.h>
 #include <asm/mach-bcm63xx/board_bcm963xx.h>
 
 #define BCM63XX_EXTENDED_SIZE	0xBFC00000	/* Extended flash address */
diff --git a/include/linux/bcm963xx_tag.h b/include/linux/bcm963xx_tag.h
new file mode 100644
index 0000000..f389dac
--- /dev/null
+++ b/include/linux/bcm963xx_tag.h
@@ -0,0 +1,98 @@
+#ifndef __LINUX_BCM963XX_TAG_H__
+#define __LINUX_BCM963XX_TAG_H__
+
+#include <linux/types.h>
+
+#define TAGVER_LEN		4	/* Length of Tag Version */
+#define TAGLAYOUT_LEN		4	/* Length of FlashLayoutVer */
+#define SIG1_LEN		20	/* Company Signature 1 Length */
+#define SIG2_LEN		14	/* Company Signature 2 Length */
+#define BOARDID_LEN		16	/* Length of BoardId */
+#define ENDIANFLAG_LEN		2	/* Endian Flag Length */
+#define CHIPID_LEN		6	/* Chip Id Length */
+#define IMAGE_LEN		10	/* Length of Length Field */
+#define ADDRESS_LEN		12	/* Length of Address field */
+#define DUALFLAG_LEN		2	/* Dual Image flag Length */
+#define INACTIVEFLAG_LEN	2	/* Inactie Flag Length */
+#define RSASIG_LEN		20	/* Length of RSA Signature in tag */
+#define TAGINFO1_LEN		30	/* Length of vendor information field1 in tag */
+#define FLASHLAYOUTVER_LEN	4	/* Length of Flash Layout Version String tag */
+#define TAGINFO2_LEN		16	/* Length of vendor information field2 in tag */
+#define ALTTAGINFO_LEN		54	/* Alternate length for vendor information; Pirelli */
+
+#define NUM_PIRELLI		2
+#define IMAGETAG_CRC_START	0xFFFFFFFF
+
+#define PIRELLI_BOARDS { \
+	"AGPF-S0", \
+	"DWV-S0", \
+}
+
+/*
+ * The broadcom firmware assumes the rootfs starts the image,
+ * therefore uses the rootfs start (flash_image_address)
+ * to determine where to flash the image.  Since we have the kernel first
+ * we have to give it the kernel address, but the crc uses the length
+ * associated with this address (root_length), which is added to the kernel
+ * length (kernel_length) to determine the length of image to flash and thus
+ * needs to be rootfs + deadcode (jffs2 EOF marker)
+*/
+
+struct bcm_tag {
+	/* 0-3: Version of the image tag */
+	char tag_version[TAGVER_LEN];
+	/* 4-23: Company Line 1 */
+	char sig_1[SIG1_LEN];
+	/*  24-37: Company Line 2 */
+	char sig_2[SIG2_LEN];
+	/* 38-43: Chip this image is for */
+	char chip_id[CHIPID_LEN];
+	/* 44-59: Board name */
+	char board_id[BOARDID_LEN];
+	/* 60-61: Map endianness -- 1 BE 0 LE */
+	char big_endian[ENDIANFLAG_LEN];
+	/* 62-71: Total length of image */
+	char total_length[IMAGE_LEN];
+	/* 72-83: Address in memory of CFE */
+	char cfe__address[ADDRESS_LEN];
+	/* 84-93: Size of CFE */
+	char cfe_length[IMAGE_LEN];
+	/* 94-105: Address in memory of image start
+	 * (kernel for OpenWRT, rootfs for stock firmware)
+	 */
+	char flash_image_start[ADDRESS_LEN];
+	/* 106-115: Size of rootfs */
+	char root_length[IMAGE_LEN];
+	/* 116-127: Address in memory of kernel */
+	char kernel_address[ADDRESS_LEN];
+	/* 128-137: Size of kernel */
+	char kernel_length[IMAGE_LEN];
+	/* 138-139: Unused at the moment */
+	char dual_image[DUALFLAG_LEN];
+	/* 140-141: Unused at the moment */
+	char inactive_flag[INACTIVEFLAG_LEN];
+	/* 142-161: RSA Signature (not used; some vendors may use this) */
+	char rsa_signature[RSASIG_LEN];
+	/* 162-191: Compilation and related information (not used in OpenWrt) */
+	char information1[TAGINFO1_LEN];
+	/* 192-195: Version flash layout */
+	char flash_layout_ver[FLASHLAYOUTVER_LEN];
+	/* 196-199: kernel+rootfs CRC32 */
+	__u32 fskernel_crc;
+	/* 200-215: Unused except on Alice Gate where is is information */
+	char information2[TAGINFO2_LEN];
+	/* 216-219: CRC32 of image less imagetag (kernel for Alice Gate) */
+	__u32 image_crc;
+	/* 220-223: CRC32 of rootfs partition */
+	__u32 rootfs_crc;
+	/* 224-227: CRC32 of kernel partition */
+	__u32 kernel_crc;
+	/* 228-235: Unused at present */
+	char reserved1[8];
+	/* 236-239: CRC32 of header excluding last 20 bytes */
+	__u32 header_crc;
+	/* 240-255: Unused at present */
+	char reserved2[16];
+};
+
+#endif /* __LINUX_BCM63XX_TAG_H__ */
-- 
2.1.4

-- 
Simon Arlott
