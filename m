Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2018 00:42:06 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:35772 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994671AbeIFWj3BIp2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Sep 2018 00:39:29 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4672220A32; Fri,  7 Sep 2018 00:39:24 +0200 (CEST)
Received: from localhost.localdomain (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9919520379;
        Fri,  7 Sep 2018 00:39:12 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Alexander Clouter <alex@digriz.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH 13/19] mtd: rawnand: Get rid of a few unused definitions
Date:   Fri,  7 Sep 2018 00:38:45 +0200
Message-Id: <20180906223851.6964-14-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

Those definitions are not used, let's remove them.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_timings.c | 14 --------------
 include/linux/mtd/rawnand.h         |  8 --------
 2 files changed, 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index ebc7b5f76f77..cb4f0007b65c 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -270,20 +270,6 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 	},
 };
 
-/**
- * onfi_async_timing_mode_to_sdr_timings - [NAND Interface] Retrieve NAND
- * timings according to the given ONFI timing mode
- * @mode: ONFI timing mode
- */
-const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode)
-{
-	if (mode < 0 || mode >= ARRAY_SIZE(onfi_sdr_timings))
-		return ERR_PTR(-EINVAL);
-
-	return &onfi_sdr_timings[mode].timings.sdr;
-}
-EXPORT_SYMBOL(onfi_async_timing_mode_to_sdr_timings);
-
 /**
  * onfi_fill_data_interface - [NAND Interface] Initialize a data interface from
  * given ONFI mode
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 608279104aae..8aa8b57ca4b1 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -119,10 +119,6 @@ enum nand_ecc_algo {
 #define NAND_ECC_GENERIC_ERASED_CHECK	BIT(0)
 #define NAND_ECC_MAXIMIZE		BIT(1)
 
-/* Bit mask for flags passed to do_nand_read_ecc */
-#define NAND_GET_DEVICE		0x80
-
-
 /*
  * Option constants for bizarre disfunctionality and real
  * features.
@@ -163,9 +159,7 @@ enum nand_ecc_algo {
 #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
 
 /* Macros to identify the above */
-#define NAND_HAS_CACHEPROG(chip) ((chip->options & NAND_CACHEPRG))
 #define NAND_HAS_SUBPAGE_READ(chip) ((chip->options & NAND_SUBPAGE_READ))
-#define NAND_HAS_SUBPAGE_WRITE(chip) !((chip)->options & NAND_NO_SUBPAGE_WRITE)
 
 /* Non chip related options */
 /* This option skips the bbt scan during initialization. */
@@ -1649,8 +1643,6 @@ static inline int nand_opcode_8bits(unsigned int command)
 	return 0;
 }
 
-/* get timing characteristics from ONFI timing mode. */
-const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
 
 int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *ecc, int ecclen,
-- 
2.14.1
