Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 12:28:40 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:45463 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991947AbeIXK2hF-uYU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Sep 2018 12:28:37 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="265192400"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2018 03:28:31 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 02/14] MIPS: dts: Add aliases node for lantiq danube serial
Date:   Mon, 24 Sep 2018 18:27:51 +0800
Message-Id: <20180924102803.30263-3-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66511
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

Previous implementation uses a hard-coded register value to check
if the current serial entity is the console entity.
Now the lantiq serial driver uses the aliases for the index of the
serial port.
The lantiq danube serial dts are updated with aliases to support this.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 arch/mips/boot/dts/lantiq/danube.dtsi   | 2 +-
 arch/mips/boot/dts/lantiq/easy50712.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 510be63c8bdf..73746d7577d7 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -74,7 +74,7 @@
 			reg = <0xe100a00 0x100>;
 		};
 
-		serial@e100c00 {
+		asc1: serial@e100c00 {
 			compatible = "lantiq,asc";
 			reg = <0xe100c00 0x400>;
 			interrupt-parent = <&icu0>;
diff --git a/arch/mips/boot/dts/lantiq/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
index 1ce20b7d05cb..452860ca1868 100644
--- a/arch/mips/boot/dts/lantiq/easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/easy50712.dts
@@ -4,6 +4,10 @@
 /include/ "danube.dtsi"
 
 / {
+	aliases {
+		serial0 = &asc1;
+	};
+
 	chosen {
 		bootargs = "console=ttyLTQ0,115200 init=/etc/preinit";
 	};
-- 
2.11.0
