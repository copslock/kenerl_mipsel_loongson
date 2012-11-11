Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:55:30 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:35486 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826618Ab2KKMvASlMSL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:51:00 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053444bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Pv1fIIZ8iqCSV6eXFWPONjIjjJA+Di4NlvqVnpQh94c=;
        b=E2PQhLHZSHJlNaMqTzc/FAcAEHh8RxL/K77BDXTXoeK/Wpd+R30l4+vrQQvkRqQBMH
         r2+yWY0s9VRuCXbL5QUr/uvPWzjhX4oGsq0mi6u3zfKcEVN/0/DYkcGzUn/79pdkLAja
         su9R2Oi1zahIepA6Soi1H4HlNIEYhhPQC0TtDXAPCeAxkAqgI7rgVTIv3QayH1MUSlNX
         Pa3d9wLNCvzTgrrqHUT4HeK52A3SSnFpSlzgc4Funmy3wE7+otNHBUhjlR5X/GZWf3RM
         DXjjFqt9/pDseQ47iPmqiS3zzgVXZJ/USUOnPUldD5nbmO9p7URF69R5P6IkER3njsuY
         wESA==
Received: by 10.205.118.136 with SMTP id fq8mr5834771bkc.24.1352638260051;
        Sun, 11 Nov 2012 04:51:00 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.58
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:59 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] MIPS: BCM63XX: enable serial through Device Tree
Date:   Sun, 11 Nov 2012 13:50:49 +0100
Message-Id: <1352638249-29298-16-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Enable serial through Device Tree board files instead of legacy
board files.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c |   15 ---------------
 arch/mips/bcm63xx/dts/96328avng.dts       |    3 +++
 arch/mips/bcm63xx/dts/96338gw.dts         |    3 +++
 arch/mips/bcm63xx/dts/96338w.dts          |    3 +++
 arch/mips/bcm63xx/dts/96345gw2.dts        |    3 +++
 arch/mips/bcm63xx/dts/96348gw.dts         |    3 +++
 arch/mips/bcm63xx/dts/96348gw_10.dts      |    3 +++
 arch/mips/bcm63xx/dts/96348gw_11.dts      |    3 +++
 arch/mips/bcm63xx/dts/96348gw_a.dts       |    3 +++
 arch/mips/bcm63xx/dts/96348r.dts          |    3 +++
 arch/mips/bcm63xx/dts/96358vw.dts         |    3 +++
 arch/mips/bcm63xx/dts/96358vw2.dts        |    3 +++
 arch/mips/bcm63xx/dts/dv201amr.dts        |    3 +++
 arch/mips/bcm63xx/dts/dwv_s0.dts          |    3 +++
 arch/mips/bcm63xx/dts/fast2404.dts        |    3 +++
 arch/mips/bcm63xx/dts/rta1025w_16.dts     |    3 +++
 16 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 73be9b3..c64cf7c 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -40,7 +40,6 @@ static struct board_info __initdata board_96328avng = {
 	.name				= "96328avng",
 	.expected_cpu_id		= 0x6328,
 
-	.has_uart0			= 1,
 	.has_pci			= 1,
 	.has_usbd			= 0,
 
@@ -88,7 +87,6 @@ static struct board_info __initdata board_96338gw = {
 	.name				= "96338GW",
 	.expected_cpu_id		= 0x6338,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.enet0 = {
 		.force_speed_100	= 1,
@@ -131,7 +129,6 @@ static struct board_info __initdata board_96338w = {
 	.name				= "96338W",
 	.expected_cpu_id		= 0x6338,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.enet0 = {
 		.force_speed_100	= 1,
@@ -176,8 +173,6 @@ static struct board_info __initdata board_96338w = {
 static struct board_info __initdata board_96345gw2 = {
 	.name				= "96345GW2",
 	.expected_cpu_id		= 0x6345,
-
-	.has_uart0			= 1,
 };
 #endif
 
@@ -189,7 +184,6 @@ static struct board_info __initdata board_96348r = {
 	.name				= "96348R",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_pci			= 1,
 
@@ -233,7 +227,6 @@ static struct board_info __initdata board_96348gw_10 = {
 	.name				= "96348GW-10",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -293,7 +286,6 @@ static struct board_info __initdata board_96348gw_11 = {
 	.name				= "96348GW-11",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -347,7 +339,6 @@ static struct board_info __initdata board_96348gw = {
 	.name				= "96348GW",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -405,7 +396,6 @@ static struct board_info __initdata board_FAST2404 = {
 	.name				= "F@ST2404",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
         .has_enet0			= 1,
         .has_enet1			= 1,
         .has_pci			= 1,
@@ -448,7 +438,6 @@ static struct board_info __initdata board_DV201AMR = {
 	.name				= "DV201AMR",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_pci			= 1,
 	.has_ohci0			= 1,
 
@@ -468,7 +457,6 @@ static struct board_info __initdata board_96348gw_a = {
 	.name				= "96348GW-A",
 	.expected_cpu_id		= 0x6348,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -494,7 +482,6 @@ static struct board_info __initdata board_96358vw = {
 	.name				= "96358VW",
 	.expected_cpu_id		= 0x6358,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -546,7 +533,6 @@ static struct board_info __initdata board_96358vw2 = {
 	.name				= "96358VW2",
 	.expected_cpu_id		= 0x6358,
 
-	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -594,7 +580,6 @@ static struct board_info __initdata board_AGPFS0 = {
 	.name                           = "AGPF-S0",
 	.expected_cpu_id                = 0x6358,
 
-	.has_uart0			= 1,
 	.has_enet0                      = 1,
 	.has_enet1                      = 1,
 	.has_pci                        = 1,
diff --git a/arch/mips/bcm63xx/dts/96328avng.dts b/arch/mips/bcm63xx/dts/96328avng.dts
index c1aee15..811fc29 100644
--- a/arch/mips/bcm63xx/dts/96328avng.dts
+++ b/arch/mips/bcm63xx/dts/96328avng.dts
@@ -18,5 +18,8 @@
 
 	ubus@10000000 {
 
+		serial@100 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96338gw.dts b/arch/mips/bcm63xx/dts/96338gw.dts
index 5e4f893..003c4c8 100644
--- a/arch/mips/bcm63xx/dts/96338gw.dts
+++ b/arch/mips/bcm63xx/dts/96338gw.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96338w.dts b/arch/mips/bcm63xx/dts/96338w.dts
index 972a530..bb5be303 100644
--- a/arch/mips/bcm63xx/dts/96338w.dts
+++ b/arch/mips/bcm63xx/dts/96338w.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96345gw2.dts b/arch/mips/bcm63xx/dts/96345gw2.dts
index 0114733..f5942ea 100644
--- a/arch/mips/bcm63xx/dts/96345gw2.dts
+++ b/arch/mips/bcm63xx/dts/96345gw2.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96348gw.dts b/arch/mips/bcm63xx/dts/96348gw.dts
index 8d7f7ca..a956046 100644
--- a/arch/mips/bcm63xx/dts/96348gw.dts
+++ b/arch/mips/bcm63xx/dts/96348gw.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96348gw_10.dts b/arch/mips/bcm63xx/dts/96348gw_10.dts
index 3b27b5b..f8d6925 100644
--- a/arch/mips/bcm63xx/dts/96348gw_10.dts
+++ b/arch/mips/bcm63xx/dts/96348gw_10.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96348gw_11.dts b/arch/mips/bcm63xx/dts/96348gw_11.dts
index 07837ac..fbaf956 100644
--- a/arch/mips/bcm63xx/dts/96348gw_11.dts
+++ b/arch/mips/bcm63xx/dts/96348gw_11.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96348gw_a.dts b/arch/mips/bcm63xx/dts/96348gw_a.dts
index 9b0e5bd..d1e1fcd 100644
--- a/arch/mips/bcm63xx/dts/96348gw_a.dts
+++ b/arch/mips/bcm63xx/dts/96348gw_a.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96348r.dts b/arch/mips/bcm63xx/dts/96348r.dts
index 309f898..65081f3 100644
--- a/arch/mips/bcm63xx/dts/96348r.dts
+++ b/arch/mips/bcm63xx/dts/96348r.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96358vw.dts b/arch/mips/bcm63xx/dts/96358vw.dts
index 55c3e92..6e6c8a2 100644
--- a/arch/mips/bcm63xx/dts/96358vw.dts
+++ b/arch/mips/bcm63xx/dts/96358vw.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@100 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/96358vw2.dts b/arch/mips/bcm63xx/dts/96358vw2.dts
index 88f12ba..065944d 100644
--- a/arch/mips/bcm63xx/dts/96358vw2.dts
+++ b/arch/mips/bcm63xx/dts/96358vw2.dts
@@ -19,5 +19,8 @@
 
 	ubus@fffe0000 {
 
+		serial@100 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/dv201amr.dts b/arch/mips/bcm63xx/dts/dv201amr.dts
index 7cdb41f..7f23015 100644
--- a/arch/mips/bcm63xx/dts/dv201amr.dts
+++ b/arch/mips/bcm63xx/dts/dv201amr.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/dwv_s0.dts b/arch/mips/bcm63xx/dts/dwv_s0.dts
index 96e79cd..9f837d7 100644
--- a/arch/mips/bcm63xx/dts/dwv_s0.dts
+++ b/arch/mips/bcm63xx/dts/dwv_s0.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@100 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/fast2404.dts b/arch/mips/bcm63xx/dts/fast2404.dts
index 55d31ce..9158aaa 100644
--- a/arch/mips/bcm63xx/dts/fast2404.dts
+++ b/arch/mips/bcm63xx/dts/fast2404.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/mips/bcm63xx/dts/rta1025w_16.dts b/arch/mips/bcm63xx/dts/rta1025w_16.dts
index 825fe4e..726de6d 100644
--- a/arch/mips/bcm63xx/dts/rta1025w_16.dts
+++ b/arch/mips/bcm63xx/dts/rta1025w_16.dts
@@ -18,5 +18,8 @@
 
 	ubus@fffe0000 {
 
+		serial@300 {
+			status = "ok";
+		};
 	};
 };
-- 
1.7.2.5
