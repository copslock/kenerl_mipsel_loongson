Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 00:31:49 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:36776
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S27011136AbaJJW3SroTbF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 00:29:18 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 09/10] MIPS: lantiq: add missing spi clock on falcon SoC
Date:   Sat, 11 Oct 2014 00:02:33 +0200
Message-Id: <1412978554-31344-10-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
References: <1412978554-31344-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/lantiq/falcon/sysctrl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 92cf10e..c000b56 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -49,6 +49,7 @@
 
 /* Activation Status Register */
 #define ACTS_ASC0_ACT	0x00001000
+#define ACTS_SSC0	0x00002000
 #define ACTS_ASC1_ACT	0x00000800
 #define ACTS_I2C_ACT	0x00004000
 #define ACTS_P0		0x00010000
@@ -259,5 +260,6 @@ void __init ltq_soc_init(void)
 	clkdev_add_sys("1e800600.pad", SYSCTL_SYS1, ACTS_PADCTRL4);
 	clkdev_add_sys("1e100b00.serial", SYSCTL_SYS1, ACTS_ASC1_ACT);
 	clkdev_add_sys("1e100c00.serial", SYSCTL_SYS1, ACTS_ASC0_ACT);
+	clkdev_add_sys("1e100d00.spi", SYSCTL_SYS1, ACTS_SSC0);
 	clkdev_add_sys("1e200000.i2c", SYSCTL_SYS1, ACTS_I2C_ACT);
 }
-- 
1.7.10.4
