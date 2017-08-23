Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 04:58:32 +0200 (CEST)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:33332
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdHWC5uql3bs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 04:57:50 +0200
Received: by mail-pg0-x243.google.com with SMTP id u191so466830pgc.0;
        Tue, 22 Aug 2017 19:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ekVX0WDulSXFH7+W+0xBdHtVUnqWbhQlWu6pacdqS2w=;
        b=X+1i+VbrmTAGUG4mWeG9qMMNQBwLW5UKBMHaE09yCtbxMq59uaEjNE1v55mAztQY4D
         UL7jSLSAp5OFqJ4X6cU28D8dm+wu5GX4fztwFjSQzMjXGWv0Dx494LFwSZSDtAsD+w/K
         3CtNzHmsMuWm7F7xBEuD7yZJSrJJs1FR3pDZEi3N5LkkGGQJ9gb5/FLR4s/304DesYfp
         RvO04NTISxeYLWC7sFPjzdTTWpSUwXc94oH3QQmFu9+VOFpbw3AcCF8Rt9YeTsWjwAxj
         11YXwKT3xKiLaoJevkNvuod0dm6MxKILxSIe8S0tZAoTnq9SUjse9JA+YmbhdwIl4mW5
         xwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ekVX0WDulSXFH7+W+0xBdHtVUnqWbhQlWu6pacdqS2w=;
        b=ODnwng+bs+OEjlOfvH5gb5L25K52VkmLKs0t7u5+jGL0RzkpNKVkCnCsUWCw+RkUVM
         dvp56SnEpnMk29qcBE56YwO9NQhJfeKgHhEv/btFTt1h/5Uz7s0xifOoa+sk/PeHEZrP
         bwl8f7NlYQYpLaf6fwTL6GKjvJDjg1vKEtui7bnCDf9QL/vbE5TgyN5pXPN5zl0m4RiO
         JNoXHIXUq/A/jxBP01AoXqVeD92Sebo3FE31puiZwxNkMNDUPf/wrAIwZ2aa6F2+f1bl
         fQcwt3eXvvmY4zKzl055vIIZKkIHv+ytKPa9OpDAjMTA9/xi+DJ3M+Siy6isYGUVT/lk
         MTkQ==
X-Gm-Message-State: AHYfb5gCAIwcTmro3O1gTWjwUnIVyHBdAHIoYdK338dbSjIzA4O2xDUv
        iK5DhBgvf6/vb3Q6Y8i10Q==
X-Received: by 10.98.214.216 with SMTP id a85mr1237890pfl.292.1503457064788;
        Tue, 22 Aug 2017 19:57:44 -0700 (PDT)
Received: from linux.local ([42.109.139.20])
        by smtp.gmail.com with ESMTPSA id 10sm489771pfs.131.2017.08.22.19.57.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 19:57:44 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, ralf@linux-mips.org,
        paul@crapouillou.net, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2 2/4] crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
Date:   Wed, 23 Aug 2017 08:27:05 +0530
Message-Id: <20170823025707.27888-3-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59766
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
Changes in v2:
* Fixed buffer overflow in generate function pointed out in Stephan's review
* Fold patch that had only MAINTAINERS file change with this patch
* Removed unnecessary comment in code

 MAINTAINERS                 |   5 ++
 drivers/crypto/Kconfig      |  19 +++++
 drivers/crypto/Makefile     |   1 +
 drivers/crypto/jz4780-rng.c | 168 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+)
 create mode 100644 drivers/crypto/jz4780-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c3feff..f662a70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6672,6 +6672,11 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/jz4780_*
 
+INGENIC JZ4780 PRNG DRIVER
+M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+S:	Maintained
+F:	drivers/crypto/jz4780-rng.c
+
 INOTIFY
 M:	John McCutchan <john@johnmccutchan.com>
 M:	Robert Love <rlove@rlove.org>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 4b75084..de2459f 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -599,6 +599,25 @@ config CRYPTO_DEV_IMGTEC_HASH
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
index 2c555a3..1df48f9 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_CRYPTO_DEV_GEODE) += geode-aes.o
 obj-$(CONFIG_CRYPTO_DEV_HIFN_795X) += hifn_795x.o
 obj-$(CONFIG_CRYPTO_DEV_IMGTEC_HASH) += img-hash.o
 obj-$(CONFIG_CRYPTO_DEV_IXP4XX) += ixp4xx_crypto.o
+obj-$(CONFIG_CRYPTO_DEV_JZ4780_RNG) += jz4780-rng.o
 obj-$(CONFIG_CRYPTO_DEV_MV_CESA) += mv_cesa.o
 obj-$(CONFIG_CRYPTO_DEV_MARVELL_CESA) += marvell/
 obj-$(CONFIG_CRYPTO_DEV_MEDIATEK) += mediatek/
diff --git a/drivers/crypto/jz4780-rng.c b/drivers/crypto/jz4780-rng.c
new file mode 100644
index 0000000..4444682
--- /dev/null
+++ b/drivers/crypto/jz4780-rng.c
@@ -0,0 +1,168 @@
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
+	 * A delay is required so that the current RNG data is not bit shifted
+	 * version of previous RNG data which could happen if random data is
+	 * read continuously from this device.
+	 */
+	jz4780_rng_writel(rng, 1, REG_RNG_CTRL);
+	while (dlen >= 4) {
+		data = jz4780_rng_readl(rng, REG_RNG_DATA);
+		memcpy((void *)dst, (void *)&data, 4);
+		dlen -= 4;
+		dst += 4;
+		udelay(20);
+	};
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
