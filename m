Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 22:48:36 +0200 (CEST)
Received: from smtp-out-121.synserver.de ([212.40.185.121]:1054 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6834678AbaDVUqwJBRhm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 22:46:52 +0200
Received: (qmail 18712 invoked by uid 0); 22 Apr 2014 20:46:47 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 18380
Received: from ppp-188-174-45-35.dynamic.mnet-online.de (HELO lars-adi-laptop.fritz.box) [188.174.45.35]
  by 217.119.54.96 with SMTP; 22 Apr 2014 20:46:47 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: jz4740: Improve build test coverage
Date:   Tue, 22 Apr 2014 22:46:36 +0200
Message-Id: <1398199596-23649-6-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Allow the jz4740 audio drivers to be build when CONFIG_COMPILE_TEST is selected.
This should improve the build test coverage. There is one small piece of
platform dependent code in the jz4740-i2s driver. It uses the DMA request type
constants which are defined in a platform specific header. We can solve this by
moving them from the platform specific header to the I2S driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Preferably this should go through the ASoC tree, but needs an Ack from Ralf for
the MIPS portions.
---
 arch/mips/include/asm/mach-jz4740/dma.h |  2 --
 sound/soc/jz4740/Kconfig                | 11 ++++++++---
 sound/soc/jz4740/jz4740-i2s.c           |  5 +++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/mach-jz4740/dma.h b/arch/mips/include/asm/mach-jz4740/dma.h
index 509cd58..14ecc53 100644
--- a/arch/mips/include/asm/mach-jz4740/dma.h
+++ b/arch/mips/include/asm/mach-jz4740/dma.h
@@ -22,8 +22,6 @@ enum jz4740_dma_request_type {
 	JZ4740_DMA_TYPE_UART_RECEIVE	= 21,
 	JZ4740_DMA_TYPE_SPI_TRANSMIT	= 22,
 	JZ4740_DMA_TYPE_SPI_RECEIVE	= 23,
-	JZ4740_DMA_TYPE_AIC_TRANSMIT	= 24,
-	JZ4740_DMA_TYPE_AIC_RECEIVE	= 25,
 	JZ4740_DMA_TYPE_MMC_TRANSMIT	= 26,
 	JZ4740_DMA_TYPE_MMC_RECEIVE	= 27,
 	JZ4740_DMA_TYPE_TCU		= 28,
diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index 29f76af..1a354a6 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -1,24 +1,29 @@
 config SND_JZ4740_SOC
 	tristate "SoC Audio for Ingenic JZ4740 SoC"
-	depends on MACH_JZ4740 && SND_SOC
+	depends on MACH_JZ4740 || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the JZ4740 I2S interface. You will also need to select the audio
 	  interfaces to support below.
 
+if SND_JZ4740_SOC
+
 config SND_JZ4740_SOC_I2S
-	depends on SND_JZ4740_SOC
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
+	depends on HAS_IOMEM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
 	  based boards.
 
 config SND_JZ4740_SOC_QI_LB60
 	tristate "SoC Audio support for Qi LB60"
-	depends on SND_JZ4740_SOC && JZ4740_QI_LB60
+	depends on HAS_IOMEM
+	depends on JZ4740_QI_LB60 || COMPILE_TEST
 	select SND_JZ4740_SOC_I2S
     select SND_SOC_JZ4740_CODEC
 	help
 	  Say Y if you want to add support for ASoC audio on the Qi LB60 board
 	  a.k.a Qi Ben NanoNote.
+
+endif
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 8f22000..3f9c3a9 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -31,10 +31,11 @@
 #include <sound/initval.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <asm/mach-jz4740/dma.h>
-
 #include "jz4740-i2s.h"
 
+#define JZ4740_DMA_TYPE_AIC_TRANSMIT 24
+#define JZ4740_DMA_TYPE_AIC_RECEIVE 25
+
 #define JZ_REG_AIC_CONF		0x00
 #define JZ_REG_AIC_CTRL		0x04
 #define JZ_REG_AIC_I2S_FMT	0x10
-- 
1.8.0
