Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:32:29 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:56048 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013323AbbLGW1oreRvg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:44 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 578BA1B0C; Mon,  7 Dec 2015 23:27:38 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2A3601B07;
        Mon,  7 Dec 2015 23:27:34 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 19/23] mtd: nand: switch all drivers to mtd_ooblayout_ops
Date:   Mon,  7 Dec 2015 23:26:14 +0100
Message-Id: <1449527178-5930-20-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

Implementing the mtd_ooblayout_ops interface is the new way of exposing
ECC/OOB layout to MTD users. Modify all NAND drivers to switch to this
approach.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

---
This commit is a collection of commits that have been squashed to into
a single one to limit the size of the patchset. If you want to have
separate commit for each of the NAND drivers you can have a look at
this branch [1].

[1]https://github.com/bbrezillon/linux-sunxi/commits/nand/ecclayout2
---
 arch/arm/mach-pxa/spitz.c                       |  41 +++-
 arch/mips/include/asm/mach-jz4740/jz4740_nand.h |   2 +-
 arch/mips/jz4740/board-qi_lb60.c                |  83 ++++---
 drivers/mtd/nand/atmel_nand.c                   |  81 +++----
 drivers/mtd/nand/bf5xx_nand.c                   |  47 ++--
 drivers/mtd/nand/brcmnand/brcmnand.c            | 255 ++++++++++++--------
 drivers/mtd/nand/cafe_nand.c                    |  42 +++-
 drivers/mtd/nand/davinci_nand.c                 | 114 ++++-----
 drivers/mtd/nand/denali.c                       |  48 ++--
 drivers/mtd/nand/diskonchip.c                   |  34 ++-
 drivers/mtd/nand/docg4.c                        |  29 ++-
 drivers/mtd/nand/fsl_elbc_nand.c                |  79 ++++---
 drivers/mtd/nand/fsl_ifc_nand.c                 | 224 +++++-------------
 drivers/mtd/nand/fsmc_nand.c                    | 294 +++++++-----------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c          |  48 +++-
 drivers/mtd/nand/hisi504_nand.c                 |  26 ++-
 drivers/mtd/nand/jz4740_nand.c                  |   2 +-
 drivers/mtd/nand/lpc32xx_mlc.c                  |  49 ++--
 drivers/mtd/nand/lpc32xx_slc.c                  |  37 ++-
 drivers/mtd/nand/mxc_nand.c                     | 206 ++++++++---------
 drivers/mtd/nand/omap2.c                        | 184 ++++++++-------
 drivers/mtd/nand/pxa3xx_nand.c                  | 101 ++++----
 drivers/mtd/nand/s3c2410.c                      |  28 ++-
 drivers/mtd/nand/sh_flctl.c                     |  80 +++++--
 drivers/mtd/nand/sharpsl.c                      |   2 +-
 drivers/mtd/nand/sm_common.c                    |  88 +++++--
 drivers/mtd/nand/sunxi_nand.c                   | 112 ++++-----
 drivers/mtd/nand/vf610_nfc.c                    |  34 +--
 include/linux/mtd/sharpsl.h                     |   2 +-
 29 files changed, 1226 insertions(+), 1146 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f4e2e27..13ed4e3 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -763,14 +763,35 @@ static struct nand_bbt_descr spitz_nand_bbt = {
 	.pattern	= scan_ff_pattern
 };
 
