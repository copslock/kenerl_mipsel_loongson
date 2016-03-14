Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 15:22:07 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.133]:52542 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007830AbcCNOWDW6kaq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 15:22:03 +0100
Received: from wuerfel.lan. ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue003) with ESMTPA (Nemesis) id 0MHtl3-1agqQ615Kf-003bLO; Mon, 14 Mar
 2016 15:21:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul@pwsan.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Firmware: broadcom sprom: clarifiy SSB dependency
Date:   Mon, 14 Mar 2016 15:21:32 +0100
Message-Id: <1457965305-3258441-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.0
X-Provags-ID: V03:K0:x0pDF1Js8HPOOfBa7kW7FOXb/xOHPIBTjfqcrzQkQUaNFUdB3/G
 tqsEQB87ei2KuuLXdnr/PznkVcgXBJFotEyoL6noz1wvshnHsewkFqZM+aeoATsFH1OQYVA
 qxS7bxLoK4YQixS43fvUeJNHHMSG1+1AnXslFyHHdCi4+JpPFtzUh3nOYmxVptJJ5+7r8kG
 yqEBaWWwBFgu5VrAvmk3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KcRIr5zMXAY=:zNAZhzWgi/tEklZ6mLy5Sq
 I2SjZf4hlDbOpaNIjWwqdjVMNfPt+jKOUPBSuzMoBmVqP21QuPrNUFJ8fC5+RiS41LrgdLbck
 LlFhzRieGznDa6qfkkk0HXRu7U8hpALAgxBp+YUBxy2YYJurv+/GnKSoCSXEvtmgfGSQy/wcc
 eFZXBZgSPugY3Wpw1hjTOy+uU0r9ZIHdcxcLWOgyKuaOQmRM1NUv27brbYDMGm6wgl21quvJ+
 zXn7XVlGk5xH81wldaegkGQfehgsYdnkRWTMSnt9apjj0IrMHoBB4R2j29XbwL4UdDh9oNWKt
 hPykGoZltIA67ShZue+Ja21DxHIqHYr56ZCge5tIHTXbyXDfSqQn+W0Xb1VsrnZbAvxaeNxkA
 8ZRMhWPChZJH3ICM4irPeaYcYWQRdfarJkUlGwVMVgfztiLwYyrwKCSvn5hZsEi6B78+eeXGq
 Rs/nNyDnVNO3kMYMVo/yrgU7oOXElM3H0fg1FhhnGrIX4AeewrHPr6hwB2z2nEh8ttqVi8+B+
 KWqLJmEsIlCArvI3mFfRKQ+jrMuvq+F05lwKIFHolDfA6iLJCyplpMLsDTMu7v0e3ukt5yUZh
 nlY5Dc1ZjrPPQZZcfnpXPWMQSqyVqBwGHyisB1S78fW6Gl48eRIhxaz1rkSY9bRj5Wk3KLBeU
 x/Pb3FLgNOQDEqhl4Ur6fZ7ksaG75H8CtYWOcm++tQnkovP10QEm/aeZl6YhCNs2pSQQ=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The broadcom firmware drvier calls into the ssb SPROM code if that
is enabled, but it fails if the SSB code is in a loadable module
because the bcm47xx firmware is always built-in:

drivers/firmware/built-in.o: In function `bcm47xx_sprom_register_fallbacks':
bcm47xx_sprom.c:(.text+0x11c4): undefined reference to `ssb_arch_register_fallback_sprom'

This adds a Kconfig dependency to ensure that we cannot turn on the
generic sprom support if the ssb sprom is in a module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/broadcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index 3c7e5b741e37..42f7d9bfb148 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -13,6 +13,7 @@ config BCM47XX_NVRAM
 config BCM47XX_SPROM
 	bool "Broadcom SPROM driver"
 	depends on BCM47XX_NVRAM
+	depends on SSB=y || SSB=n
 	help
 	  Broadcom devices store configuration data in SPROM. Accessing it is
 	  specific to the bus host type, e.g. PCI(e) devices have it mapped in
-- 
2.7.0
