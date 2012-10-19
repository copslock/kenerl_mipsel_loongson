Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2012 05:59:41 +0200 (CEST)
Received: from perches-mx.perches.com ([206.117.179.246]:45908 "EHLO
        labridge.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6823121Ab2JSD7kNaiOE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Oct 2012 05:59:40 +0200
Received: from [173.51.221.202] (account joe@perches.com HELO joe-laptop.perches.com)
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19746958; Thu, 18 Oct 2012 20:59:38 -0700
From:   Joe Perches <joe@perches.com>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Cc:     Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        davinci-linux-open-source@linux.davincidsp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: [PATCH net-next 03/21] arch: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
Date:   Thu, 18 Oct 2012 20:55:34 -0700
Message-Id: <58e119fbf38f7559473930089a642ed57d118459.1350618009.git.joe@perches.com>
X-Mailer: git-send-email 1.7.8.111.gad25c.dirty
In-Reply-To: <cover.1350618006.git.joe@perches.com>
References: <cover.1350618006.git.joe@perches.com>
X-archive-position: 34726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Convert the old ether_addr tests to eth_addr_<foo>.
Adds api consistency.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-davinci/board-mityomapl138.c |    2 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c         |    2 +-
 arch/avr32/boards/atngw100/setup.c         |    2 +-
 arch/avr32/boards/atstk1000/atstk1002.c    |    2 +-
 arch/avr32/boards/favr-32/setup.c          |    2 +-
 arch/avr32/boards/hammerhead/setup.c       |    2 +-
 arch/avr32/boards/merisc/setup.c           |    2 +-
 arch/avr32/boards/mimc200/setup.c          |    2 +-
 arch/mips/alchemy/common/platform.c        |    4 ++--
 arch/um/drivers/net_kern.c                 |    6 +++---
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 43e4a0d..df45c9c 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -138,7 +138,7 @@ static void read_factory_config(struct memory_accessor *a, void *context)
 	}
 
 	pr_info("MityOMAPL138: Found MAC = %pM\n", factory_config.mac);
-	if (is_valid_ether_addr(factory_config.mac))
+	if (eth_addr_valid(factory_config.mac))
 		memcpy(soc_info->emac_pdata->mac_addr,
 			factory_config.mac, ETH_ALEN);
 	else
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 8240291..839040c 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -52,7 +52,7 @@ void __init colibri_pxa3xx_init_eth(struct ax_plat_data *plat_data)
 		serial >>= 8;
 	}
 
-	if (is_valid_ether_addr(ether_mac_addr)) {
+	if (eth_addr_valid(ether_mac_addr)) {
 		plat_data->flags |= AXFLG_MAC_FROMPLATFORM;
 		plat_data->mac_addr = ether_mac_addr;
 		printk(KERN_INFO "%s(): taking MAC from serial boot tag\n",
diff --git a/arch/avr32/boards/atngw100/setup.c b/arch/avr32/boards/atngw100/setup.c
index afeae89..5f7d86d 100644
--- a/arch/avr32/boards/atngw100/setup.c
+++ b/arch/avr32/boards/atngw100/setup.c
@@ -175,7 +175,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 		return;
 
 	addr = hw_addr[pdev->id].addr;
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	/*
diff --git a/arch/avr32/boards/atstk1000/atstk1002.c b/arch/avr32/boards/atstk1000/atstk1002.c
index 6c80aba..7334686 100644
--- a/arch/avr32/boards/atstk1000/atstk1002.c
+++ b/arch/avr32/boards/atstk1000/atstk1002.c
@@ -189,7 +189,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 		return;
 
 	addr = hw_addr[pdev->id].addr;
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	/*
diff --git a/arch/avr32/boards/favr-32/setup.c b/arch/avr32/boards/favr-32/setup.c
index 27bd6fb..0b76aa7 100644
--- a/arch/avr32/boards/favr-32/setup.c
+++ b/arch/avr32/boards/favr-32/setup.c
@@ -196,7 +196,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 		return;
 
 	addr = hw_addr[pdev->id].addr;
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	/*
diff --git a/arch/avr32/boards/hammerhead/setup.c b/arch/avr32/boards/hammerhead/setup.c
index 9d1efd1..d64fa9f 100644
--- a/arch/avr32/boards/hammerhead/setup.c
+++ b/arch/avr32/boards/hammerhead/setup.c
@@ -139,7 +139,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 
 	addr = hw_addr[pdev->id].addr;
 
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	/*
diff --git a/arch/avr32/boards/merisc/setup.c b/arch/avr32/boards/merisc/setup.c
index ed137e3..817d2d8 100644
--- a/arch/avr32/boards/merisc/setup.c
+++ b/arch/avr32/boards/merisc/setup.c
@@ -129,7 +129,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 		return;
 
 	addr = hw_addr[pdev->id].addr;
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	regs = (void __iomem __force *)res->start;
diff --git a/arch/avr32/boards/mimc200/setup.c b/arch/avr32/boards/mimc200/setup.c
index 05358aa..31cd87e 100644
--- a/arch/avr32/boards/mimc200/setup.c
+++ b/arch/avr32/boards/mimc200/setup.c
@@ -152,7 +152,7 @@ static void __init set_hw_addr(struct platform_device *pdev)
 		return;
 
 	addr = hw_addr[pdev->id].addr;
-	if (!is_valid_ether_addr(addr))
+	if (!eth_addr_valid(addr))
 		return;
 
 	/*
diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index c0f3ce6..5f07da3 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -343,7 +343,7 @@ static void __init alchemy_setup_macs(int ctype)
 	au1xxx_eth0_device.resource = macres;
 
 	i = prom_get_ethernet_addr(ethaddr);
-	if (!i && !is_valid_ether_addr(au1xxx_eth0_platform_data.mac))
+	if (!i && !eth_addr_valid(au1xxx_eth0_platform_data.mac))
 		memcpy(au1xxx_eth0_platform_data.mac, ethaddr, 6);
 
 	ret = platform_device_register(&au1xxx_eth0_device);
@@ -364,7 +364,7 @@ static void __init alchemy_setup_macs(int ctype)
 	au1xxx_eth1_device.resource = macres;
 
 	ethaddr[5] += 1;	/* next addr for 2nd MAC */
-	if (!i && !is_valid_ether_addr(au1xxx_eth1_platform_data.mac))
+	if (!i && !eth_addr_valid(au1xxx_eth1_platform_data.mac))
 		memcpy(au1xxx_eth1_platform_data.mac, ethaddr, 6);
 
 	/* Register second MAC if enabled in pinfunc */
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index b1314eb..47e11e7 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -312,19 +312,19 @@ static int setup_etheraddr(char *str, unsigned char *addr, char *name)
 		}
 		str = end + 1;
 	}
-	if (is_multicast_ether_addr(addr)) {
+	if (eth_addr_multicast(addr)) {
 		printk(KERN_ERR
 		       "Attempt to assign a multicast ethernet address to a "
 		       "device disallowed\n");
 		goto random;
 	}
-	if (!is_valid_ether_addr(addr)) {
+	if (!eth_addr_valid(addr)) {
 		printk(KERN_ERR
 		       "Attempt to assign an invalid ethernet address to a "
 		       "device disallowed\n");
 		goto random;
 	}
-	if (!is_local_ether_addr(addr)) {
+	if (!eth_addr_local(addr)) {
 		printk(KERN_WARNING
 		       "Warning: Assigning a globally valid ethernet "
 		       "address to a device\n");
-- 
1.7.8.111.gad25c.dirty
