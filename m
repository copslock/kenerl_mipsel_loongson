Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2015 03:11:52 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34954 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026408AbbEEBLUVLVBT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2015 03:11:20 +0200
Received: by pdbqd1 with SMTP id qd1so178687238pdb.2;
        Mon, 04 May 2015 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r9F5hH2CeWFpzmQobpCxEGPtYO04Nch54Gv1Wm2woFI=;
        b=AGc8iDmWS29qu/5LhD9lL5VWGfVIqH9k94JdyCzTPWa7jldSjY50kcmjp7+9c8+bdc
         7nXzdTMZKO3/d6imDoTNlu9TvGzyQn6aewj84IPQ7YnoW/g0pwdUS5Oiuwc8fwQrRftE
         st8adCXhkK7SuqQYmP8U1IgBpWInIFwaJ4Niia7Oz1I3iSOGlq8/pXTbgvxmOxbWTLam
         tHVwoaPCrGhr971/D9G/jAVZQsPGqdEJ5JBzGKIqnd2Ij58H2xH1azL0M3Qp6xJvldNn
         1x5TlKZxFq41ZMcHis9c2/5foHqu9p9ZOOdcR4IAG4awCyW7VNjqfdpZnYkgg9ppzQ5o
         7fgA==
X-Received: by 10.70.101.106 with SMTP id ff10mr47380470pdb.162.1430788276481;
        Mon, 04 May 2015 18:11:16 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id nt15sm14030698pdb.14.2015.05.04.18.11.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 18:11:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@chromium.org,
        Steven.Hill@imgtec.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/2] MIPS: BMIPS: add support for Broadcom BCM97435SVMB
Date:   Mon,  4 May 2015 18:10:57 -0700
Message-Id: <1430788257-10244-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1430788257-10244-1-git-send-email-f.fainelli@gmail.com>
References: <1430788257-10244-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Add a DTS file and Kconfig entry for the BCM97435SVMB evaluation board
using bcm7435.dtsi as an example.

The current code needs some tweaking to allow us to use the
dual-threaded dual BMIPS5200 CPUs, so for now we limit ourselves to
allowing just a single CPU to be booted.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bmips/Kconfig                  |  4 +++
 arch/mips/boot/dts/brcm/Makefile         |  1 +
 arch/mips/boot/dts/brcm/bcm97435svmb.dts | 60 ++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 arch/mips/boot/dts/brcm/bcm97435svmb.dts

diff --git a/arch/mips/bmips/Kconfig b/arch/mips/bmips/Kconfig
index f35c84c019df..e2c4fd682c74 100644
--- a/arch/mips/bmips/Kconfig
+++ b/arch/mips/bmips/Kconfig
@@ -57,6 +57,10 @@ config DT_BCM97425SVMB
 	bool "BCM97425SVMB"
 	select BUILTIN_DTB
 
+config DT_BCM97435SVMB
+	bool "BCM97435SVMB"
+	select BUILTIN_DTB
+
 endchoice
 
 endif
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index 1c8353bfe003..b62e5b0f7eb0 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_DT_BCM97360SVMB)		+= bcm97360svmb.dtb
 dtb-$(CONFIG_DT_BCM97362SVMB)		+= bcm97362svmb.dtb
 dtb-$(CONFIG_DT_BCM97420C)		+= bcm97420c.dtb
 dtb-$(CONFIG_DT_BCM97425SVMB)		+= bcm97425svmb.dtb
+dtb-$(CONFIG_DT_BCM97435SVMB)		+= bcm97435svmb.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
new file mode 100644
index 000000000000..1df088183523
--- /dev/null
+++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
@@ -0,0 +1,60 @@
+/dts-v1/;
+
+/include/ "bcm7435.dtsi"
+
+/ {
+	compatible = "brcm,bcm97435svmb", "brcm,bcm7435";
+	model = "Broadcom BCM97435SVMB";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>,
+		      <0x20000000 0x30000000>,
+		      <0x90000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 maxcpus=1";
+		stdout-path = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&enet0 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
-- 
2.1.0
