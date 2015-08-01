Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2015 14:04:34 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:57490 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010928AbbHAMDnDJnvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2015 14:03:43 +0200
X-IronPort-AV: E=Sophos;i="5.15,591,1432623600"; 
   d="scan'208";a="71207521"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw3-out.broadcom.com with ESMTP; 01 Aug 2015 05:22:11 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Sat, 1 Aug 2015 05:03:35 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Sat, 1 Aug 2015 05:03:35 -0700
Received: from netl-snoppy.ban.broadcom.com (unknown [10.132.128.129])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 87C2540FE5;  Sat,  1 Aug
 2015 05:01:19 -0700 (PDT)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Kamlakant Patel <kamlakant.patel@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 2/4] MIPS: Netlogic: add device tree entry for XLP GPIO
Date:   Sat, 1 Aug 2015 17:44:21 +0530
Message-ID: <1438431263-12427-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
References: <1438431263-12427-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Kamlakant Patel <kamlakant.patel@broadcom.com>

Add GPIO entries to the Netlogic XLP device tree files.

Signed-off-by: Kamlakant Patel <kamlakant.patel@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/boot/dts/netlogic/xlp_evp.dts | 12 ++++++++++++
 arch/mips/boot/dts/netlogic/xlp_fvp.dts | 12 ++++++++++++
 arch/mips/boot/dts/netlogic/xlp_gvp.dts | 11 +++++++++++
 arch/mips/boot/dts/netlogic/xlp_rvp.dts | 11 +++++++++++
 arch/mips/boot/dts/netlogic/xlp_svp.dts | 12 ++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/arch/mips/boot/dts/netlogic/xlp_evp.dts b/arch/mips/boot/dts/netlogic/xlp_evp.dts
index 89ad048..ec16ec2 100644
--- a/arch/mips/boot/dts/netlogic/xlp_evp.dts
+++ b/arch/mips/boot/dts/netlogic/xlp_evp.dts
@@ -110,6 +110,18 @@
 				read-only;
 			};
 		};
+
+		gpio: xlp_gpio@34100 {
+			compatible = "netlogic,xlp832-gpio";
+			reg = <0 0x34100 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			#interrupt-cells = <2>;
+			interrupt-parent = <&pic>;
+			interrupts = <39>;
+			interrupt-controller;
+		};
 	};
 
 	chosen {
diff --git a/arch/mips/boot/dts/netlogic/xlp_fvp.dts b/arch/mips/boot/dts/netlogic/xlp_fvp.dts
index 63e62b7..4bcebe6 100644
--- a/arch/mips/boot/dts/netlogic/xlp_fvp.dts
+++ b/arch/mips/boot/dts/netlogic/xlp_fvp.dts
@@ -110,6 +110,18 @@
 				read-only;
 			};
 		};
+
+		gpio: xlp_gpio@34100 {
+			compatible = "netlogic,xlp208-gpio";
+			reg = <0 0x34100 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			#interrupt-cells = <2>;
+			interrupt-parent = <&pic>;
+			interrupts = <39>;
+			interrupt-controller;
+		};
 	};
 
 	chosen {
diff --git a/arch/mips/boot/dts/netlogic/xlp_gvp.dts b/arch/mips/boot/dts/netlogic/xlp_gvp.dts
index bb4ecd1..b3ccb82 100644
--- a/arch/mips/boot/dts/netlogic/xlp_gvp.dts
+++ b/arch/mips/boot/dts/netlogic/xlp_gvp.dts
@@ -69,6 +69,17 @@
 			};
 		};
 
+		gpio: xlp_gpio@114100 {
+			compatible = "netlogic,xlp980-gpio";
+			reg = <0 0x114100 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			#interrupt-cells = <2>;
+			interrupt-parent = <&pic>;
+			interrupts = <39>;
+			interrupt-controller;
+		};
 	};
 
 	chosen {
diff --git a/arch/mips/boot/dts/netlogic/xlp_rvp.dts b/arch/mips/boot/dts/netlogic/xlp_rvp.dts
index 7188aed..3783639 100644
--- a/arch/mips/boot/dts/netlogic/xlp_rvp.dts
+++ b/arch/mips/boot/dts/netlogic/xlp_rvp.dts
@@ -69,6 +69,17 @@
 			};
 		};
 
+		gpio: xlp_gpio@114100 {
+			compatible = "netlogic,xlp532-gpio";
+			reg = <0 0x114100 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			#interrupt-cells = <2>;
+			interrupt-parent = <&pic>;
+			interrupts = <39>;
+			interrupt-controller;
+		};
 	};
 
 	chosen {
diff --git a/arch/mips/boot/dts/netlogic/xlp_svp.dts b/arch/mips/boot/dts/netlogic/xlp_svp.dts
index 1ebd00ed..44d6640 100644
--- a/arch/mips/boot/dts/netlogic/xlp_svp.dts
+++ b/arch/mips/boot/dts/netlogic/xlp_svp.dts
@@ -110,6 +110,18 @@
 				read-only;
 			};
 		};
+
+		gpio: xlp_gpio@34100 {
+			compatible = "netlogic,xlp316-gpio";
+			reg = <0 0x34100 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+
+			#interrupt-cells = <2>;
+			interrupt-parent = <&pic>;
+			interrupts = <39>;
+			interrupt-controller;
+		};
 	};
 
 	chosen {
-- 
1.9.1
