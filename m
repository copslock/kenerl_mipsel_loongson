Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 16:05:06 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:35784
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992982AbdIROEPuBvoY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 16:04:15 +0200
Received: by mail-pg0-x244.google.com with SMTP id j16so296523pga.2;
        Mon, 18 Sep 2017 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ma8TmwN4gkxu4g3yi5ZEeI5tEseBQh0QcbIt7CgT/Gc=;
        b=EN9EXhlkuJFDfO+pAeyLbghfjZOldqtiEtoaGQcNBcdz/vlttET6kqGR8Q1HyTUG1B
         9ONWQ60gswPCvIoGwoZgJ24rRY6CmS9aunhkj0A445W6IGx5Ck71k/YCjTLnYOI5NEsY
         EBCPoX2TPhSzWU1eaIfGB8oSAoRqeoDCGjL645c1howkOJrIqsx94AO9FSISyCErmoKF
         MLjEolPH8j0bjPKH84Cl2n5ODWTlRPytZOqh7N97CFXcWjwnummJVVrTI6ysprzflRdV
         pGkkrsV2LlFXx0QUthulPKu1g6Ic4nDU2Fc9e6LEPqrlMecAcb5vwMw7GK5Y2nE8vbM7
         S3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ma8TmwN4gkxu4g3yi5ZEeI5tEseBQh0QcbIt7CgT/Gc=;
        b=d/2sWblJYTvxlgW66kvDew+PmifrFZjvH8zATiu9z4ny4j+OKA62f6HNev/tiZAnzC
         pmbgl7j6Tjp8xtSAghOP1lc1bWEOvOUo6j21Yur8MbTyA7H4XSmoZLUEELWLYXrH7kU/
         s05xKroieNtK5iKhF+cRzuHW+i3YsqUoGDtETErYUp3dTnqQnPk84nlFc3bn0dR4Y5eH
         rrzLgXsO3RdQXmG9MbsdaVHoaJk9DW5uBgKjabO/+fibNGq4egkHJu4ac3zlosSEx2gT
         bHvPqImaVR7ULyWTHeoIyjFmkNPURckodjCWR9VjyHEyjajKibHkviAAwTb5oMX/70D4
         EN8w==
X-Gm-Message-State: AHPjjUjq58AnNCkPbyR/PQa3UPk67x5XFsLJfV/JVA6T80hDJKYGaLRz
        py/bAqq+RTlX+A==
X-Google-Smtp-Source: ADKCNb5nYyjOadPeB4+BFELpEbVY4iGvKZIDG4PzU4cKMgseaQbjsI84Rk20bPvOsUXA+U8QbPGs+w==
X-Received: by 10.99.174.8 with SMTP id q8mr33072340pgf.125.1505743449486;
        Mon, 18 Sep 2017 07:04:09 -0700 (PDT)
Received: from linux.local ([43.224.131.38])
        by smtp.gmail.com with ESMTPSA id q77sm14683252pfa.173.2017.09.18.07.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 07:04:08 -0700 (PDT)
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To:     herbert@gondor.apana.org.au, robh+dt@kernel.org,
        ralf@linux-mips.org, davem@davemloft.net, paul@crapouillou.net,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        malat@debian.org, noloader@gmail.com
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v3 2/4] crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
Date:   Mon, 18 Sep 2017 19:32:39 +0530
Message-Id: <20170918140241.24003-3-prasannatsmkumar@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60058
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
Changes in v3:
* Add seeding support
* Reduce delay

Changes in v2:                                                                      
* Fixed buffer overflow in generate function pointed out in Stephan's review        
* Fold patch that had only MAINTAINERS file change with this patch                  
* Removed unnecessary comment in code                                               

 MAINTAINERS                 |   7 ++
 drivers/crypto/Kconfig      |  19 +++++
 drivers/crypto/Makefile     |   1 +
 drivers/crypto/jz4780-rng.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 drivers/crypto/jz4780-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2093060..d2341a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6783,6 +6783,13 @@ L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/jz4780_*
 
+INGENIC JZ4780 PRNG DRIVER
+M:	PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/jz4780-rng.c
+F:	Documentation/devicetree/bindings/rng/ingenic,jz4780-rng.txt
+
 INOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index fe33c19..f3ac1cd 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -613,6 +613,25 @@ config CRYPTO_DEV_IMGTEC_HASH
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
index 808432b..a09d9f4 100644
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
index 0000000..918ba94
--- /dev/null
+++ b/drivers/crypto/jz4780-rng.c
@@ -0,0 +1,193 @@
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
+	u32 seed;
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
+static int jz4780_rng_seed(struct crypto_rng *tfm, const u8 *seed,
+			   unsigned int slen)
+{
+	struct jz4780_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct jz4780_rng *rng = ctx->rng;
+
+	memcpy((void *)&rng->seed, seed, slen);
+
+	return 0;
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
+
+	/* Write seed */
+	jz4780_rng_writel(rng, rng->seed, REG_RNG_DATA);
+
+	while (dlen >= 4) {
+		udelay(2);
+		data = jz4780_rng_readl(rng, REG_RNG_DATA);
+		memcpy((void *)dst, (void *)&data, 4);
+		dlen -= 4;
+		dst += 4;
+	};
+
+	if (dlen > 0) {
+		udelay(2);
+		data = jz4780_rng_readl(rng, REG_RNG_DATA);
+		memcpy((void *)dst, (void *)&data, dlen);
+	}
+
+	udelay(2);
+	/* Update the seed */
+	data = jz4780_rng_readl(rng, REG_RNG_DATA);
+	rng->seed = data;
+
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
+	.seed			= jz4780_rng_seed,
+	.seedsize		= 4,
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
