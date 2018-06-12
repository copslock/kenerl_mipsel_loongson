Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 07:41:28 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:3743 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992496AbeFLFlKtraoa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jun 2018 07:41:10 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 22:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="49163676"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2018 22:41:04 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com
Cc:     linux-mips@linux-mips.org, qi-ming.wu@intel.com,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
Date:   Tue, 12 Jun 2018 13:40:28 +0800
Message-Id: <20180612054034.4969-2-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64228
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

Previous implementation uses a hard-coded register value to check if
the current serial entity is the console entity.
Now the lantiq serial driver uses the aliases for the index of the
serial port.
The lantiq danube serial dts are updated with aliases to support this.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 2dd950181f8a..7a9e15da6bd0 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -4,6 +4,10 @@
 	#size-cells = <1>;
 	compatible = "lantiq,xway", "lantiq,danube";
 
+	aliases {
+		serial0 = &asc1;
+	};
+
 	cpus {
 		cpu@0 {
 			compatible = "mips,mips24Kc";
@@ -74,7 +78,7 @@
 			reg = <0xE100A00 0x100>;
 		};
 
-		serial@E100C00 {
+		asc1: serial@E100C00 {
 			compatible = "lantiq,asc";
 			reg = <0xE100C00 0x400>;
 			interrupt-parent = <&icu0>;
-- 
2.11.0
