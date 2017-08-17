Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 20:27:09 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:38543
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994893AbdHQS01C11S7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 20:26:27 +0200
Received: by mail-pg0-x243.google.com with SMTP id 123so11057825pga.5;
        Thu, 17 Aug 2017 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e0OY/eN/tx1Py9r6w4CgrpElQaigNc2aqwnwsVqs1A8=;
        b=QW9VtcHhs2uNmQHdaLJwW6010rIyf0doSH1Rm+QTnvKgMOqlfpFy+P8Ro2s5r6npgM
         Qpx4GuXpHMHDRBVbccTRU1sC/ENXfvHMDDaQWkLFb9jAIGuCYDiXIpGE36HZXB+azGtM
         +g7lb0fORy8WWOg7Jg7plTKZKPV98tU7FHoftv+Oz0SJB9i9x/ar8J8xPLpezHnLQtpT
         dvjgNPaIFsjTi1zyOFK6BhLEp57h8MNzVqpub+AgWKsRxKGzbvsTYVfEBgX8QYKBm949
         qWFN3GelP/pDOBTmKyYh75jzAFWuey00d7LLMFusKLrDE3EehgZtyZ/KoCV/hJb2BPrI
         e7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e0OY/eN/tx1Py9r6w4CgrpElQaigNc2aqwnwsVqs1A8=;
        b=ex+TTWJH/wv6SXVLK6uAtLm3SzaIYjxy4hCJWMAoKOmXxp4wEPf2j6AdwMpMQfScPQ
         c9PxK7Q6b08wQXisdQv34ILP8C63HDDWP0v/ksJtEFzOxyoOyHHX5PFTSkEYaqeWwcU/
         mmg7OTLCynzBDR2kevzNa6xryCLmsJh+/V0NXXX7r618FkTZbZjDh7JKh4O/3jl++th3
         KPhiJUxMb9JjDeWDm9MWB9vpZNBbkRVcwnvf/ELQDSKyzNZsQffcOEvEw0u4Vev0W8wf
         hmij2Vykgb8Lo+US0YFDslW3UGgJE510Kv4Hujl+JkuAt8Ty1q+DM32lE4PvOf4PxTv7
         1u8Q==
X-Gm-Message-State: AHYfb5h78ARJ+rx4hDFKbFCyzsQw5FiC7YbMIEZI3CyOGSxKhZgaiJ7j
        j4Y6f53FDkDt4w==
X-Received: by 10.98.205.202 with SMTP id o193mr6086257pfg.313.1502994381018;
        Thu, 17 Aug 2017 11:26:21 -0700 (PDT)
Received: from linux.local ([42.109.133.212])
        by smtp.gmail.com with ESMTPSA id a86sm8882565pfe.181.2017.08.17.11.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 11:26:20 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, ralf@linux-mips.org, mturquette@baylibre.com,
        sboyd@codeaurora.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH 3/6] crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
Date:   Thu, 17 Aug 2017 23:55:17 +0530
Message-Id: <20170817182520.20102-4-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

JZ4780 SoC pseudo random number generator driver using crypto framework.

Adding a delay before reading RNG data and disabling RNG after reading
data was suggested by Jeffery Walton.

Tested-by: Mathieu Malaterre <malat@debian.org>
Suggested-by: Jeffrey Walton <noloader@gmail.com>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/crypto/Kconfig      |  19 +++++
 drivers/crypto/Makefile     |   1 +
 drivers/crypto/jz4780-rng.c | 173 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/crypto/jz4780-rng.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 8fa7e72..8263622 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -614,6 +614,25 @@ config CRYPTO_DEV_IMGTEC_HASH
 	  hardware hash accelerator. Supporting MD5/SHA1/SHA224/SHA256
 	  hashing algorithms.
 
+config CRYPTO_DEV_JZ4780_RNG
+	tristate "JZ4780 HW pseudo random number generator support"
+	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select CRYPTO_RNG
+	select REGMAP
+	select SYSCON
+	select MFD_SYSCON
+	---help---
+	  This driver provides kernel-side support through the
+	  cryptographic API for the pseudo random number generator
+	  hardware found in ingenic JZ4780 and X1000 SoC. MIPS
+	  Creator CI20 uses JZ4780 SoC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called jz4780-rng.
+
+	  If unsure, say Y.
+
 config CRYPTO_DEV_SUN4I_SS
 	tristate "Support for Allwinner Security System cryptographic accelerator"
 	depends on ARCH_SUNXI && !64BIT
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index b12eb3c..3a3d970 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CRYPTO_DEV_GEODE) += geode-aes.o
 obj-$(CONFIG_CRYPTO_DEV_HIFN_795X) += hifn_795x.o
 obj-$(CONFIG_CRYPTO_DEV_IMGTEC_HASH) += img-hash.o
 obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
