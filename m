Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 18:36:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40139 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbdHOQfzr8uAa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 18:35:55 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 34E47B2F2974;
        Tue, 15 Aug 2017 17:35:46 +0100 (IST)
Received: from LDT-H-Hunt.le.imgtec.org (192.168.154.107) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 15 Aug 2017 17:35:49 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <ralf@linux-mips.org>, <john@phrozen.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: Add Onion Omega2+ board
Date:   Tue, 15 Aug 2017 17:35:44 +0100
Message-ID: <1502814945-41052-1-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

The Onion Omega2+ is an MT7688A based board that has 128MB RAM and
multiple peripherals.

The MT7688A is pin compatible with the MT7628A, although the former
supports a 1T1R antenna whereas the MT7628A supports a 2R2T antenna.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 MAINTAINERS                           |  6 ++++++
 arch/mips/boot/dts/ralink/Makefile    |  1 +
 arch/mips/boot/dts/ralink/omega2p.dts | 18 ++++++++++++++++++
 arch/mips/ralink/Kconfig              |  5 +++++
 4 files changed, 30 insertions(+)
 create mode 100644 arch/mips/boot/dts/ralink/omega2p.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f7721d..33b6bd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9675,6 +9675,12 @@ F:	drivers/regulator/twl-regulator.c
 F:	drivers/regulator/twl6030-regulator.c
 F:	include/linux/i2c-omap.h
 
+ONION OMEGA2+ BOARD
+M:	Harvey Hunt <harveyhuntnexus@gmail.com>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/boot/dts/ralink/omega2p.dts
+
 OMFS FILESYSTEM
 M:	Bob Copeland <me@bobcopeland.com>
 L:	linux-karma-devel@lists.sourceforge.net
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 2a72259..88da019 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -2,6 +2,7 @@ dtb-$(CONFIG_DTB_RT2880_EVAL)	+= rt2880_eval.dtb
 dtb-$(CONFIG_DTB_RT305X_EVAL)	+= rt3052_eval.dtb
 dtb-$(CONFIG_DTB_RT3883_EVAL)	+= rt3883_eval.dtb
 dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
+dtb-$(CONFIG_DTB_OMEGA2P)		+= omega2p.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/ralink/omega2p.dts b/arch/mips/boot/dts/ralink/omega2p.dts
new file mode 100644
index 0000000..e44dba3
--- /dev/null
+++ b/arch/mips/boot/dts/ralink/omega2p.dts
@@ -0,0 +1,18 @@
+/dts-v1/;
+
+/include/ "mt7628a.dtsi"
+
+/ {
+	compatible = "onion,omega2+", "ralink,mt7688a-soc";
+	model = "Onion Omega2+";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = "serial0:115200";
+	};
+};
diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 710b04c..6ee52bc 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -82,6 +82,11 @@ choice
 		depends on SOC_MT7620
 		select BUILTIN_DTB
 
+	config DTB_OMEGA2P
+		bool "Onion Omega2+"
+		depends on SOC_MT7620
+		select BUILTIN_DTB
+
 endchoice
 
 endif
-- 
2.7.4
