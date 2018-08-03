Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:06:45 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:63329 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994427AbeHCDEoZhuNH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:04:44 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="221369937"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 02 Aug 2018 20:04:39 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 18/18] dt-bindings: serial: lantiq: Add optional properties for CCF
Date:   Fri,  3 Aug 2018 11:02:37 +0800
Message-Id: <20180803030237.3366-19-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

Clocks and clock-names are updated in device tree binding.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
index 3acbd309ab9d..40e81a5818f6 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
@@ -6,8 +6,23 @@ Required properties:
 - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
   depends on the interrupt-parent interrupt controller.
 
+Optional properties:
+- clocks: Should contain frequency clock and gate clock
+- clock-names: Should be "freq" and "asc"
+
 Example:
 
+asc0: serial@16600000 {
+	compatible = "lantiq,asc";
+	reg = <0x16600000 0x100000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+		<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
+	clock-names = "freq", "asc";
+};
+
 asc1: serial@e100c00 {
 	compatible = "lantiq,asc";
 	reg = <0xE100C00 0x400>;
-- 
2.11.0