+obj-$(CONFIG_CRYPTO_DEV_JZ4780_RNG) += jz4780-rng.o
 obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
 obj-$(CONFIG_CRYPTO_DEV_MARVELL_CESA) += marvell/
 obj-$(CONFIG_CRYPTO_DEV_MEDIATEK) += mediatek/
diff --git a/drivers/crypto/jz4780-rng.c b/drivers/crypto/jz4780-rng.c
new file mode 100644
index 0000000..a03f2a0
--- /dev/null
+++ b/drivers/crypto/jz4780-rng.c
@@ -0,0 +1,173 @@
+/*
+ * jz4780-rng.c - Random Number Generator driver for the jz4780
+ *
+ * Copyright (c) 2017 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation;
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/crypto.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <crypto/internal/rng.h>
+
+#define REG_RNG_CTRL	0xD8
+#define REG_RNG_DATA	0xDC
+
+/* Context for crypto */
+struct jz4780_rng_ctx {
+	struct jz4780_rng *rng;
+};
+
+/* Device associated memory */
+struct jz4780_rng {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static struct jz4780_rng *jz4780_rng;
+
+static int jz4780_rng_readl(struct jz4780_rng *rng, u32 offset)
+{
+	u32 val = 0;
+	int ret;
+
+	ret = regmap_read(rng->regmap, offset, &val);
+	if (!ret)
+		return val;
+
+	return ret;
+}
+
+static int jz4780_rng_writel(struct jz4780_rng *rng, u32 val, u32 offset)
+{
+	return regmap_write(rng->regmap, offset, val);
+}
+
+static int jz4780_rng_generate(struct crypto_rng *tfm,
+			       const u8 *src, unsigned int slen,
+			       u8 *dst, unsigned int dlen)
+{
+	struct jz4780_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct jz4780_rng *rng = ctx->rng;
+	u32 data;
+
+	/*
+	 * JZ4780 Programmers manual says the RNG should not run continuously
+	 * for more than 1s. So enable RNG, read data and disable it.
+	 * NOTE: No issue was observed with MIPS creator CI20 board even when
+	 * RNG ran continuously for longer periods. This is just a precaution.
+	 *
+	 * A delay is required so that the current RNG data is not bit shifted
+	 * version of previous RNG data which could happen if random data is
+	 * read continuously from this device.
+	 */
+	jz4780_rng_writel(rng, 1, REG_RNG_CTRL);
+	do {
+		data = jz4780_rng_readl(rng, REG_RNG_DATA);
+		memcpy((void *)dst, (void *)&data, 4);
+		dlen -= 4;
+		dst += 4;
+		udelay(20);
+	} while (dlen >= 4);
+
+	if (dlen > 0) {
+		data = jz4780_rng_readl(rng, REG_RNG_DATA);
+		memcpy((void *)dst, (void *)&data, dlen);
+	}
+	jz4780_rng_writel(rng, 0, REG_RNG_CTRL);
+
+	return 0;
+}
+
+static int jz4780_rng_kcapi_init(struct crypto_tfm *tfm)
+{
+	struct jz4780_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	ctx->rng = jz4780_rng;
+
+	return 0;
+}
+
+static struct rng_alg jz4780_rng_alg = {
+	.generate		= jz4780_rng_generate,
+	.base			= {
+		.cra_name		= "stdrng",
+		.cra_driver_name	= "jz4780_rng",
+		.cra_priority		= 100,
+		.cra_ctxsize		= sizeof(struct jz4780_rng_ctx),
+		.cra_module		= THIS_MODULE,
+		.cra_init		= jz4780_rng_kcapi_init,
+	}
+};
+
+static int jz4780_rng_probe(struct platform_device *pdev)
+{
+	struct jz4780_rng *rng;
+	struct resource *res;
+	int ret;
+
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rng->regmap = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(rng->regmap))
+		return PTR_ERR(rng->regmap);
+
+	jz4780_rng = rng;
+
+	ret = crypto_register_rng(&jz4780_rng_alg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Couldn't register rng crypto alg: %d\n", ret);
+		jz4780_rng = NULL;
+	}
+
+	return ret;
+}
+
+static int jz4780_rng_remove(struct platform_device *pdev)
+{
+	crypto_unregister_rng(&jz4780_rng_alg);
+
+	jz4780_rng = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id jz4780_rng_dt_match[] = {
+	{
+		.compatible = "ingenic,jz4780-rng",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, jz4780_rng_dt_match);
+
+static struct platform_driver jz4780_rng_driver = {
+	.driver		= {
+		.name	= "jz4780-rng",
+		.of_match_table = jz4780_rng_dt_match,
+	},
+	.probe		= jz4780_rng_probe,
+	.remove		= jz4780_rng_remove,
+};
+
+module_platform_driver(jz4780_rng_driver);
+
+MODULE_DESCRIPTION("Ingenic JZ4780 H/W Pseudo Random Number Generator driver");
+MODULE_AUTHOR("PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.10.0
