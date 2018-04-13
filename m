Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Apr 2018 10:51:08 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:49207 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991534AbeDMIu6VJT5S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Apr 2018 10:50:58 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 13 Apr 2018 08:50:46 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 13 Apr 2018 01:51:02 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] MIPS: dts: Boston: Fix PCI bus dtc warnings:
Date:   Fri, 13 Apr 2018 09:50:44 +0100
Message-ID: <1523609444-2496-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523609446-452060-11790-47385-1
X-BESS-VER: 2018.4.1-r1804121648
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191950
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

dtc recently (v1.4.4-8-g756ffc4f52f6) added PCI bus checks. Fix the
warnings now emitted:

arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@10000000:
missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@12000000:
missing bus-range for PCI bridge
arch/mips/boot/dts/img/boston.dtb: Warning (pci_bridge): /pci@14000000:
missing bus-range for PCI bridge

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/boot/dts/img/boston.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 2cd49b60e030..f7aad80c69ab 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -51,6 +51,8 @@
 		ranges = <0x02000000 0 0x40000000
 			  0x40000000 0 0x40000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci0_intc 1>,
 				<0 0 0 2 &pci0_intc 2>,
@@ -79,6 +81,8 @@
 		ranges = <0x02000000 0 0x20000000
 			  0x20000000 0 0x20000000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci1_intc 1>,
 				<0 0 0 2 &pci1_intc 2>,
@@ -107,6 +111,8 @@
 		ranges = <0x02000000 0 0x16000000
 			  0x16000000 0 0x100000>;
 
+		bus-range = <0x00 0xff>;
+
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map = <0 0 0 1 &pci2_intc 1>,
 				<0 0 0 2 &pci2_intc 2>,
-- 
2.7.4
