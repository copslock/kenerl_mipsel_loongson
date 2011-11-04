Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 18:26:04 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40699 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904129Ab1KDRZ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 18:25:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id E00D2391B0D;
        Fri,  4 Nov 2011 18:25:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0+btikw9SF-V; Fri,  4 Nov 2011 18:25:57 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 6B8DF393D89;
        Fri,  4 Nov 2011 18:25:57 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] MIPS: AR7: constify some arrays in gpio and prom code
Date:   Fri,  4 Nov 2011 18:25:35 +0100
Message-Id: <1320427535-24351-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 31387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3831

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/ar7/gpio.c |    2 +-
 arch/mips/ar7/prom.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index bb571bc..d8dbd8f 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -217,7 +217,7 @@ struct titan_gpio_cfg {
 	u32 func;
 };
 
-static struct titan_gpio_cfg titan_gpio_table[] = {
+static const struct titan_gpio_cfg titan_gpio_table[] = {
 	/* reg, start bit, mux value */
 	{4, 24, 1},
 	{4, 26, 1},
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 8088c6f..f642f64 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -69,7 +69,7 @@ struct psbl_rec {
 	u32	ffs_size;
 };
 
-static __initdata char psp_env_version[] = "TIENV0.8";
+static __initdata const char psp_env_version[] = "TIENV0.8";
 
 struct psp_env_chunk {
 	u8	num;
@@ -84,7 +84,7 @@ struct psp_var_map_entry {
 	char	*value;
 };
 
-static struct psp_var_map_entry psp_var_map[] = {
+static const struct psp_var_map_entry psp_var_map[] = {
 	{  1,	"cpufrequency" },
 	{  2,	"memsize" },
 	{  3,	"flashsize" },
-- 
1.7.5.4
