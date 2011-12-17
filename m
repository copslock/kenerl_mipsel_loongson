Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 14:00:43 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48594 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab1LQM7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 13:59:01 +0100
Received: by eekc13 with SMTP id c13so2862505eek.36
        for <linux-mips@linux-mips.org>; Sat, 17 Dec 2011 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z4ylx6tfBqkvZjo8jIEpfpDqW7MOWIpXcM0ArR1sZAY=;
        b=J3sT7HZLWdpyHtda/i3/cSf3Q8aLgUmWvTJ2cOUuNfS+DlNaqOmGwcC9udHzmMO4HK
         HVdTEtoNibIri2a5CTZRSdNkn/JSlvc8nUQnldhabcoHFUIRSOckjsNQAzr5QOH7Q0lT
         x8uyJixhzKwpqqljHKt+DOvq4NnkrXJ0AXbE4=
Received: by 10.213.22.74 with SMTP id m10mr1204632ebb.40.1324126736040;
        Sat, 17 Dec 2011 04:58:56 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-137-229.pools.arcor-ip.net. [88.73.137.229])
        by mx.google.com with ESMTPS id s16sm14739907eef.2.2011.12.17.04.58.54
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 04:58:55 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>
Subject: [PATCH 4/5] MIPS: BCM63XX: bcm963xx_tag.h: make crc fields integers
Date:   Sat, 17 Dec 2011 13:58:17 +0100
Message-Id: <1324126698-9919-5-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
References: <1324126698-9919-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 32118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14085

All CRC32 fields are 32 bit integers, so define them as such to prevent
unnecessary casts if we want to use them.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---

I decided for __u32 against u32 so that user space applications can still
use the header (like image creation utilities).

 arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
index ed72e6a..1e6b587 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm963xx_tag.h
@@ -16,7 +16,6 @@
 #define TAGINFO1_LEN		30	/* Length of vendor information field1 in tag */
 #define FLASHLAYOUTVER_LEN	4	/* Length of Flash Layout Version String tag */
 #define TAGINFO2_LEN		16	/* Length of vendor information field2 in tag */
-#define CRC_LEN			4	/* Length of CRC in bytes */
 #define ALTTAGINFO_LEN		54	/* Alternate length for vendor information; Pirelli */
 
 #define NUM_PIRELLI		2
@@ -77,19 +76,19 @@ struct bcm_tag {
 	/* 192-195: Version flash layout */
 	char flash_layout_ver[FLASHLAYOUTVER_LEN];
 	/* 196-199: kernel+rootfs CRC32 */
-	char fskernel_crc[CRC_LEN];
+	__u32 fskernel_crc;
 	/* 200-215: Unused except on Alice Gate where is is information */
 	char information2[TAGINFO2_LEN];
 	/* 216-219: CRC32 of image less imagetag (kernel for Alice Gate) */
-	char image_crc[CRC_LEN];
+	__u32 image_crc;
 	/* 220-223: CRC32 of rootfs partition */
-	char rootfs_crc[CRC_LEN];
+	__u32 rootfs_crc;
 	/* 224-227: CRC32 of kernel partition */
-	char kernel_crc[CRC_LEN];
+	__u32 kernel_crc;
 	/* 228-235: Unused at present */
 	char reserved1[8];
 	/* 236-239: CRC32 of header excluding last 20 bytes */
-	char header_crc[CRC_LEN];
+	__u32 header_crc;
 	/* 240-255: Unused at present */
 	char reserved2[16];
 };
-- 
1.7.2.5