-static struct nand_ecclayout akita_oobinfo = {
-	.oobfree	= { {0x08, 0x09} },
-	.eccbytes	= 24,
-	.eccpos		= {
-			0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
-			0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
-			0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
-	},
+static int akita_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	static int eccpos[] = {
+		0x05, 0x01, 0x02, 0x03, 0x06, 0x07, 0x15, 0x11,
+		0x12, 0x13, 0x16, 0x17, 0x25, 0x21, 0x22, 0x23,
+		0x26, 0x27, 0x35, 0x31, 0x32, 0x33, 0x36, 0x37,
+	};
+
+	if (eccbyte >= ARRAY_SIZE(eccpos))
+		return -ERANGE;
+
+	return eccpos[eccbyte];
+}
+
+static int akita_oobfree(struct mtd_info *mtd, int section,
+			 struct nand_oobfree *oobfree)
+{
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 8;
+	oobfree->length = 9;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops akita_ooblayout_ops = {
+	.eccpos = akita_eccpos,
+	.oobfree = akita_oobfree,
 };
 
 static struct sharpsl_nand_platform_data spitz_nand_pdata = {
@@ -804,11 +825,11 @@ static void __init spitz_nand_init(void)
 	} else if (machine_is_akita()) {
 		spitz_nand_partitions[1].size = 58 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	} else if (machine_is_borzoi()) {
 		spitz_nand_partitions[1].size = 32 * 1024 * 1024;
 		spitz_nand_bbt.len = 1;
-		spitz_nand_pdata.ecc_layout = &akita_oobinfo;
+		spitz_nand_pdata.ecc_layout = &akita_ooblayout_ops;
 	}
 
 	platform_device_register(&spitz_nand_device);
diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
index 398733e..7f7b0fc 100644
--- a/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
+++ b/arch/mips/include/asm/mach-jz4740/jz4740_nand.h
@@ -27,7 +27,7 @@ struct jz_nand_platform_data {
 
 	unsigned char banks[JZ_NAND_NUM_BANKS];
 
-	void (*ident_callback)(struct platform_device *, struct nand_chip *,
+	void (*ident_callback)(struct platform_device *, struct mtd_info *,
 				struct mtd_partition **, int *num_partitions);
 };
 
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 934b15b..951621a 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -50,20 +50,6 @@ static bool is_avt2;
 #define QI_LB60_GPIO_KEYIN8		JZ_GPIO_PORTD(26)
 
 /* NAND */
-static struct nand_ecclayout qi_lb60_ecclayout_1gb = {
-	.eccbytes = 36,
-	.eccpos = {
-		6,  7,	8,  9,	10, 11, 12, 13,
-		14, 15, 16, 17, 18, 19, 20, 21,
-		22, 23, 24, 25, 26, 27, 28, 29,
-		30, 31, 32, 33, 34, 35, 36, 37,
-		38, 39, 40, 41
-	},
-	.oobfree = {
-		{ .offset = 2, .length = 4 },
-		{ .offset = 42, .length = 22 }
-	},
-};
 
 /* Early prototypes of the QI LB60 had only 1GB of NAND.
  * In order to support these devices as well the partition and ecc layout is
@@ -86,25 +72,6 @@ static struct mtd_partition qi_lb60_partitions_1gb[] = {
 	},
 };
 
-static struct nand_ecclayout qi_lb60_ecclayout_2gb = {
-	.eccbytes = 72,
-	.eccpos = {
-		12, 13, 14, 15, 16, 17, 18, 19,
-		20, 21, 22, 23, 24, 25, 26, 27,
-		28, 29, 30, 31, 32, 33, 34, 35,
-		36, 37, 38, 39, 40, 41, 42, 43,
-		44, 45, 46, 47, 48, 49, 50, 51,
-		52, 53, 54, 55, 56, 57, 58, 59,
-		60, 61, 62, 63, 64, 65, 66, 67,
-		68, 69, 70, 71, 72, 73, 74, 75,
-		76, 77, 78, 79, 80, 81, 82, 83
-	},
-	.oobfree = {
-		{ .offset = 2, .length = 10 },
-		{ .offset = 84, .length = 44 },
-	},
-};
-
 static struct mtd_partition qi_lb60_partitions_2gb[] = {
 	{
 		.name = "NAND BOOT partition",
@@ -123,19 +90,63 @@ static struct mtd_partition qi_lb60_partitions_2gb[] = {
 	},
 };
 
+static int qi_lb60_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	int eccbytes = 36, eccoff = 6;
+
+	if (mtd->oobsize == 128) {
+		eccbytes *= 2;
+		eccoff *= 2;
+	}
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return eccoff + eccbyte;
+}
+
+static int qi_lb60_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	int eccbytes = 36, eccoff = 6;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (mtd->oobsize == 128) {
+		eccbytes *= 2;
+		eccoff *= 2;
+	}
+
+	if (!section) {
+		oobfree->offset = 2;
+		oobfree->length = eccoff - 2;
+	} else {
+		oobfree->offset = eccoff + eccbytes;
+		oobfree->length = mtd->oobsize - oobfree->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
+	.eccpos = qi_lb60_eccpos,
+	.oobfree = qi_lb60_oobfree,
+};
+
 static void qi_lb60_nand_ident(struct platform_device *pdev,
-		struct nand_chip *chip, struct mtd_partition **partitions,
+		struct mtd_info *mtd, struct mtd_partition **partitions,
 		int *num_partitions)
 {
 	if (chip->page_shift == 12) {
-		chip->ecc.layout = &qi_lb60_ecclayout_2gb;
 		*partitions = qi_lb60_partitions_2gb;
 		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_2gb);
 	} else {
-		chip->ecc.layout = &qi_lb60_ecclayout_1gb;
 		*partitions = qi_lb60_partitions_1gb;
 		*num_partitions = ARRAY_SIZE(qi_lb60_partitions_1gb);
 	}
+
+	mtd_set_ooblayout(mtd, &qi_lb60_ooblayout_ops);
 }
 
 static struct jz_nand_platform_data qi_lb60_nand_pdata = {
diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index da16b1a..e67a502 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -67,30 +67,40 @@ struct atmel_nand_caps {
 	bool pmecc_correct_erase_page;
 };
 
-/* oob layout for large page size
+/*
+ * oob layout for large page size
  * bad block info is on bytes 0 and 1
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
- */
-static struct nand_ecclayout atmel_oobinfo_large = {
-	.eccbytes = 4,
-	.eccpos = {60, 61, 62, 63},
-	.oobfree = {
-		{2, 58}
-	},
-};
-
-/* oob layout for small page size
+ *
+ * oob layout for small page size
  * bad block info is on bytes 4 and 5
  * the bytes have to be consecutives to avoid
  * several NAND_CMD_RNDOUT during read
  */
-static struct nand_ecclayout atmel_oobinfo_small = {
-	.eccbytes = 4,
-	.eccpos = {0, 1, 2, 3},
-	.oobfree = {
-		{6, 10}
-	},
+static int atmel_eccpos_sp(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte >= 4)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int atmel_oobfree_sp(struct mtd_info *mtd, int section,
+			    struct nand_oobfree *oobfree)
+{
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 6;
+	oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops atmel_ooblayout_sp_ops = {
+	.eccpos = atmel_eccpos_sp,
+	.oobfree = atmel_oobfree_sp,
 };
 
 struct atmel_nfc {
@@ -157,8 +167,6 @@ struct atmel_nand_host {
 	int			*pmecc_delta;
 };
 
-static struct nand_ecclayout atmel_pmecc_oobinfo;
-
 /*
  * Enable NAND.
  */
@@ -474,22 +482,6 @@ static int pmecc_get_ecc_bytes(int cap, int sector_size)
 	return (m * cap + 7) / 8;
 }
 
-static void pmecc_config_ecc_layout(struct nand_ecclayout *layout,
-				    int oobsize, int ecc_len)
-{
-	int i;
-
-	layout->eccbytes = ecc_len;
-
-	/* ECC will occupy the last ecc_len bytes continuously */
-	for (i = 0; i < ecc_len; i++)
-		layout->eccpos[i] = oobsize - ecc_len + i;
-
-	layout->oobfree[0].offset = PMECC_OOB_RESERVED_BYTES;
-	layout->oobfree[0].length =
-		oobsize - ecc_len - layout->oobfree[0].offset;
-}
-
 static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
 {
 	int table_size;
@@ -993,8 +985,8 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct atmel_nand_host *host = nand_chip->priv;
+	int eccbytes = nand_chip->ecc.bytes * nand_chip->ecc.steps;
 	uint32_t val = 0;
-	struct nand_ecclayout *ecc_layout;
 
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
 	pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
@@ -1041,11 +1033,9 @@ static void atmel_pmecc_core_init(struct mtd_info *mtd)
 		| PMECC_CFG_AUTO_DISABLE);
 	pmecc_writel(host->ecc, CFG, val);
 
-	ecc_layout = nand_chip->ecc.layout;
 	pmecc_writel(host->ecc, SAREA, mtd->oobsize - 1);
 	pmecc_writel(host->ecc, SADDR, mtd_eccpos(mtd, 0));
-	pmecc_writel(host->ecc, EADDR,
-			mtd_eccpos(mtd, ecc_layout->eccbytes - 1));
+	pmecc_writel(host->ecc, EADDR, mtd_eccpos(mtd, eccbytes - 1));
 	/* See datasheet about PMECC Clock Control Register */
 	pmecc_writel(host->ecc, CLK, 2);
 	pmecc_writel(host->ecc, IDR, 0xff);
@@ -1260,11 +1250,8 @@ static int atmel_pmecc_nand_init_params(struct platform_device *pdev,
 			err_no = -EINVAL;
 			goto err;
 		}
-		pmecc_config_ecc_layout(&atmel_pmecc_oobinfo,
-					mtd->oobsize,
-					nand_chip->ecc.total);
 
-		nand_chip->ecc.layout = &atmel_pmecc_oobinfo;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		break;
 	default:
 		dev_warn(host->dev,
@@ -1607,19 +1594,19 @@ static int atmel_hw_nand_init_params(struct platform_device *pdev,
 	/* set ECC page size and oob layout */
 	switch (mtd->writesize) {
 	case 512:
-		nand_chip->ecc.layout = &atmel_oobinfo_small;
+		mtd_set_ooblayout(mtd, &atmel_ooblayout_sp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_528);
 		break;
 	case 1024:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_1056);
 		break;
 	case 2048:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_2112);
 		break;
 	case 4096:
-		nand_chip->ecc.layout = &atmel_oobinfo_large;
+		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
 		ecc_writel(host->ecc, MR, ATMEL_ECC_PAGESIZE_4224);
 		break;
 	default:
diff --git a/drivers/mtd/nand/bf5xx_nand.c b/drivers/mtd/nand/bf5xx_nand.c
index 61bd216..c0bbcd6 100644
--- a/drivers/mtd/nand/bf5xx_nand.c
+++ b/drivers/mtd/nand/bf5xx_nand.c
@@ -109,28 +109,29 @@ static const unsigned short bfin_nfc_pin_req[] =
 	 0};
 
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-static struct nand_ecclayout bootrom_ecclayout = {
-	.eccbytes = 24,
-	.eccpos = {
-		0x8 * 0, 0x8 * 0 + 1, 0x8 * 0 + 2,
-		0x8 * 1, 0x8 * 1 + 1, 0x8 * 1 + 2,
-		0x8 * 2, 0x8 * 2 + 1, 0x8 * 2 + 2,
-		0x8 * 3, 0x8 * 3 + 1, 0x8 * 3 + 2,
-		0x8 * 4, 0x8 * 4 + 1, 0x8 * 4 + 2,
-		0x8 * 5, 0x8 * 5 + 1, 0x8 * 5 + 2,
-		0x8 * 6, 0x8 * 6 + 1, 0x8 * 6 + 2,
-		0x8 * 7, 0x8 * 7 + 1, 0x8 * 7 + 2
-	},
-	.oobfree = {
-		{ 0x8 * 0 + 3, 5 },
-		{ 0x8 * 1 + 3, 5 },
-		{ 0x8 * 2 + 3, 5 },
-		{ 0x8 * 3 + 3, 5 },
-		{ 0x8 * 4 + 3, 5 },
-		{ 0x8 * 5 + 3, 5 },
-		{ 0x8 * 6 + 3, 5 },
-		{ 0x8 * 7 + 3, 5 },
-	}
+static int bootrom_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte >= 24)
+		return -ERANGE;
+
+	return ((eccbyte / 3) * 8) + (eccbyte % 3);
+}
+
+static int bootrom_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	if (section > 7)
+		return -ERANGE;
+
+	oobfree->offset = section * 8;
+	oobfree->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops bootrom_ooblayout_ops = {
+	.eccpos = bootrom_eccpos,
+	.oobfree = bootrom_oobfree,
 };
 #endif
 
@@ -793,7 +794,7 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	/* setup hardware ECC data struct */
 	if (hardware_ecc) {
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
-		chip->ecc.layout = &bootrom_ecclayout;
+		mtd_set_ooblayout(mtd, &bootrom_ooblayout_ops);
 #endif
 		chip->read_buf      = bf5xx_nand_dma_read_buf;
 		chip->write_buf     = bf5xx_nand_dma_write_buf;
diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index a906ec2..5815afd 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -746,126 +746,179 @@ static inline bool is_hamming_ecc(struct brcmnand_cfg *cfg)
 }
 
 /*
- * Returns a nand_ecclayout strucutre for the given layout/configuration.
- * Returns NULL on failure.
+ * Set mtd->ooblayout to the appropriate mtd_ooblayout_ops given
+ * the layout/configuration.
+ * Returns -ERRCODE on failure.
  */
-static struct nand_ecclayout *brcmnand_create_layout(int ecc_level,
-						     struct brcmnand_host *host)
+static int brcmnand_hamming_eccpos(struct mtd_info *mtd, int eccbyte)
 {
+	struct nand_chip *chip = mtd->priv;
+	struct brcmnand_host *host = chip->priv;
 	struct brcmnand_cfg *cfg = &host->hwcfg;
-	int i, j;
-	struct nand_ecclayout *layout;
-	int req;
-	int sectors;
-	int sas;
-	int idx1, idx2;
-
-	layout = devm_kzalloc(&host->pdev->dev, sizeof(*layout), GFP_KERNEL);
-	if (!layout)
-		return NULL;
-
-	sectors = cfg->page_size / (512 << cfg->sector_size_1k);
-	sas = cfg->spare_area_size << cfg->sector_size_1k;
-
-	/* Hamming */
-	if (is_hamming_ecc(cfg)) {
-		for (i = 0, idx1 = 0, idx2 = 0; i < sectors; i++) {
-			/* First sector of each page may have BBI */
-			if (i == 0) {
-				layout->oobfree[idx2].offset = i * sas + 1;
-				/* Small-page NAND use byte 6 for BBI */
-				if (cfg->page_size == 512)
-					layout->oobfree[idx2].offset--;
-				layout->oobfree[idx2].length = 5;
-			} else {
-				layout->oobfree[idx2].offset = i * sas;
-				layout->oobfree[idx2].length = 6;
-			}
-			idx2++;
-			layout->eccpos[idx1++] = i * sas + 6;
-			layout->eccpos[idx1++] = i * sas + 7;
-			layout->eccpos[idx1++] = i * sas + 8;
-			layout->oobfree[idx2].offset = i * sas + 9;
-			layout->oobfree[idx2].length = 7;
-			idx2++;
-			/* Leave zero-terminated entry for OOBFREE */
-			if (idx1 >= MTD_MAX_ECCPOS_ENTRIES_LARGE ||
-				    idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
-				break;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+	int sector = eccbyte / 3;
+
+	if (sector >= sectors)
+		return -ERANGE;
+
+	return (sector * sas) + (eccbyte % 3) + 6;
+}
+
+static int brcmnand_hamming_oobfree(struct mtd_info *mtd, int section,
+				    struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+
+	if (section >= sectors * 2)
+		return -ERANGE;
+
+	oobfree->offset = (section / 2) * sas;
+
+	if (section & 1) {
+		oobfree->offset += 9;
+		oobfree->length = 7;
+	} else {
+		oobfree->length = 6;
+
+		/* First sector of each page may have BBI */
+		if (!section) {
+			/*
+			 * Small-page NAND use byte 6 for BBI while large-page
+			 * NAND use byte 0.
+			 */
+			if (cfg->page_size > 512)
+				oobfree->offset++;
+			oobfree->length--;
 		}
-		goto out;
 	}
 
-	/*
-	 * CONTROLLER_VERSION:
-	 *   < v5.0: ECC_REQ = ceil(BCH_T * 13/8)
-	 *  >= v5.0: ECC_REQ = ceil(BCH_T * 14/8)
-	 * But we will just be conservative.
-	 */
-	req = DIV_ROUND_UP(ecc_level * 14, 8);
-	if (req >= sas) {
-		dev_err(&host->pdev->dev,
-			"error: ECC too large for OOB (ECC bytes %d, spare sector %d)\n",
-			req, sas);
-		return NULL;
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops brcmnand_hamming_ooblayout_ops = {
+	.eccpos = brcmnand_hamming_eccpos,
+	.oobfree = brcmnand_hamming_oobfree,
+};
+
+static int brcmnand_bch_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+	int sector = eccbyte / chip->ecc.bytes;
+
+	if (sector >= sectors)
+		return -ERANGE;
+
+	return (sector * (sas + 1)) - chip->ecc.bytes +
+	       (eccbyte % chip->ecc.bytes);
+}
+
+static int brcmnand_bch_oobfree_lp(struct mtd_info *mtd, int section,
+				   struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+	int sectors = cfg->page_size / (512 << cfg->sector_size_1k);
+
+	if (section >= sectors)
+		return -ERANGE;
+
+	if (sas <= chip->ecc.bytes)
+		return 0;
+
+	oobfree->offset = section * sas;
+	oobfree->length = sas - chip->ecc.bytes;
+
+	if (!section) {
+		oobfree->offset++;
+		oobfree->length--;
 	}
 
-	layout->eccbytes = req * sectors;
-	for (i = 0, idx1 = 0, idx2 = 0; i < sectors; i++) {
-		for (j = sas - req; j < sas && idx1 <
-				MTD_MAX_ECCPOS_ENTRIES_LARGE; j++, idx1++)
-			layout->eccpos[idx1] = i * sas + j;
+	return 0;
+}
 
-		/* First sector of each page may have BBI */
-		if (i == 0) {
-			if (cfg->page_size == 512 && (sas - req >= 6)) {
-				/* Small-page NAND use byte 6 for BBI */
-				layout->oobfree[idx2].offset = 0;
-				layout->oobfree[idx2].length = 5;
-				idx2++;
-				if (sas - req > 6) {
-					layout->oobfree[idx2].offset = 6;
-					layout->oobfree[idx2].length =
-						sas - req - 6;
-					idx2++;
-				}
-			} else if (sas > req + 1) {
-				layout->oobfree[idx2].offset = i * sas + 1;
-				layout->oobfree[idx2].length = sas - req - 1;
-				idx2++;
-			}
-		} else if (sas > req) {
-			layout->oobfree[idx2].offset = i * sas;
-			layout->oobfree[idx2].length = sas - req;
-			idx2++;
-		}
-		/* Leave zero-terminated entry for OOBFREE */
-		if (idx1 >= MTD_MAX_ECCPOS_ENTRIES_LARGE ||
-				idx2 >= MTD_MAX_OOBFREE_ENTRIES_LARGE - 1)
-			break;
+static int brcmnand_bch_oobfree_sp(struct mtd_info *mtd, int section,
+				   struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct brcmnand_host *host = chip->priv;
+	struct brcmnand_cfg *cfg = &host->hwcfg;
+	int sas = cfg->spare_area_size << cfg->sector_size_1k;
+
+	if (section > 1 || sas - chip->ecc.bytes < 6 ||
+	    (section && sas - chip->ecc.bytes == 6))
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 0;
+		oobfree->length = 5;
+	} else {
+		oobfree->offset = 6;
+		oobfree->length = sas - chip->ecc.bytes - 6;
 	}
-out:
-	return layout;
+
+	return 0;
 }
 
-static struct nand_ecclayout *brcmstb_choose_ecc_layout(
-		struct brcmnand_host *host)
+static const struct mtd_ooblayout_ops brcmnand_bch_lp_ooblayout_ops = {
+	.eccpos = brcmnand_bch_eccpos,
+	.oobfree = brcmnand_bch_oobfree_lp,
+};
+
+static const struct mtd_ooblayout_ops brcmnand_bch_sp_ooblayout_ops = {
+	.eccpos = brcmnand_bch_eccpos,
+	.oobfree = brcmnand_bch_oobfree_sp,
+};
+
+static int brcmstb_choose_ecc_layout(struct brcmnand_host *host)
 {
-	struct nand_ecclayout *layout;
 	struct brcmnand_cfg *p = &host->hwcfg;
+	struct mtd_info *mtd = &host->mtd;
+	struct nand_ecc_ctrl *ecc = &host->chip.ecc;
 	unsigned int ecc_level = p->ecc_level;
+	int sas = p->spare_area_size << p->sector_size_1k;
+	int sectors = p->page_size / (512 << p->sector_size_1k);
 
 	if (p->sector_size_1k)
 		ecc_level <<= 1;
 
-	layout = brcmnand_create_layout(ecc_level, host);
-	if (!layout) {
+	if (is_hamming_ecc(p)) {
+		ecc->bytes = 3 * sectors;
+		mtd_set_ooblayout(mtd, &brcmnand_hamming_ooblayout_ops);
+		return 0;
+	} else {
+		/*
+		 * CONTROLLER_VERSION:
+		 *   < v5.0: ECC_REQ = ceil(BCH_T * 13/8)
+		 *  >= v5.0: ECC_REQ = ceil(BCH_T * 14/8)
+		 * But we will just be conservative.
+		 */
+		ecc->bytes = DIV_ROUND_UP(ecc_level * 14, 8);
+
+		if (p->page_size == 512)
+			mtd_set_ooblayout(mtd, &brcmnand_bch_sp_ooblayout_ops);
+		else
+			mtd_set_ooblayout(mtd, &brcmnand_bch_lp_ooblayout_ops);
+	}
+
+	if (ecc->bytes >= sas) {
 		dev_err(&host->pdev->dev,
-				"no proper ecc_layout for this NAND cfg\n");
-		return NULL;
+			"error: ECC too large for OOB (ECC bytes %d, spare sector %d)\n",
+			ecc->bytes, sas);
+		return -EINVAL;
 	}
 
-	return layout;
+	return 0;
 }
 
 static void brcmnand_wp(struct mtd_info *mtd, int wp)
@@ -1976,9 +2029,9 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	/* only use our internal HW threshold */
 	mtd->bitflip_threshold = 1;
 
-	chip->ecc.layout = brcmstb_choose_ecc_layout(host);
-	if (!chip->ecc.layout)
-		return -ENXIO;
+	ret = brcmstb_choose_ecc_layout(host);
+	if (ret)
+		return ret;
 
 	if (nand_scan_tail(mtd))
 		return -ENXIO;
diff --git a/drivers/mtd/nand/cafe_nand.c b/drivers/mtd/nand/cafe_nand.c
index cce3ac4..39b2dcd 100644
--- a/drivers/mtd/nand/cafe_nand.c
+++ b/drivers/mtd/nand/cafe_nand.c
@@ -459,10 +459,35 @@ static int cafe_nand_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	return max_bitflips;
 }
 
-static struct nand_ecclayout cafe_oobinfo_2048 = {
-	.eccbytes = 14,
-	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
-	.oobfree = {{14, 50}}
+static int cafe_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd->priv;
+	int eccbytes = chip->ecc.steps * chip->ecc.bytes;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int cafe_oobfree(struct mtd_info *mtd, int section,
+			struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd->priv;
+	int eccbytes = chip->ecc.steps * chip->ecc.bytes;
+
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = eccbytes;
+	oobfree->length = mtd->oobsize - eccbytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops cafe_ooblayout_ops = {
+	.eccpos = cafe_eccpos,
+	.oobfree = cafe_oobfree,
 };
 
 /* Ick. The BBT code really ought to be able to work this bit out
@@ -494,12 +519,6 @@ static struct nand_bbt_descr cafe_bbt_mirror_descr_2048 = {
 	.pattern = cafe_mirror_pattern_2048
 };
 
-static struct nand_ecclayout cafe_oobinfo_512 = {
-	.eccbytes = 14,
-	.eccpos = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13},
-	.oobfree = {{14, 2}}
-};
-
 static struct nand_bbt_descr cafe_bbt_main_descr_512 = {
 	.options = NAND_BBT_LASTBLOCK | NAND_BBT_CREATE | NAND_BBT_WRITE
 		| NAND_BBT_2BIT | NAND_BBT_VERSION,
@@ -744,12 +763,11 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe->ctl2 |= 1<<29; /* 2KiB page size */
 
 	/* Set up ECC according to the type of chip we found */
+	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
 	if (mtd->writesize == 2048) {
-		cafe->nand.ecc.layout = &cafe_oobinfo_2048;
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
 	} else if (mtd->writesize == 512) {
-		cafe->nand.ecc.layout = &cafe_oobinfo_512;
 		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
 		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
 	} else {
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index 8e351af..116ee76 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -55,7 +55,6 @@
 struct davinci_nand_info {
 	struct mtd_info		mtd;
 	struct nand_chip	chip;
-	struct nand_ecclayout	ecclayout;
 
 	struct device		*dev;
 	struct clk		*clk;
@@ -487,63 +486,39 @@ static int nand_davinci_dev_ready(struct mtd_info *mtd)
  * ten ECC bytes plus the manufacturer's bad block marker byte, and
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_small = {
-	.eccbytes = 10,
-	.eccpos = { 0, 1, 2, 3, 4,
-		/* offset 5 holds the badblock marker */
-		6, 7,
-		13, 14, 15, },
-	.oobfree = {
-		{.offset = 8, .length = 5, },
-		{.offset = 16, },
-	},
-};
+static int hwecc4_small_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte >= 10)
+		return -ERANGE;
 
-/* An ECC layout for using 4-bit ECC with large-page (2048bytes) flash,
- * storing ten ECC bytes plus the manufacturer's bad block marker byte,
- * and not overlapping the default BBT markers.
- */
-static struct nand_ecclayout hwecc4_2048 = {
-	.eccbytes = 40,
-	.eccpos = {
-		/* at the end of spare sector */
-		24, 25, 26, 27, 28, 29,	30, 31, 32, 33,
-		34, 35, 36, 37, 38, 39,	40, 41, 42, 43,
-		44, 45, 46, 47, 48, 49, 50, 51, 52, 53,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-		},
-	.oobfree = {
-		/* 2 bytes at offset 0 hold manufacturer badblock markers */
-		{.offset = 2, .length = 22, },
-		/* 5 bytes at offset 8 hold BBT markers */
-		/* 8 bytes at offset 16 hold JFFS2 clean markers */
-	},
-};
+	if (eccbyte < 5)
+		return eccbyte;
+	else if (eccbyte < 7)
+		return eccbyte + 1;
 
-/*
- * An ECC layout for using 4-bit ECC with large-page (4096bytes) flash,
- * storing ten ECC bytes plus the manufacturer's bad block marker byte,
- * and not overlapping the default BBT markers.
- */
-static struct nand_ecclayout hwecc4_4096 = {
-	.eccbytes = 80,
-	.eccpos = {
-		/* at the end of spare sector */
-		48, 49, 50, 51, 52, 53, 54, 55, 56, 57,
-		58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
-		68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
-		78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
-		98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
-		108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
-		118, 119, 120, 121, 122, 123, 124, 125, 126, 127,
-	},
-	.oobfree = {
-		/* 2 bytes at offset 0 hold manufacturer badblock markers */
-		{.offset = 2, .length = 46, },
-		/* 5 bytes at offset 8 hold BBT markers */
-		/* 8 bytes at offset 16 hold JFFS2 clean markers */
-	},
+	return eccbyte + 6;
+}
+
+static int hwecc4_small_oobfree(struct mtd_info *mtd, int section,
+				struct nand_oobfree *oobfree)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 8;
+		oobfree->length = 5;
+	} else {
+		oobfree->offset = 16;
+		oobfree->length = mtd->oobsize - 16;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hwecc4_small_ooblayout_ops = {
+	.eccpos = hwecc4_small_eccpos,
+	.oobfree = hwecc4_small_oobfree,
 };
 
 #if defined(CONFIG_OF)
@@ -810,27 +785,16 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		 * table marker fits in the free bytes.
 		 */
 		if (chunks == 1) {
-			info->ecclayout = hwecc4_small;
-			info->ecclayout.oobfree[1].length =
-				info->mtd.oobsize - 16;
-			goto syndrome_done;
-		}
-		if (chunks == 4) {
-			info->ecclayout = hwecc4_2048;
+			mtd_set_ooblayout(&info->mtd,
+					  &hwecc4_small_ooblayout_ops);
+		} else if (chunks == 4 || chunks == 8) {
+			mtd_set_ooblayout(&info->mtd,
+					  &nand_ooblayout_lp_ops);
 			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-			goto syndrome_done;
-		}
-		if (chunks == 8) {
-			info->ecclayout = hwecc4_4096;
-			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-			goto syndrome_done;
+		} else {
+			ret = -EIO;
+			goto err;
 		}
-
-		ret = -EIO;
-		goto err;
-
-syndrome_done:
-		info->chip.ecc.layout = &info->ecclayout;
 	}
 
 	ret = nand_scan_tail(&info->mtd);
diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index 67eb2be..23086e3 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -1369,13 +1369,39 @@ static void denali_hw_init(struct denali_nand_info *denali)
  * correction
  */
 #define ECC_8BITS	14
-static struct nand_ecclayout nand_8bit_oob = {
-	.eccbytes = 14,
-};
-
 #define ECC_15BITS	26
-static struct nand_ecclayout nand_15bit_oob = {
-	.eccbytes = 26,
+
+static int denali_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return eccbyte + denali->bbtskipbytes;
+}
+
+static int denali_oobfree(struct mtd_info *mtd, int section,
+			  struct nand_oobfree *oobfree)
+{
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = eccbytes + denali->bbtskipbytes;
+	oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops denali_ooblayout_ops = {
+	.eccpos = denali_eccpos,
+	.oobfree = denali_oobfree,
 };
 
 static uint8_t bbt_pattern[] = {'B', 'b', 't', '0' };
@@ -1556,7 +1582,6 @@ int denali_init(struct denali_nand_info *denali)
 			ECC_SECTOR_SIZE)))) {
 		/* if MLC OOB size is large enough, use 15bit ECC*/
 		denali->nand.ecc.strength = 15;
-		denali->nand.ecc.layout = &nand_15bit_oob;
 		denali->nand.ecc.bytes = ECC_15BITS;
 		iowrite32(15, denali->flash_reg + ECC_CORRECTION);
 	} else if (denali->mtd.oobsize < (denali->bbtskipbytes +
@@ -1566,20 +1591,13 @@ int denali_init(struct denali_nand_info *denali)
 		goto failed_req_irq;
 	} else {
 		denali->nand.ecc.strength = 8;
-		denali->nand.ecc.layout = &nand_8bit_oob;
 		denali->nand.ecc.bytes = ECC_8BITS;
 		iowrite32(8, denali->flash_reg + ECC_CORRECTION);
 	}
 
+	mtd_set_ooblayout(&denali->mtd, &denali_ooblayout_ops);
 	denali->nand.ecc.bytes *= denali->devnum;
 	denali->nand.ecc.strength *= denali->devnum;
-	denali->nand.ecc.layout->eccbytes *=
-		denali->mtd.writesize / ECC_SECTOR_SIZE;
-	denali->nand.ecc.layout->oobfree[0].offset =
-		denali->bbtskipbytes + denali->nand.ecc.layout->eccbytes;
-	denali->nand.ecc.layout->oobfree[0].length =
-		denali->mtd.oobsize - denali->nand.ecc.layout->eccbytes -
-		denali->bbtskipbytes;
 
 	/*
 	 * Let driver know the total blocks number and how many blocks
diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 0802158..7101c9a 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -993,10 +993,34 @@ static int doc200x_correct_data(struct mtd_info *mtd, u_char *dat,
  * safer.  The only problem with it is that any code that parses oobfree must
  * be able to handle out-of-order segments.
  */
-static struct nand_ecclayout doc200x_oobinfo = {
-	.eccbytes = 6,
-	.eccpos = {0, 1, 2, 3, 4, 5},
-	.oobfree = {{8, 8}, {6, 2}}
+static int doc200x_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 5)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int doc200x_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 8;
+		oobfree->length = 8;
+	} else {
+		oobfree->offset = 6;
+		oobfree->length = 2;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops doc200x_ooblayout_ops = {
+	.eccpos = doc200x_eccpos,
+	.oobfree = doc200x_oobfree,
 };
 
 /* Find the (I)NFTL Media Header, and optionally also the mirror media header.
@@ -1571,6 +1595,7 @@ static int __init doc_probe(unsigned long physadr)
 
 	mtd->priv		= nand;
 	mtd->owner		= THIS_MODULE;
+	mtd_set_ooblayout(mtd, &doc200x_ooblayout_ops);
 
 	nand->priv		= doc;
 	nand->select_chip	= doc200x_select_chip;
@@ -1582,7 +1607,6 @@ static int __init doc_probe(unsigned long physadr)
 	nand->ecc.calculate	= doc200x_calculate_ecc;
 	nand->ecc.correct	= doc200x_correct_data;
 
-	nand->ecc.layout	= &doc200x_oobinfo;
 	nand->ecc.mode		= NAND_ECC_HW_SYNDROME;
 	nand->ecc.size		= 512;
 	nand->ecc.bytes		= 6;
diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index fdce91a..c032536 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -222,10 +222,29 @@ struct docg4_priv {
  * Bytes 8 - 14 are hw-generated ecc covering entire page + oob bytes 0 - 14.
  * Byte 15 (the last) is used by the driver as a "page written" flag.
  */
-static struct nand_ecclayout docg4_oobinfo = {
-	.eccbytes = 9,
-	.eccpos = {7, 8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {.offset = 2, .length = 5} }
+static int docg4_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 8)
+		return -ERANGE;
+
+	return eccbyte + 7;
+}
+
+static int docg4_oobfree(struct mtd_info *mtd, int section,
+			 struct nand_oobfree *oobfree)
+{
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 2;
+	oobfree->length = 5;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops docg4_ooblayout_ops = {
+	.eccpos = docg4_eccpos,
+	.oobfree = docg4_oobfree,
 };
 
 /*
@@ -1209,6 +1228,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	mtd->writesize = DOCG4_PAGE_SIZE;
 	mtd->erasesize = DOCG4_BLOCK_SIZE;
 	mtd->oobsize = DOCG4_OOB_SIZE;
+	mtd_set_ooblayout(mtd, &docg4_ooblayout_ops);
 	nand->chipsize = DOCG4_CHIP_SIZE;
 	nand->chip_shift = DOCG4_CHIP_SHIFT;
 	nand->bbt_erase_shift = nand->phys_erase_shift = DOCG4_ERASE_SHIFT;
@@ -1217,7 +1237,6 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 	nand->pagemask = 0x3ffff;
 	nand->badblockpos = NAND_LARGE_BADBLOCK_POS;
 	nand->badblockbits = 8;
-	nand->ecc.layout = &docg4_oobinfo;
 	nand->ecc.mode = NAND_ECC_HW_SYNDROME;
 	nand->ecc.size = DOCG4_PAGE_SIZE;
 	nand->ecc.prepad = 8;
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index bd6d493..716ecb3 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -80,32 +80,53 @@ struct fsl_elbc_fcm_ctrl {
 
 /* These map to the positions used by the FCM hardware ECC generator */
 
-/* Small Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm0 = {
-	.eccbytes = 3,
-	.eccpos = {6, 7, 8},
-	.oobfree = { {0, 5}, {9, 7} },
-};
+static int fsl_elbc_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = chip->priv;
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+	int eccpos;
 
-/* Small Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_sp_eccm1 = {
-	.eccbytes = 3,
-	.eccpos = {8, 9, 10},
-	.oobfree = { {0, 5}, {6, 2}, {11, 5} },
-};
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
 
-/* Large Page FLASH with FMR[ECCM] = 0 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
-	.eccbytes = 12,
-	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
-	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
-};
+	eccpos = ((eccbyte / chip->ecc.bytes) * 16) +
+		 (eccbyte % chip->ecc.bytes) + 6;
+	if (priv->fmr & FMR_ECCM)
+		eccpos += 2;
+
+	return eccpos;
+}
+
+static int fsl_elbc_oobfree(struct mtd_info *mtd, int section,
+			    struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct fsl_elbc_mtd *priv = chip->priv;
 
-/* Large Page FLASH with FMR[ECCM] = 1 */
-static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
-	.eccbytes = 12,
-	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
-	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
+	if (section > chip->ecc.steps)
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 0;
+		if (mtd->writesize > 512)
+			oobfree->offset++;
+		oobfree->length = (priv->fmr & FMR_ECCM) ? 7 : 5;
+	} else {
+		oobfree->offset = (16 * section) -
+				  ((priv->fmr & FMR_ECCM) ? 5 : 7);
+		if (section < chip->ecc.steps)
+			oobfree->length = 13;
+		else
+			oobfree->length = mtd->oobsize - oobfree->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsl_elbc_ooblayout_ops = {
+	.eccpos = fsl_elbc_eccpos,
+	.oobfree = fsl_elbc_oobfree,
 };
 
 /*
@@ -676,14 +697,6 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	} else if (mtd->writesize == 2048) {
 		priv->page_size = 1;
 		setbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);
-		/* adjust ecc setup if needed */
-		if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
-		    BR_DECC_CHK_GEN) {
-			chip->ecc.size = 512;
-			chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-			                   &fsl_elbc_oob_lp_eccm1 :
-			                   &fsl_elbc_oob_lp_eccm0;
-		}
 	} else {
 		dev_err(priv->dev,
 		        "fsl_elbc_init: page size %d is not supported\n",
@@ -781,9 +794,7 @@ static int fsl_elbc_chip_init(struct fsl_elbc_mtd *priv)
 	if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
 	    BR_DECC_CHK_GEN) {
 		chip->ecc.mode = NAND_ECC_HW;
-		/* put in small page settings and adjust later if needed */
-		chip->ecc.layout = (priv->fmr & FMR_ECCM) ?
-				&fsl_elbc_oob_sp_eccm1 : &fsl_elbc_oob_sp_eccm0;
+		mtd_set_ooblayout(&priv->mtd, &fsl_elbc_ooblayout_op);
 		chip->ecc.size = 512;
 		chip->ecc.bytes = 3;
 		chip->ecc.strength = 1;
diff --git a/drivers/mtd/nand/fsl_ifc_nand.c b/drivers/mtd/nand/fsl_ifc_nand.c
index 610308e..fbd2548 100644
--- a/drivers/mtd/nand/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/fsl_ifc_nand.c
@@ -68,136 +68,6 @@ struct fsl_ifc_nand_ctrl {
 
 static struct fsl_ifc_nand_ctrl *ifc_nand_ctrl;
 
-/* 512-byte page with 4-bit ECC, 8-bit */
-static struct nand_ecclayout oob_512_8bit_ecc4 = {
-	.eccbytes = 8,
-	.eccpos = {8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {0, 5}, {6, 2} },
-};
-
-/* 512-byte page with 4-bit ECC, 16-bit */
-static struct nand_ecclayout oob_512_16bit_ecc4 = {
-	.eccbytes = 8,
-	.eccpos = {8, 9, 10, 11, 12, 13, 14, 15},
-	.oobfree = { {2, 6}, },
-};
-
-/* 2048-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_2048_ecc4 = {
-	.eccbytes = 32,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-	},
-	.oobfree = { {2, 6}, {40, 24} },
-};
-
-/* 4096-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_4096_ecc4 = {
-	.eccbytes = 64,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-	},
-	.oobfree = { {2, 6}, {72, 56} },
-};
-
-/* 4096-byte page size with 8-bit ECC -- requires 218-byte OOB */
-static struct nand_ecclayout oob_4096_ecc8 = {
-	.eccbytes = 128,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-	},
-	.oobfree = { {2, 6}, {136, 82} },
-};
-
-/* 8192-byte page size with 4-bit ECC */
-static struct nand_ecclayout oob_8192_ecc4 = {
-	.eccbytes = 128,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-	},
-	.oobfree = { {2, 6}, {136, 208} },
-};
-
-/* 8192-byte page size with 8-bit ECC -- requires 218-byte OOB */
-static struct nand_ecclayout oob_8192_ecc8 = {
-	.eccbytes = 256,
-	.eccpos = {
-		8, 9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23,
-		24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63,
-		64, 65, 66, 67, 68, 69, 70, 71,
-		72, 73, 74, 75, 76, 77, 78, 79,
-		80, 81, 82, 83, 84, 85, 86, 87,
-		88, 89, 90, 91, 92, 93, 94, 95,
-		96, 97, 98, 99, 100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127,
-		128, 129, 130, 131, 132, 133, 134, 135,
-		136, 137, 138, 139, 140, 141, 142, 143,
-		144, 145, 146, 147, 148, 149, 150, 151,
-		152, 153, 154, 155, 156, 157, 158, 159,
-		160, 161, 162, 163, 164, 165, 166, 167,
-		168, 169, 170, 171, 172, 173, 174, 175,
-		176, 177, 178, 179, 180, 181, 182, 183,
-		184, 185, 186, 187, 188, 189, 190, 191,
-		192, 193, 194, 195, 196, 197, 198, 199,
-		200, 201, 202, 203, 204, 205, 206, 207,
-		208, 209, 210, 211, 212, 213, 214, 215,
-		216, 217, 218, 219, 220, 221, 222, 223,
-		224, 225, 226, 227, 228, 229, 230, 231,
-		232, 233, 234, 235, 236, 237, 238, 239,
-		240, 241, 242, 243, 244, 245, 246, 247,
-		248, 249, 250, 251, 252, 253, 254, 255,
-		256, 257, 258, 259, 260, 261, 262, 263,
-	},
-	.oobfree = { {2, 6}, {264, 80} },
-};
-
 /*
  * Generic flash bbt descriptors
  */
@@ -224,6 +94,55 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = mirror_pattern,
 };
 
+static int fsl_ifc_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return eccbyte + 8;
+}
+
+static int fsl_ifc_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (section > 1)
+		return -ERANGE;
+
+	if (mtd->writesize == 512 &&
+	    !(chip->options & NAND_BUSWIDTH_16)) {
+		if (!section) {
+			oobfree->offset = 0;
+			oobfree->length = 5;
+		} else {
+			oobfree->offset = 6;
+			oobfree->length = 2;
+		}
+
+		return 0;
+	}
+
+	if (!section) {
+		oobfree->offset = 2;
+		oobfree->length = 6;
+	} else {
+		oobfree->offset = eccbytes + 8;
+		oobfree->length = mtd->oobsize - oobfree->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsl_ifc_ooblayout_ops = {
+	.eccpos = fsl_ifc_eccpos,
+	.oobfree = fsl_ifc_oobfree,
+};
+
 /*
  * Set up the IFC hardware block and page address fields, and the ifc nand
  * structure addr field to point to the correct IFC buffer in memory
@@ -877,7 +796,6 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	struct fsl_ifc_ctrl *ctrl = priv->ctrl;
 	struct fsl_ifc_regs __iomem *ifc = ctrl->regs;
 	struct nand_chip *chip = &priv->chip;
-	struct nand_ecclayout *layout;
 	u32 csor;
 
 	/* Fill in fsl_ifc_mtd structure */
@@ -922,18 +840,9 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 
 	csor = ifc_in32(&ifc->csor_cs[priv->bank].csor);
 
-	/* Hardware generates ECC per 512 Bytes */
-	chip->ecc.size = 512;
-	chip->ecc.bytes = 8;
-	chip->ecc.strength = 4;
-
 	switch (csor & CSOR_NAND_PGS_MASK) {
 	case CSOR_NAND_PGS_512:
-		if (chip->options & NAND_BUSWIDTH_16) {
-			layout = &oob_512_16bit_ecc4;
-		} else {
-			layout = &oob_512_8bit_ecc4;
-
+		if (!(chip->options & NAND_BUSWIDTH_16)) {
 			/* Avoid conflict with bad block marker */
 			bbt_main_descr.offs = 0;
 			bbt_mirror_descr.offs = 0;
@@ -943,35 +852,16 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 		break;
 
 	case CSOR_NAND_PGS_2K:
-		layout = &oob_2048_ecc4;
 		priv->bufnum_mask = 3;
 		break;
 
 	case CSOR_NAND_PGS_4K:
-		if ((csor & CSOR_NAND_ECC_MODE_MASK) ==
-		    CSOR_NAND_ECC_MODE_4) {
-			layout = &oob_4096_ecc4;
-		} else {
-			layout = &oob_4096_ecc8;
-			chip->ecc.bytes = 16;
-			chip->ecc.strength = 8;
-		}
-
 		priv->bufnum_mask = 1;
 		break;
 
 	case CSOR_NAND_PGS_8K:
-		if ((csor & CSOR_NAND_ECC_MODE_MASK) ==
-		    CSOR_NAND_ECC_MODE_4) {
-			layout = &oob_8192_ecc4;
-		} else {
-			layout = &oob_8192_ecc8;
-			chip->ecc.bytes = 16;
-			chip->ecc.strength = 8;
-		}
-
 		priv->bufnum_mask = 0;
-	break;
+		break;
 
 	default:
 		dev_err(priv->dev, "bad csor %#x: bad page size\n", csor);
@@ -981,7 +871,17 @@ static int fsl_ifc_chip_init(struct fsl_ifc_mtd *priv)
 	/* Must also set CSOR_NAND_ECC_ENC_EN if DEC_EN set */
 	if (csor & CSOR_NAND_ECC_DEC_EN) {
 		chip->ecc.mode = NAND_ECC_HW;
-		chip->ecc.layout = layout;
+		mtd_set_ooblayout(&priv->mtd, &fsl_ifc_ooblayout_ops);
+
+		/* Hardware generates ECC per 512 Bytes */
+		chip->ecc.size = 512;
+		if ((csor & CSOR_NAND_ECC_MODE_MASK) == CSOR_NAND_ECC_MODE_4) {
+			chip->ecc.bytes = 8;
+			chip->ecc.strength = 4;
+		} else {
+			chip->ecc.bytes = 16;
+			chip->ecc.strength = 8;
+		}
 	} else {
 		chip->ecc.mode = NAND_ECC_SOFT;
 	}
diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 59fc6d0..14fd7f6 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -39,212 +39,6 @@
 #include <linux/amba/bus.h>
 #include <mtd/mtd-abi.h>
 
-static struct nand_ecclayout fsmc_ecc1_128_layout = {
-	.eccbytes = 24,
-	.eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52,
-		66, 67, 68, 82, 83, 84, 98, 99, 100, 114, 115, 116},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-		{.offset = 24, .length = 8},
-		{.offset = 40, .length = 8},
-		{.offset = 56, .length = 8},
-		{.offset = 72, .length = 8},
-		{.offset = 88, .length = 8},
-		{.offset = 104, .length = 8},
-		{.offset = 120, .length = 8}
-	}
-};
-
-static struct nand_ecclayout fsmc_ecc1_64_layout = {
-	.eccbytes = 12,
-	.eccpos = {2, 3, 4, 18, 19, 20, 34, 35, 36, 50, 51, 52},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-		{.offset = 24, .length = 8},
-		{.offset = 40, .length = 8},
-		{.offset = 56, .length = 8},
-	}
-};
-
-static struct nand_ecclayout fsmc_ecc1_16_layout = {
-	.eccbytes = 3,
-	.eccpos = {2, 3, 4},
-	.oobfree = {
-		{.offset = 8, .length = 8},
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 8192 bytes & OOBsize 256 bytes. 13*16 bytes
- * of OB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block and 46
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_256_layout = {
-	.eccbytes = 208,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126,
-		130, 131, 132, 133, 134, 135, 136,
-		137, 138, 139, 140, 141, 142,
-		146, 147, 148, 149, 150, 151, 152,
-		153, 154, 155, 156, 157, 158,
-		162, 163, 164, 165, 166, 167, 168,
-		169, 170, 171, 172, 173, 174,
-		178, 179, 180, 181, 182, 183, 184,
-		185, 186, 187, 188, 189, 190,
-		194, 195, 196, 197, 198, 199, 200,
-		201, 202, 203, 204, 205, 206,
-		210, 211, 212, 213, 214, 215, 216,
-		217, 218, 219, 220, 221, 222,
-		226, 227, 228, 229, 230, 231, 232,
-		233, 234, 235, 236, 237, 238,
-		242, 243, 244, 245, 246, 247, 248,
-		249, 250, 251, 252, 253, 254
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 3},
-		{.offset = 143, .length = 3},
-		{.offset = 159, .length = 3},
-		{.offset = 175, .length = 3},
-		{.offset = 191, .length = 3},
-		{.offset = 207, .length = 3},
-		{.offset = 223, .length = 3},
-		{.offset = 239, .length = 3},
-		{.offset = 255, .length = 1}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 4096 bytes & OOBsize 224 bytes. 13*8 bytes
- * of OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block & 118
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_224_layout = {
-	.eccbytes = 104,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 97}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 4096 bytes & OOBsize 128 bytes. 13*8 bytes
- * of OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block & 22
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_128_layout = {
-	.eccbytes = 104,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-		66,  67,  68,  69,  70,  71,  72,
-		73,  74,  75,  76,  77,  78,
-		82,  83,  84,  85,  86,  87,  88,
-		89,  90,  91,  92,  93,  94,
-		98,  99, 100, 101, 102, 103, 104,
-		105, 106, 107, 108, 109, 110,
-		114, 115, 116, 117, 118, 119, 120,
-		121, 122, 123, 124, 125, 126
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 3},
-		{.offset = 79, .length = 3},
-		{.offset = 95, .length = 3},
-		{.offset = 111, .length = 3},
-		{.offset = 127, .length = 1}
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 2048 bytes & OOBsize 64 bytes. 13*4 bytes of
- * OOB size is reserved for ECC, Byte no. 0 & 1 reserved for bad block and 10
- * bytes are free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_64_layout = {
-	.eccbytes = 52,
-	.eccpos = {  2,   3,   4,   5,   6,   7,   8,
-		9,  10,  11,  12,  13,  14,
-		18,  19,  20,  21,  22,  23,  24,
-		25,  26,  27,  28,  29,  30,
-		34,  35,  36,  37,  38,  39,  40,
-		41,  42,  43,  44,  45,  46,
-		50,  51,  52,  53,  54,  55,  56,
-		57,  58,  59,  60,  61,  62,
-	},
-	.oobfree = {
-		{.offset = 15, .length = 3},
-		{.offset = 31, .length = 3},
-		{.offset = 47, .length = 3},
-		{.offset = 63, .length = 1},
-	}
-};
-
-/*
- * ECC4 layout for NAND of pagesize 512 bytes & OOBsize 16 bytes. 13 bytes of
- * OOB size is reserved for ECC, Byte no. 4 & 5 reserved for bad block and One
- * byte is free for use.
- */
-static struct nand_ecclayout fsmc_ecc4_16_layout = {
-	.eccbytes = 13,
-	.eccpos = { 0,  1,  2,  3,  6,  7, 8,
-		9, 10, 11, 12, 13, 14
-	},
-	.oobfree = {
-		{.offset = 15, .length = 1},
-	}
-};
-
 /*
  * ECC placement definitions in oobfree type format.
  * There are 13 bytes of ecc for every 512 byte block and it has to be read
@@ -274,6 +68,80 @@ static struct fsmc_eccplace fsmc_ecc4_sp_place = {
 	}
 };
 
+static int fsmc_ecc1_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / 3) * 16) + (eccbyte % 3) + 2;
+}
+
+static int fsmc_ecc1_oobfree(struct mtd_info *mtd, int section,
+			     struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 8;
+
+	if (section < chip->ecc.steps - 1)
+		oobfree->length = 8;
+	else
+		oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsmc_ecc1_ooblayout_ops = {
+	.eccpos = fsmc_ecc1_eccpos,
+	.oobfree = fsmc_ecc1_oobfree,
+};
+
+static int fsmc_ecc4_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int eccbytes = chip->ecc.bytes * chip->ecc.steps;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	if (mtd->writesize > 512)
+		return ((eccbyte / 13) * 16) + (eccbyte % 13) + 2;
+
+	if (eccbyte < 4)
+		return eccbyte;
+
+	return eccbyte + 2;
+}
+
+static int fsmc_ecc4_oobfree(struct mtd_info *mtd, int section,
+			     struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 15;
+
+	if (section < chip->ecc.steps - 1)
+		oobfree->length = 3;
+	else
+		oobfree->length = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops fsmc_ecc4_ooblayout_ops = {
+	.eccpos = fsmc_ecc4_eccpos,
+	.oobfree = fsmc_ecc4_oobfree,
+};
+
 /**
  * struct fsmc_nand_data - structure for FSMC NAND device state
  *
@@ -1089,23 +957,18 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	if (AMBA_REV_BITS(host->pid) >= 8) {
 		switch (host->mtd.oobsize) {
 		case 16:
-			nand->ecc.layout = &fsmc_ecc4_16_layout;
 			host->ecc_place = &fsmc_ecc4_sp_place;
 			break;
 		case 64:
-			nand->ecc.layout = &fsmc_ecc4_64_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 128:
-			nand->ecc.layout = &fsmc_ecc4_128_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 224:
-			nand->ecc.layout = &fsmc_ecc4_224_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		case 256:
-			nand->ecc.layout = &fsmc_ecc4_256_layout;
 			host->ecc_place = &fsmc_ecc4_lp_place;
 			break;
 		default:
@@ -1114,6 +977,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_probe;
 		}
+
+		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
 	} else {
 		switch (nand->ecc.mode) {
 		case NAND_ECC_HW:
@@ -1140,13 +1005,10 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 		if (nand->ecc.mode != NAND_ECC_SOFT_BCH) {
 			switch (host->mtd.oobsize) {
 			case 16:
-				nand->ecc.layout = &fsmc_ecc1_16_layout;
-				break;
 			case 64:
-				nand->ecc.layout = &fsmc_ecc1_64_layout;
-				break;
 			case 128:
-				nand->ecc.layout = &fsmc_ecc1_128_layout;
+				mtd_set_ooblayout(mtd,
+						  &fsmc_ecc1_ooblayout_ops);
 				break;
 			default:
 				dev_warn(&pdev->dev,
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index c208f5e..9894843 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -47,10 +47,41 @@ static struct nand_bbt_descr gpmi_bbt_descr = {
  * We may change the layout if we can get the ECC info from the datasheet,
  * else we will use all the (page + OOB).
  */
-static struct nand_ecclayout gpmi_hw_ecclayout = {
-	.eccbytes = 0,
-	.eccpos = { 0, },
-	.oobfree = { {.offset = 0, .length = 0} }
+static int gpmi_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = chip->priv;
+	struct bch_geometry *geo = &this->bch_geometry;
+	int eccbytes = geo->page_size - mtd->writesize;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int gpmi_oobfree(struct mtd_info *mtd, int section,
+			struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct gpmi_nand_data *this = chip->priv;
+	struct bch_geometry *geo = &this->bch_geometry;
+
+	if (section)
+		return -ERANGE;
+
+	/* The available oob size we have. */
+	if (geo->page_size < mtd->writesize + mtd->oobsize) {
+		oobfree->offset = geo->page_size - mtd->writesize;
+		oobfree->length = mtd->oobsize - oobfree->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops gpmi_ooblayout_ops = {
+	.eccpos = gpmi_eccpos,
+	.oobfree = gpmi_oobfree,
 };
 
 static const struct gpmi_devdata gpmi_devdata_imx23 = {
@@ -141,7 +172,6 @@ static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	struct bch_geometry *geo = &this->bch_geometry;
 	struct mtd_info *mtd = &this->mtd;
 	struct nand_chip *chip = mtd->priv;
-	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
 	unsigned int block_mark_bit_offset;
 
 	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
@@ -229,12 +259,6 @@ static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 	geo->page_size = mtd->writesize + geo->metadata_size +
 		(geo->gf_len * geo->ecc_strength * geo->ecc_chunk_count) / 8;
 
-	/* The available oob size we have. */
-	if (geo->page_size < mtd->writesize + mtd->oobsize) {
-		of->offset = geo->page_size - mtd->writesize;
-		of->length = mtd->oobsize - of->offset;
-	}
-
 	geo->payload_size = mtd->writesize;
 
 	geo->auxiliary_status_offset = ALIGN(geo->metadata_size, 4);
@@ -1861,7 +1885,7 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	ecc->mode	= NAND_ECC_HW;
 	ecc->size	= bch_geo->ecc_chunk_size;
 	ecc->strength	= bch_geo->ecc_strength;
-	ecc->layout	= &gpmi_hw_ecclayout;
+	mtd_set_ooblayout(mtd, &gpmi_ooblayout_ops);
 
 	/*
 	 * We only enable the subpage read when:
diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
index 32a5a4c..dd12cd7 100644
--- a/drivers/mtd/nand/hisi504_nand.c
+++ b/drivers/mtd/nand/hisi504_nand.c
@@ -632,8 +632,28 @@ static void hisi_nfc_host_init(struct hinfc_host *host)
 	hinfc_write(host, HINFC504_INTEN_DMA, HINFC504_INTEN);
 }
 
-static struct nand_ecclayout nand_ecc_2K_16bits = {
-	.oobfree = { {2, 6} },
+static int hisi_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	/* FIXME: add real eccpos definition. */
+	return 0;
+}
+
+static int hisi_oobfree(struct mtd_info *mtd, int section,
+			struct nand_oobfree *oobfree)
+{
+	/* FIXME: add full oobfree definition. */
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 2;
+	oobfree->length = 6;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops hisi_ooblayout_ops = {
+	.eccpos = hisi_eccpos,
+	.oobfree = hisi_oobfree,
 };
 
 static int hisi_nfc_ecc_probe(struct hinfc_host *host)
@@ -669,7 +689,7 @@ static int hisi_nfc_ecc_probe(struct hinfc_host *host)
 	case 16:
 		ecc_bits = 6;
 		if (mtd->writesize == 2048)
-			chip->ecc.layout = &nand_ecc_2K_16bits;
+			mtd_set_ooblayout(mtd, &hisi_ooblayout_ops);
 
 		/* TODO: add more page size support */
 		break;
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index c4fe446..ec8bd6d 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -495,7 +495,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	}
 
 	if (pdata && pdata->ident_callback) {
-		pdata->ident_callback(pdev, chip, &pdata->partitions,
+		pdata->ident_callback(pdev, mtd, &pdata->partitions,
 					&pdata->num_partitions);
 	}
 
diff --git a/drivers/mtd/nand/lpc32xx_mlc.c b/drivers/mtd/nand/lpc32xx_mlc.c
index 0ee81a0..80f66ac 100644
--- a/drivers/mtd/nand/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/lpc32xx_mlc.c
@@ -139,22 +139,36 @@ struct lpc32xx_nand_cfg_mlc {
 	unsigned num_parts;
 };
 
-static struct nand_ecclayout lpc32xx_nand_oob = {
-	.eccbytes = 40,
-	.eccpos = { 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		   22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		   38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		   54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
-	.oobfree = {
-		{ .offset = 0,
-		  .length = 6, },
-		{ .offset = 16,
-		  .length = 6, },
-		{ .offset = 32,
-		  .length = 6, },
-		{ .offset = 48,
-		  .length = 6, },
-		},
+static int lpc32xx_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	int eccbytes = nand_chip->ecc.steps * nand_chip->ecc.bytes;
+	int off = 16 - nand_chip->ecc.bytes;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / nand_chip->ecc.bytes) * 16) + off +
+	       (eccbyte % nand_chip->ecc.bytes);
+}
+
+static int lpc32xx_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+
+	if (section >= nand_chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = 16 * section;
+	oobfree->length = 16 - nand_chip->ecc.bytes;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops lpc32xx_ooblayout_ops = {
+	.eccpos = lpc32xx_eccpos,
+	.oobfree = lpc32xx_oobfree,
 };
 
 static struct nand_bbt_descr lpc32xx_nand_bbt = {
@@ -714,6 +728,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	nand_chip->ecc.write_oob = lpc32xx_write_oob;
 	nand_chip->ecc.read_oob = lpc32xx_read_oob;
 	nand_chip->ecc.strength = 4;
+	nand_chip->ecc.bytes = 10;
 	nand_chip->waitfunc = lpc32xx_waitfunc;
 
 	nand_chip->options = NAND_NO_SUBPAGE_WRITE;
@@ -752,7 +767,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	nand_chip->ecc.mode = NAND_ECC_HW;
 	nand_chip->ecc.size = 512;
-	nand_chip->ecc.layout = &lpc32xx_nand_oob;
+	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
 	host->mlcsubpages = mtd->writesize / 512;
 
 	/* initially clear interrupt status */
diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 47dcfddd..3301c77 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -146,13 +146,34 @@
  * NAND ECC Layout for small page NAND devices
  * Note: For large and huge page devices, the default layouts are used
  */
-static struct nand_ecclayout lpc32xx_nand_oob_16 = {
-	.eccbytes = 6,
-	.eccpos = {10, 11, 12, 13, 14, 15},
-	.oobfree = {
-		{ .offset = 0, .length = 4 },
-		{ .offset = 6, .length = 4 },
-	},
+static int lpc32xx_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 5)
+		return -ERANGE;
+
+	return eccbyte + 10;
+}
+
+static int lpc32xx_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	if (section > 1)
+		return -ERANGE;
+
+	if (!section) {
+		oobfree->offset = 0;
+		oobfree->length = 4;
+	} else {
+		oobfree->offset = 6;
+		oobfree->length = 4;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops lpc32xx_ooblayout_ops = {
+	.eccpos = lpc32xx_eccpos,
+	.oobfree = lpc32xx_oobfree,
 };
 
 static u8 bbt_pattern[] = {'B', 'b', 't', '0' };
@@ -877,7 +898,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	 * custom BBT marker layout.
 	 */
 	if (mtd->writesize <= 512)
-		chip->ecc.layout = &lpc32xx_nand_oob_16;
+		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
 
 	/* These sizes remain the same regardless of page size */
 	chip->ecc.size = 256;
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index f507d36..7ea9c50 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -149,7 +149,7 @@ struct mxc_nand_devtype_data {
 	int (*check_int)(struct mxc_nand_host *);
 	void (*irq_control)(struct mxc_nand_host *, int);
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
-	struct nand_ecclayout *ecclayout_512, *ecclayout_2k, *ecclayout_4k;
+	const struct mtd_ooblayout_ops *ooblayout;
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*correct_data)(struct mtd_info *mtd, u_char *dat,
 			u_char *read_ecc, u_char *calc_ecc);
@@ -201,73 +201,6 @@ struct mxc_nand_host {
 	struct mxc_nand_platform_data pdata;
 };
 
-/* OOB placement block for use with hardware ecc generation */
-static struct nand_ecclayout nandv1_hw_eccoob_smallpage = {
-	.eccbytes = 5,
-	.eccpos = {6, 7, 8, 9, 10},
-	.oobfree = {{0, 5}, {12, 4}, }
-};
-
-static struct nand_ecclayout nandv1_hw_eccoob_largepage = {
-	.eccbytes = 20,
-	.eccpos = {6, 7, 8, 9, 10, 22, 23, 24, 25, 26,
-		   38, 39, 40, 41, 42, 54, 55, 56, 57, 58},
-	.oobfree = {{2, 4}, {11, 10}, {27, 10}, {43, 10}, {59, 5}, }
-};
-
-/* OOB description for 512 byte pages with 16 byte OOB */
-static struct nand_ecclayout nandv2_hw_eccoob_smallpage = {
-	.eccbytes = 1 * 9,
-	.eccpos = {
-		 7,  8,  9, 10, 11, 12, 13, 14, 15
-	},
-	.oobfree = {
-		{.offset = 0, .length = 5}
-	}
-};
-
-/* OOB description for 2048 byte pages with 64 byte OOB */
-static struct nand_ecclayout nandv2_hw_eccoob_largepage = {
-	.eccbytes = 4 * 9,
-	.eccpos = {
-		 7,  8,  9, 10, 11, 12, 13, 14, 15,
-		23, 24, 25, 26, 27, 28, 29, 30, 31,
-		39, 40, 41, 42, 43, 44, 45, 46, 47,
-		55, 56, 57, 58, 59, 60, 61, 62, 63
-	},
-	.oobfree = {
-		{.offset = 2, .length = 4},
-		{.offset = 16, .length = 7},
-		{.offset = 32, .length = 7},
-		{.offset = 48, .length = 7}
-	}
-};
-
-/* OOB description for 4096 byte pages with 128 byte OOB */
-static struct nand_ecclayout nandv2_hw_eccoob_4k = {
-	.eccbytes = 8 * 9,
-	.eccpos = {
-		7,  8,  9, 10, 11, 12, 13, 14, 15,
-		23, 24, 25, 26, 27, 28, 29, 30, 31,
-		39, 40, 41, 42, 43, 44, 45, 46, 47,
-		55, 56, 57, 58, 59, 60, 61, 62, 63,
-		71, 72, 73, 74, 75, 76, 77, 78, 79,
-		87, 88, 89, 90, 91, 92, 93, 94, 95,
-		103, 104, 105, 106, 107, 108, 109, 110, 111,
-		119, 120, 121, 122, 123, 124, 125, 126, 127,
-	},
-	.oobfree = {
-		{.offset = 2, .length = 4},
-		{.offset = 16, .length = 7},
-		{.offset = 32, .length = 7},
-		{.offset = 48, .length = 7},
-		{.offset = 64, .length = 7},
-		{.offset = 80, .length = 7},
-		{.offset = 96, .length = 7},
-		{.offset = 112, .length = 7},
-	}
-};
-
 static const char * const part_probes[] = {
 	"cmdlinepart", "RedBoot", "ofpart", NULL };
 
@@ -943,6 +876,93 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 	}
 }
 
+static int mxc_v1_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	int eccbytes = nand_chip->ecc.steps * nand_chip->ecc.bytes;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / nand_chip->ecc.bytes) * 16) + 6 +
+	       (eccbyte % nand_chip->ecc.bytes);
+}
+
+static int mxc_v1_oobfree(struct mtd_info *mtd, int section,
+			  struct nand_oobfree *oobfree)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+
+	if (section > nand_chip->ecc.steps)
+		return -ERANGE;
+
+	if (!section) {
+		if (mtd->writesize <= 512) {
+			oobfree->offset = 0;
+			oobfree->length = 5;
+		} else {
+			oobfree->offset = 2;
+			oobfree->length = 4;
+		}
+	} else {
+		oobfree->offset = ((section - 1) * 16) +
+				  nand_chip->ecc.bytes + 6;
+		if (section < nand_chip->ecc.steps)
+			oobfree->length = (section * 16) + 6 - oobfree->offset;
+		else
+			oobfree->length = mtd->oobsize - oobfree->offset;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mxc_v1_ooblayout_ops = {
+	.eccpos = mxc_v1_eccpos,
+	.oobfree = mxc_v1_oobfree,
+};
+
+static int mxc_v2_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	int eccbytes = nand_chip->ecc.steps * nand_chip->ecc.bytes;
+	int stepsize = nand_chip->ecc.bytes == 9 ? 16 : 26;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / nand_chip->ecc.bytes) * stepsize) + 7;
+}
+
+static int mxc_v2_oobfree(struct mtd_info *mtd, int section,
+			  struct nand_oobfree *oobfree)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	int stepsize = nand_chip->ecc.bytes == 9 ? 16 : 26;
+
+	if (section > nand_chip->ecc.steps)
+		return -ERANGE;
+
+	if (!section) {
+		if (mtd->writesize <= 512) {
+			oobfree->offset = 0;
+			oobfree->length = 5;
+		} else {
+			oobfree->offset = 2;
+			oobfree->length = 4;
+		}
+	} else {
+		oobfree->offset = section * stepsize;
+		oobfree->length = 7;
+	}
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mxc_v2_ooblayout_ops = {
+	.eccpos = mxc_v2_eccpos,
+	.oobfree = mxc_v2_oobfree,
+};
+
 /*
  * v2 and v3 type controllers can do 4bit or 8bit ecc depending
  * on how much oob the nand chip has. For 8bit ecc we need at least
@@ -960,23 +980,6 @@ static int get_eccsize(struct mtd_info *mtd)
 		return 8;
 }
 
-static void ecc_8bit_layout_4k(struct nand_ecclayout *layout)
-{
-	int i, j;
-
-	layout->eccbytes = 8*18;
-	for (i = 0; i < 8; i++)
-		for (j = 0; j < 18; j++)
-			layout->eccpos[i*18 + j] = i*26 + j + 7;
-
-	layout->oobfree[0].offset = 2;
-	layout->oobfree[0].length = 4;
-	for (i = 1; i < 8; i++) {
-		layout->oobfree[i].offset = i*26;
-		layout->oobfree[i].length = 7;
-	}
-}
-
 static void preset_v1(struct mtd_info *mtd)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -1270,9 +1273,7 @@ static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
 	.get_ecc_status = get_ecc_status_v1,
-	.ecclayout_512 = &nandv1_hw_eccoob_smallpage,
-	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
-	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
+	.ooblayout = &mxc_v1_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v1,
 	.irqpending_quirk = 1,
@@ -1295,9 +1296,7 @@ static const struct mxc_nand_devtype_data imx27_nand_devtype_data = {
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
 	.get_ecc_status = get_ecc_status_v1,
-	.ecclayout_512 = &nandv1_hw_eccoob_smallpage,
-	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
-	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
+	.ooblayout = &mxc_v1_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v1,
 	.irqpending_quirk = 0,
@@ -1321,9 +1320,7 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
 	.get_ecc_status = get_ecc_status_v2,
-	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
-	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
-	.ecclayout_4k = &nandv2_hw_eccoob_4k,
+	.ooblayout = &mxc_v2_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v2,
 	.correct_data = mxc_nand_correct_data_v2_v3,
 	.irqpending_quirk = 0,
@@ -1347,9 +1344,7 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.check_int = check_int_v3,
 	.irq_control = irq_control_v3,
 	.get_ecc_status = get_ecc_status_v3,
-	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
-	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
-	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
+	.ooblayout = &mxc_v2_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v2_v3,
 	.irqpending_quirk = 0,
@@ -1374,9 +1369,7 @@ static const struct mxc_nand_devtype_data imx53_nand_devtype_data = {
 	.check_int = check_int_v3,
 	.irq_control = irq_control_v3,
 	.get_ecc_status = get_ecc_status_v3,
-	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
-	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
-	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
+	.ooblayout = &mxc_v2_ooblayout_ops,
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v2_v3,
 	.irqpending_quirk = 0,
@@ -1578,7 +1571,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 
 	this->select_chip = host->devtype_data->select_chip;
 	this->ecc.size = 512;
-	this->ecc.layout = host->devtype_data->ecclayout_512;
+	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
 
 	if (host->pdata.hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
@@ -1651,12 +1644,11 @@ static int mxcnd_probe(struct platform_device *pdev)
 	/* Call preset again, with correct writesize this time */
 	host->devtype_data->preset(mtd);
 
-	if (mtd->writesize == 2048)
-		this->ecc.layout = host->devtype_data->ecclayout_2k;
-	else if (mtd->writesize == 4096) {
-		this->ecc.layout = host->devtype_data->ecclayout_4k;
-		if (get_eccsize(mtd) == 8)
-			ecc_8bit_layout_4k(this->ecc.layout);
+	if (!this->ecc.bytes) {
+		if (host->eccsize == 8)
+			this->ecc.bytes = 18;
+		else if (host->eccsize == 4)
+			this->ecc.bytes = 9;
 	}
 
 	/*
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 6a598b1..3570e31 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -170,8 +170,6 @@ struct omap_nand_info {
 	u_char				*buf;
 	int					buf_len;
 	struct gpmc_nand_regs		reg;
-	/* generated at runtime depending on ECC algorithm and layout selected */
-	struct nand_ecclayout		oobinfo;
 	/* fields specific for BCHx_HW ECC scheme */
 	struct device			*elm_dev;
 	struct device_node		*of_node;
@@ -1649,19 +1647,98 @@ static bool omap2_nand_ecc_check(struct omap_nand_info *info,
 	return true;
 }
 
+static int omap_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (eccbyte >= chip->ecc.bytes * chip->ecc.steps)
+		return -ERANGE;
+
+	return eccbyte + off;
+}
+
+static int omap_oobfree(struct mtd_info *mtd, int section,
+			struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+	if (section)
+		return -ERANGE;
+
+	off += chip->ecc.bytes * chip->ecc.steps;
+	if (off >= mtd->oobsize)
+		return -ERANGE;
+
+	oobfree->offset = off;
+	oobfree->length = mtd->oobsize - off;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops omap_ooblayout_ops = {
+	.eccpos = omap_eccpos,
+	.oobfree = omap_oobfree,
+};
+
+static int omap_sw_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+
+	if (eccbyte >= chip->ecc.bytes * chip->ecc.steps)
+		return -ERANGE;
+
+	/*
+	 * When SW correction is employed, one OMAP specific marker byte is
+	 * reserved after each ECC step.
+	 */
+	return (eccbyte % chip->ecc.bytes) + (eccbyte / chip->ecc.bytes) + off;
+}
+
+static int omap_sw_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	int off = chip->options & NAND_BUSWIDTH_16 ?
+		  BADBLOCK_MARKER_LENGTH : 1;
+	if (section)
+		return -ERANGE;
+
+	/*
+	 * When SW correction is employed, one OMAP specific marker byte is
+	 * reserved after each ECC step.
+	 */
+	off += ((chip->ecc.bytes + 1) * chip->ecc.steps);
+	if (off >= mtd->oobsize)
+		return -ERANGE;
+
+	oobfree->offset = off;
+	oobfree->length = mtd->oobsize - off;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops omap_sw_ooblayout_ops = {
+	.eccpos = omap_sw_eccpos,
+	.oobfree = omap_sw_oobfree,
+};
+
 static int omap_nand_probe(struct platform_device *pdev)
 {
 	struct omap_nand_info		*info;
 	struct omap_nand_platform_data	*pdata;
 	struct mtd_info			*mtd;
 	struct nand_chip		*nand_chip;
-	struct nand_ecclayout		*ecclayout;
 	int				err;
-	int				i;
 	dma_cap_mask_t			mask;
 	unsigned			sig;
-	unsigned			oob_index;
 	struct resource			*res;
+	int				min_oobbytes;
+	int				oobbytes_per_step;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata == NULL) {
@@ -1821,7 +1898,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	/*
 	 * Bail out earlier to let NAND_ECC_SOFT code create its own
-	 * ecclayout instead of using ours.
+	 * ooblayout instead of using ours.
 	 */
 	if (info->ecc_opt == OMAP_ECC_HAM1_CODE_SW) {
 		nand_chip->ecc.mode = NAND_ECC_SOFT;
@@ -1829,8 +1906,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	/* populate MTD interface based on ECC scheme */
-	ecclayout		= &info->oobinfo;
-	nand_chip->ecc.layout	= ecclayout;
 	switch (info->ecc_opt) {
 	case OMAP_ECC_HAM1_CODE_HW:
 		pr_info("nand: using OMAP_ECC_HAM1_CODE_HW\n");
@@ -1841,19 +1916,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate        = omap_calculate_ecc;
 		nand_chip->ecc.hwctl            = omap_enable_hwecc;
 		nand_chip->ecc.correct          = omap_correct_data;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		if (nand_chip->options & NAND_BUSWIDTH_16)
-			oob_index		= BADBLOCK_MARKER_LENGTH;
-		else
-			oob_index		= 1;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* no reserved-marker in ecclayout for this ecc-scheme */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 		break;
 
 	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
@@ -1865,19 +1929,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
-			ecclayout->eccpos[i] = oob_index;
-			if (((i + 1) % nand_chip->ecc.bytes) == 0)
-				oob_index++;
-		}
-		/* include reserved-marker in ecclayout->oobfree calculation */
-		ecclayout->oobfree->offset	= 1 +
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
@@ -1899,16 +1953,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH4_ECC,
 				 info->mtd.writesize / nand_chip->ecc.size,
@@ -1926,19 +1972,9 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++) {
-			ecclayout->eccpos[i] = oob_index;
-			if (((i + 1) % nand_chip->ecc.bytes) == 0)
-				oob_index++;
-		}
-		/* include reserved-marker in ecclayout->oobfree calculation */
-		ecclayout->oobfree->offset	= 1 +
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
+		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
+		/* Reserve one byte for the OMAP marker */
+		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
 		/* software bch library is used for locating errors */
 		nand_chip->ecc.priv		= nand_bch_init(mtd);
 		if (!nand_chip->ecc.priv) {
@@ -1960,6 +1996,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH8_ECC,
 				 info->mtd.writesize / nand_chip->ecc.size,
@@ -1967,16 +2005,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (err < 0)
 			goto return_error;
 
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
 
 	case OMAP_ECC_BCH16_CODE_HW:
@@ -1990,6 +2018,8 @@ static int omap_nand_probe(struct platform_device *pdev)
 		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
+		oobbytes_per_step		= nand_chip->ecc.bytes;
 
 		err = elm_config(info->elm_dev, BCH16_ECC,
 				 info->mtd.writesize / nand_chip->ecc.size,
@@ -1997,16 +2027,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 		if (err < 0)
 			goto return_error;
 
-		/* define ECC layout */
-		ecclayout->eccbytes		= nand_chip->ecc.bytes *
-							(mtd->writesize /
-							nand_chip->ecc.size);
-		oob_index			= BADBLOCK_MARKER_LENGTH;
-		for (i = 0; i < ecclayout->eccbytes; i++, oob_index++)
-			ecclayout->eccpos[i]	= oob_index;
-		/* reserved marker already included in ecclayout->eccbytes */
-		ecclayout->oobfree->offset	=
-				ecclayout->eccpos[ecclayout->eccbytes - 1] + 1;
 		break;
 	default:
 		dev_err(&info->pdev->dev, "invalid or unsupported ECC scheme\n");
@@ -2014,13 +2034,15 @@ static int omap_nand_probe(struct platform_device *pdev)
 		goto return_error;
 	}
 
-	/* all OOB bytes from oobfree->offset till end off OOB are free */
-	ecclayout->oobfree->length = mtd->oobsize - ecclayout->oobfree->offset;
 	/* check if NAND device's OOB is enough to store ECC signatures */
-	if (mtd->oobsize < (ecclayout->eccbytes + BADBLOCK_MARKER_LENGTH)) {
+	min_oobbytes = (oobbytes_per_step *
+			(mtd->writesize / nand_chip->ecc.size)) +
+		       (nand_chip->options & NAND_BUSWIDTH_16 ?
+			BADBLOCK_MARKER_LENGTH : 1);
+	if (mtd->oobsize < min_oobbytes) {
 		dev_err(&info->pdev->dev,
 			"not enough OOB bytes required = %d, available=%d\n",
-			ecclayout->eccbytes, mtd->oobsize);
+			min_oobbytes, mtd->oobsize);
 		err = -EINVAL;
 		goto return_error;
 	}
diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index bdbc2c2..d0f163f 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -285,6 +285,59 @@ static struct pxa3xx_nand_flash builtin_flash_types[] = {
 	{ 0xba20, 16, 16, &timing[3] },
 };
 
+static int pxa3xx_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
+	int chunk = eccbyte / info->ecc_size;
+	int nchunks = mtd->writesize / info->chunk_size;
+
+	if (chunk >= nchunks)
+		return -ERANGE;
+
+	return (eccbyte % info->ecc_size) + info->spare_size +
+	       ((info->ecc_size + info->spare_size) * chunk);
+}
+
+static int pxa3xx_oobfree(struct mtd_info *mtd, int section,
+			  struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct pxa3xx_nand_host *host = chip->priv;
+	struct pxa3xx_nand_info *info = host->info_data;
+	int nchunks = mtd->writesize / info->chunk_size;
+
+	if (section >= nchunks)
+		return -ERANGE;
+
+	if (!info->spare_size)
+		return 0;
+
+	oobfree->offset = section * (info->ecc_size + info->spare_size);
+	oobfree->length = info->spare_size;
+	if (!section) {
+		/*
+		 * Bootrom looks in bytes 0 & 5 for bad blocks for the
+		 * 4KB page / 4bit BCH combination.
+		 */
+		if (mtd->writesize == 4096 && info->chunk_size == 2048) {
+			oobfree->offset += 6;
+			oobfree->length -= 6;
+		} else {
+			oobfree->offset += 2;
+			oobfree->length -= 2;
+		}
+	}
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops pxa3xx_ooblayout_ops = {
+	.eccpos = pxa3xx_eccpos,
+	.oobfree = pxa3xx_oobfree,
+};
+
 static u8 bbt_pattern[] = {'M', 'V', 'B', 'b', 't', '0' };
 static u8 bbt_mirror_pattern[] = {'1', 't', 'b', 'B', 'V', 'M' };
 
@@ -308,41 +361,6 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = bbt_mirror_pattern
 };
 
-static struct nand_ecclayout ecc_layout_2KB_bch4bit = {
-	.eccbytes = 32,
-	.eccpos = {
-		32, 33, 34, 35, 36, 37, 38, 39,
-		40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55,
-		56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = { {2, 30} }
-};
-
-static struct nand_ecclayout ecc_layout_4KB_bch4bit = {
-	.eccbytes = 64,
-	.eccpos = {
-		32,  33,  34,  35,  36,  37,  38,  39,
-		40,  41,  42,  43,  44,  45,  46,  47,
-		48,  49,  50,  51,  52,  53,  54,  55,
-		56,  57,  58,  59,  60,  61,  62,  63,
-		96,  97,  98,  99,  100, 101, 102, 103,
-		104, 105, 106, 107, 108, 109, 110, 111,
-		112, 113, 114, 115, 116, 117, 118, 119,
-		120, 121, 122, 123, 124, 125, 126, 127},
-	/* Bootrom looks in bytes 0 & 5 for bad blocks */
-	.oobfree = { {6, 26}, { 64, 32} }
-};
-
-static struct nand_ecclayout ecc_layout_4KB_bch8bit = {
-	.eccbytes = 128,
-	.eccpos = {
-		32,  33,  34,  35,  36,  37,  38,  39,
-		40,  41,  42,  43,  44,  45,  46,  47,
-		48,  49,  50,  51,  52,  53,  54,  55,
-		56,  57,  58,  59,  60,  61,  62,  63},
-	.oobfree = { }
-};
-
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -1502,9 +1520,12 @@ static void pxa3xx_nand_free_buff(struct pxa3xx_nand_info *info)
 }
 
 static int pxa_ecc_init(struct pxa3xx_nand_info *info,
-			struct nand_ecc_ctrl *ecc,
+			struct mtd_info *mtd,
 			int strength, int ecc_stepsize, int page_size)
 {
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
 	if (strength == 1 && ecc_stepsize == 512 && page_size == 2048) {
 		info->chunk_size = 2048;
 		info->spare_size = 40;
@@ -1532,7 +1553,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_2KB_bch4bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 
 	} else if (strength == 4 && ecc_stepsize == 512 && page_size == 4096) {
@@ -1542,7 +1563,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_4KB_bch4bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 
 	/*
@@ -1556,7 +1577,7 @@ static int pxa_ecc_init(struct pxa3xx_nand_info *info,
 		info->ecc_size = 32;
 		ecc->mode = NAND_ECC_HW;
 		ecc->size = info->chunk_size;
-		ecc->layout = &ecc_layout_4KB_bch8bit;
+		mtd_set_ooblayout(mtd, &pxa3xx_ooblayout_ops);
 		ecc->strength = 16;
 	} else {
 		dev_err(&info->pdev->dev,
@@ -1647,7 +1668,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		ecc_step = 512;
 	}
 
-	ret = pxa_ecc_init(info, &chip->ecc, ecc_strength,
+	ret = pxa_ecc_init(info, mtd, ecc_strength,
 			   ecc_step, mtd->writesize);
 	if (ret)
 		return ret;
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index b569200..83c3920 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -84,11 +84,29 @@
 
 /* new oob placement block for use with hardware ecc generation
  */
+static int s3c2410_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 2)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int s3c2410_oobfree(struct mtd_info *mtd, int section,
+			   struct nand_oobfree *oobfree)
+{
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 8;
+	oobfree->length = 8;
+
+	return 0;
+}
 
-static struct nand_ecclayout nand_hw_eccoob = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {{8, 8}}
+const struct mtd_ooblayout_ops s3c2410_ooblayout_ops = {
+	.eccpos = s3c2410_eccpos,
+	.oobfree = s3c2410_oobfree,
 };
 
 /* controller and mtd information */
@@ -918,7 +936,7 @@ static void s3c2410_nand_update_chip(struct s3c2410_nand_info *info,
 	} else {
 		chip->ecc.size	    = 512;
 		chip->ecc.bytes	    = 3;
-		chip->ecc.layout    = &nand_hw_eccoob;
+		mtd_set_ooblayout(&nmtd->mtd, &s3c2410_ooblayout_ops);
 	}
 }
 
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 57dc525..0430375 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -43,26 +43,66 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/sh_flctl.h>
 
-static struct nand_ecclayout flctl_4secc_oob_16 = {
-	.eccbytes = 10,
-	.eccpos = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
-	.oobfree = {
-		{.offset = 12,
-		. length = 4} },
+static int flctl_4secc_oob_smallpage_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (eccbyte >= chip->ecc.bytes)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int flctl_4secc_oob_smallpage_oobfree(struct mtd_info *mtd, int section,
+					     struct nand_oobfree *oobfree)
+{
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 12;
+	oobfree->length = 4;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops flctl_4secc_oob_smallpage_ops = {
+	.eccpos = flctl_4secc_oob_smallpage_eccpos,
+	.oobfree = flctl_4secc_oob_smallpage_oobfree,
 };
 
-static struct nand_ecclayout flctl_4secc_oob_64 = {
-	.eccbytes = 4 * 10,
-	.eccpos = {
-		 6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		54, 55, 56, 57, 58, 59, 60, 61, 62, 63 },
-	.oobfree = {
-		{.offset =  2, .length = 4},
-		{.offset = 16, .length = 6},
-		{.offset = 32, .length = 6},
-		{.offset = 48, .length = 6} },
+static int flctl_4secc_oob_largepage_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (eccbyte >= chip->ecc.bytes * chip->ecc.steps)
+		return -ERANGE;
+
+	return ((eccbyte / chip->ecc.bytes) * 16) + 6 +
+	       (eccbyte % chip->ecc.bytes);
+}
+
+static int flctl_4secc_oob_largepage_oobfree(struct mtd_info *mtd, int section,
+					     struct nand_oobfree *oobfree)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+
+	if (section >= chip->ecc.steps)
+		return -ERANGE;
+
+	oobfree->offset = section * 16;
+	oobfree->length = 6;
+
+	if (!section) {
+		oobfree->offset += 2;
+		oobfree->length -= 2;
+	}
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops flctl_4secc_oob_largepage_ops = {
+	.eccpos = flctl_4secc_oob_largepage_eccpos,
+	.oobfree = flctl_4secc_oob_largepage_oobfree,
 };
 
 static uint8_t scan_ff_pattern[] = { 0xff, 0xff };
@@ -987,10 +1027,10 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 
 	if (flctl->hwecc) {
 		if (mtd->writesize == 512) {
-			chip->ecc.layout = &flctl_4secc_oob_16;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_smallpage_ops);
 			chip->badblock_pattern = &flctl_4secc_smallpage;
 		} else {
-			chip->ecc.layout = &flctl_4secc_oob_64;
+			mtd_set_ooblayout(mtd, &flctl_4secc_oob_largepage_ops);
 			chip->badblock_pattern = &flctl_4secc_largepage;
 		}
 
diff --git a/drivers/mtd/nand/sharpsl.c b/drivers/mtd/nand/sharpsl.c
index 082b600..e49eb95 100644
--- a/drivers/mtd/nand/sharpsl.c
+++ b/drivers/mtd/nand/sharpsl.c
@@ -145,6 +145,7 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	/* Link the private data with the MTD structure */
 	sharpsl->mtd.priv = this;
 	sharpsl->mtd.dev.parent = &pdev->dev;
+	mtd_set_ooblayout(&sharpsl->mtd, data->ecc_layout);
 
 	platform_set_drvdata(pdev, sharpsl);
 
@@ -167,7 +168,6 @@ static int sharpsl_nand_probe(struct platform_device *pdev)
 	this->ecc.bytes = 3;
 	this->ecc.strength = 1;
 	this->badblock_pattern = data->badblock_pattern;
-	this->ecc.layout = data->ecc_layout;
 	this->ecc.hwctl = sharpsl_nand_enable_hwecc;
 	this->ecc.calculate = sharpsl_nand_calculate_ecc;
 	this->ecc.correct = nand_correct_data;
diff --git a/drivers/mtd/nand/sm_common.c b/drivers/mtd/nand/sm_common.c
index e06b5e5..398d534 100644
--- a/drivers/mtd/nand/sm_common.c
+++ b/drivers/mtd/nand/sm_common.c
@@ -12,14 +12,46 @@
 #include <linux/sizes.h>
 #include "sm_common.h"
 
-static struct nand_ecclayout nand_oob_sm = {
-	.eccbytes = 6,
-	.eccpos = {8, 9, 10, 13, 14, 15},
-	.oobfree = {
-		{.offset = 0 , .length = 4}, /* reserved */
-		{.offset = 6 , .length = 2}, /* LBA1 */
-		{.offset = 11, .length = 2}  /* LBA2 */
+static int oob_sm_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 5)
+		return -ERANGE;
+
+	if (eccbyte < 3)
+		return eccbyte + 8;
+
+	return eccbyte + 13;
+}
+
+static int oob_sm_oobfree(struct mtd_info *mtd, int section,
+			  struct nand_oobfree *oobfree)
+{
+	switch (section) {
+	case 0:
+		/* reserved */
+		oobfree->offset = 0;
+		oobfree->length = 4;
+		break;
+	case 1:
+		/* LBA1 */
+		oobfree->offset = 6;
+		oobfree->length = 2;
+		break;
+	case 2:
+		/* LBA2 */
+		oobfree->offset = 11;
+		oobfree->length = 2;
+		break;
+	default:
+		return -ERANGE;
 	}
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops oob_sm_ops = {
+	.eccpos = oob_sm_eccpos,
+	.oobfree = oob_sm_oobfree,
 };
 
 /* NOTE: This layout is is not compatabable with SmartMedia, */
@@ -28,15 +60,39 @@ static struct nand_ecclayout nand_oob_sm = {
 /* If you use smftl, it will bypass this and work correctly */
 /* If you not, then you break SmartMedia compliance anyway */
 
-static struct nand_ecclayout nand_oob_sm_small = {
-	.eccbytes = 3,
-	.eccpos = {0, 1, 2},
-	.oobfree = {
-		{.offset = 3 , .length = 2}, /* reserved */
-		{.offset = 6 , .length = 2}, /* LBA1 */
+static int oob_sm_small_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 2)
+		return -ERANGE;
+
+	return eccbyte;
+}
+
+static int oob_sm_small_oobfree(struct mtd_info *mtd, int section,
+				struct nand_oobfree *oobfree)
+{
+	switch (section) {
+	case 0:
+		/* reserved */
+		oobfree->offset = 3;
+		oobfree->length = 2;
+		break;
+	case 1:
+		/* LBA1 */
+		oobfree->offset = 6;
+		oobfree->length = 2;
+		break;
+	default:
+		return -ERANGE;
 	}
-};
 
+	return 0;
+}
+
+const struct mtd_ooblayout_ops oob_sm_small_ops = {
+	.eccpos = oob_sm_small_eccpos,
+	.oobfree = oob_sm_small_oobfree,
+};
 
 static int sm_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
@@ -121,9 +177,9 @@ int sm_register_device(struct mtd_info *mtd, int smartmedia)
 
 	/* ECC layout */
 	if (mtd->writesize == SM_SECTOR_SIZE)
-		chip->ecc.layout = &nand_oob_sm;
+		mtd_set_ooblayout(mtd, &oob_sm_ops);
 	else if (mtd->writesize == SM_SMALL_PAGE)
-		chip->ecc.layout = &nand_oob_sm_small;
+		mtd_set_ooblayout(mtd, &oob_sm_small_ops);
 	else
 		return -ENODEV;
 
diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 1bbcc0c..0443410 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -211,12 +211,9 @@ struct sunxi_nand_chip_sel {
  * sunxi HW ECC infos: stores information related to HW ECC support
  *
  * @mode:	the sunxi ECC mode field deduced from ECC requirements
- * @layout:	the OOB layout depending on the ECC requirements and the
- *		selected ECC mode
  */
 struct sunxi_nand_hw_ecc {
 	int mode;
-	struct nand_ecclayout layout;
 };
 
 /*
@@ -1026,6 +1023,55 @@ static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
 	return sunxi_nand_chip_set_timings(chip, timings);
 }
 
+static int sunxi_nand_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	int eccbytes = ecc->bytes * ecc->steps;
+
+	if (eccbyte >= eccbytes)
+		return -ERANGE;
+
+	return ((eccbyte / ecc->bytes) * (ecc->bytes + 4)) +
+	       (eccbyte % ecc->bytes);
+}
+
+static int sunxi_nand_oobfree(struct mtd_info *mtd, int section,
+			      struct nand_oobfree *oobfree)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+
+	if (section > ecc->steps)
+		return -ERANGE;
+
+	/*
+	 * The first 2 bytes are used for BB markers, hence we
+	 * only have 2 bytes available in the first user data
+	 * section.
+	 */
+	if (!section && ecc->mode == NAND_ECC_HW) {
+		oobfree->offset = 2;
+		oobfree->length = 2;
+
+		return 0;
+	}
+
+	oobfree->offset = section * (ecc->bytes + 4);
+
+	if (section < ecc->steps)
+		oobfree->length = 4;
+	else
+		oobfree->offset = mtd->oobsize - oobfree->offset;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops sunxi_nand_ooblayout_ops = {
+	.eccpos = sunxi_nand_eccpos,
+	.oobfree = sunxi_nand_oobfree,
+};
+
 static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 					      struct nand_ecc_ctrl *ecc,
 					      struct device_node *np)
@@ -1035,7 +1081,6 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
 	struct sunxi_nfc *nfc = to_sunxi_nfc(sunxi_nand->nand.controller);
 	struct sunxi_nand_hw_ecc *data;
-	struct nand_ecclayout *layout;
 	int nsectors;
 	int ret;
 	int i;
@@ -1064,7 +1109,6 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 	/* HW ECC always work with even numbers of ECC bytes */
 	ecc->bytes = ALIGN(ecc->bytes, 2);
 
-	layout = &data->layout;
 	nsectors = mtd->writesize / ecc->size;
 
 	if (mtd->oobsize < ((ecc->bytes + 4) * nsectors)) {
@@ -1072,9 +1116,7 @@ static int sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
 		goto err;
 	}
 
-	layout->eccbytes = (ecc->bytes * nsectors);
-
-	ecc->layout = layout;
+	mtd_set_ooblayout(mtd, &sunxi_nand_ooblayout_ops);
 	ecc->priv = data;
 
 	return 0;
@@ -1094,9 +1136,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 				       struct nand_ecc_ctrl *ecc,
 				       struct device_node *np)
 {
-	struct nand_ecclayout *layout;
-	int nsectors;
-	int i, j;
 	int ret;
 
 	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
@@ -1105,40 +1144,6 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct mtd_info *mtd,
 
 	ecc->read_page = sunxi_nfc_hw_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_ecc_write_page;
-	layout = ecc->layout;
-	nsectors = mtd->writesize / ecc->size;
-
-	for (i = 0; i < nsectors; i++) {
-		if (i) {
-			layout->oobfree[i].offset =
-				layout->oobfree[i - 1].offset +
-				layout->oobfree[i - 1].length +
-				ecc->bytes;
-			layout->oobfree[i].length = 4;
-		} else {
-			/*
-			 * The first 2 bytes are used for BB markers, hence we
-			 * only have 2 bytes available in the first user data
-			 * section.
-			 */
-			layout->oobfree[i].length = 2;
-			layout->oobfree[i].offset = 2;
-		}
-
-		for (j = 0; j < ecc->bytes; j++)
-			layout->eccpos[(ecc->bytes * i) + j] =
-					layout->oobfree[i].offset +
-					layout->oobfree[i].length + j;
-	}
-
-	if (mtd->oobsize > (ecc->bytes + 4) * nsectors) {
-		layout->oobfree[nsectors].offset =
-				layout->oobfree[nsectors - 1].offset +
-				layout->oobfree[nsectors - 1].length +
-				ecc->bytes;
-		layout->oobfree[nsectors].length = mtd->oobsize -
-				((ecc->bytes + 4) * nsectors);
-	}
 
 	return 0;
 }
@@ -1147,9 +1152,6 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 						struct nand_ecc_ctrl *ecc,
 						struct device_node *np)
 {
-	struct nand_ecclayout *layout;
-	int nsectors;
-	int i;
 	int ret;
 
 	ret = sunxi_nand_hw_common_ecc_ctrl_init(mtd, ecc, np);
@@ -1160,15 +1162,6 @@ static int sunxi_nand_hw_syndrome_ecc_ctrl_init(struct mtd_info *mtd,
 	ecc->read_page = sunxi_nfc_hw_syndrome_ecc_read_page;
 	ecc->write_page = sunxi_nfc_hw_syndrome_ecc_write_page;
 
-	layout = ecc->layout;
-	nsectors = mtd->writesize / ecc->size;
-
-	for (i = 0; i < (ecc->bytes * nsectors); i++)
-		layout->eccpos[i] = i;
-
-	layout->oobfree[0].length = mtd->oobsize - i;
-	layout->oobfree[0].offset = i;
-
 	return 0;
 }
 
@@ -1180,7 +1173,6 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
 		sunxi_nand_hw_common_ecc_ctrl_cleanup(ecc);
 		break;
 	case NAND_ECC_NONE:
-		kfree(ecc->layout);
 	default:
 		break;
 	}
@@ -1214,10 +1206,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 			return ret;
 		break;
 	case NAND_ECC_NONE:
-		ecc->layout = kzalloc(sizeof(*ecc->layout), GFP_KERNEL);
-		if (!ecc->layout)
-			return -ENOMEM;
-		ecc->layout->oobfree[0].length = mtd->oobsize;
 	case NAND_ECC_SOFT:
 		break;
 	default:
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index 0413e24..9055ee5 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -173,34 +173,6 @@ struct vf610_nfc {
 
 #define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
 
-static struct nand_ecclayout vf610_nfc_ecc45 = {
-	.eccbytes = 45,
-	.eccpos = {19, 20, 21, 22, 23,
-		   24, 25, 26, 27, 28, 29, 30, 31,
-		   32, 33, 34, 35, 36, 37, 38, 39,
-		   40, 41, 42, 43, 44, 45, 46, 47,
-		   48, 49, 50, 51, 52, 53, 54, 55,
-		   56, 57, 58, 59, 60, 61, 62, 63},
-	.oobfree = {
-		{.offset = 2,
-		 .length = 17} }
-};
-
-static struct nand_ecclayout vf610_nfc_ecc60 = {
-	.eccbytes = 60,
-	.eccpos = { 4,  5,  6,  7,  8,  9, 10, 11,
-		   12, 13, 14, 15, 16, 17, 18, 19,
-		   20, 21, 22, 23, 24, 25, 26, 27,
-		   28, 29, 30, 31, 32, 33, 34, 35,
-		   36, 37, 38, 39, 40, 41, 42, 43,
-		   44, 45, 46, 47, 48, 49, 50, 51,
-		   52, 53, 54, 55, 56, 57, 58, 59,
-		   60, 61, 62, 63 },
-	.oobfree = {
-		{.offset = 2,
-		 .length = 2} }
-};
-
 static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
 {
 	return readl(nfc->regs + reg);
@@ -780,14 +752,16 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		if (mtd->oobsize > 64)
 			mtd->oobsize = 64;
 
+		/*
+		 * mtd->ecclayout is not specified here because we're using the
+		 * default large page ECC layout defined in NAND core.
+		 */
 		if (chip->ecc.strength == 32) {
 			nfc->ecc_mode = ECC_60_BYTE;
 			chip->ecc.bytes = 60;
-			chip->ecc.layout = &vf610_nfc_ecc60;
 		} else if (chip->ecc.strength == 24) {
 			nfc->ecc_mode = ECC_45_BYTE;
 			chip->ecc.bytes = 45;
-			chip->ecc.layout = &vf610_nfc_ecc45;
 		} else {
 			dev_err(nfc->dev, "Unsupported ECC strength\n");
 			err = -ENXIO;
diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
index 25f4d2a..a8c23b2 100644
--- a/include/linux/mtd/sharpsl.h
+++ b/include/linux/mtd/sharpsl.h
@@ -14,7 +14,7 @@
 
 struct sharpsl_nand_platform_data {
 	struct nand_bbt_descr	*badblock_pattern;
-	struct nand_ecclayout	*ecc_layout;
+	struct nand_ooblayout_ops *ecc_layout;
 	struct mtd_partition	*partitions;
 	unsigned int		nr_partitions;
 };
-- 
2.1.4
