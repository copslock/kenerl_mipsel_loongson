Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2012 18:27:24 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2342 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903726Ab2GMQYk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 Jul 2012 18:24:40 +0200
Received: from [10.9.200.133] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 13 Jul 2012 09:23:09 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 13 Jul 2012 09:23:45 -0700
Received: from hqcas02.netlogicmicro.com (unknown [10.65.50.15]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C39849F9F6; Fri, 13
 Jul 2012 09:24:24 -0700 (PDT)
Received: from jayachandranc.netlogicmicro.com (10.7.0.77) by
 hqcas02.netlogicmicro.com (10.65.50.15) with Microsoft SMTP Server id
 14.1.339.1; Fri, 13 Jul 2012 09:24:24 -0700
From:   "Jayachandran C" <jayachandranc@netlogicmicro.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Ganesan Ramalingam" <ganesanr@broadcom.com>,
        "Jayachandran C" <jayachandranc@netlogicmicro.com>
Subject: [PATCH 07/12] MIPS: Netlogic: DTS file for XLP boards
Date:   Fri, 13 Jul 2012 21:53:20 +0530
Message-ID: <1342196605-4260-8-git-send-email-jayachandranc@netlogicmicro.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1342196605-4260-1-git-send-email-jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
X-Originating-IP: [10.7.0.77]
X-WSS-ID: 7C1E94E74989490133-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 33916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Add a basic DTS file netlogic/dts/nlm_xlp.dts which contains
memory, i2c devices, NOR flash and command line arguments.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
---
 arch/mips/netlogic/dts/xlp_evp.dts |  103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 arch/mips/netlogic/dts/xlp_evp.dts

diff --git a/arch/mips/netlogic/dts/xlp_evp.dts b/arch/mips/netlogic/dts/xlp_evp.dts
new file mode 100644
index 0000000..86a29ca
--- /dev/null
+++ b/arch/mips/netlogic/dts/xlp_evp.dts
@@ -0,0 +1,103 @@
+/*
+ * XLP8XX Device Tree Source for EVP boards
+ */
+
+/dts-v1/;
+/ {
+	model = "netlogic,XLP-EVP";
+	compatible = "netlogic,xlp";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	memory {
+		device_type = "memory";
+		reg =  <0 0x00100000 0 0x0FF00000	// 255M at 1M
+			0 0x20000000 0 0xa0000000	// 2560M at 512M
+			0 0xe0000000 1 0x00000000>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges = <0 0  0 0x18000000  0x04000000   // PCIe CFG
+			  1 0  0 0x16000000  0x01000000>; // GBU chipselects
+		i2c0: ocores@32000 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x32100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <32000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <30>;
+		};
+		i2c1: ocores@33000 {
+			compatible = "opencores,i2c-ocores";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0 0x33100 0xa00>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <32000000>;
+			interrupt-parent = <&pic>;
+			interrupts = <31>;
+
+			rtc@68 {
+				compatible = "dallas,ds1374";
+				reg = <0x68>;
+			};
+
+			dtt@4c {
+				compatible = "national,lm90";
+				reg = <0x4c>;
+			};
+		};
+		pic: pic@4000 {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <0 0x4000 0x200>;
+		};
+
+		nor_flash@1,0 {
+			compatible = "cfi-flash";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <2>;
+			reg = <1 0 0x1000000>;
+
+			partition@0 {
+				label = "x-loader";
+				reg = <0x0 0x100000>; /* 1M */
+				read-only;
+			};
+
+			partition@100000 {
+				label = "u-boot";
+				reg = <0x100000 0x100000>; /* 1M */
+			};
+
+			partition@200000 {
+				label = "kernel";
+				reg = <0x200000 0x500000>; /* 5M */
+			};
+
+			partition@700000 {
+				label = "rootfs";
+				reg = <0x700000 0x800000>; /* 8M */
+			};
+
+			partition@f00000 {
+				label = "env";
+				reg = <0xf00000 0x100000>; /* 1M */
+				read-only;
+			};
+		};
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 rdinit=/sbin/init";
+	};
+};
-- 
1.7.9.5
