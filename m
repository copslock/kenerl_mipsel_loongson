Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:04:32 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:48909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994198AbeHCDDwIet-H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:03:52 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="78325507"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2018 20:03:47 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel MIPS SoCs
Date:   Fri,  3 Aug 2018 11:02:24 +0800
Message-Id: <20180803030237.3366-6-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65365
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

From: Hua Ma <hua.ma@linux.intel.com>

This patch adds binding documentation for the
compatible values of the Intel MIPS SoCs.

Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2:
- New patch split from previous patch
- Add the board and chip compatible in dt document

 Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

diff --git a/Documentation/devicetree/bindings/mips/intel.txt b/Documentation/devicetree/bindings/mips/intel.txt
new file mode 100644
index 000000000000..ac594ef303b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/intel.txt
@@ -0,0 +1,17 @@
+Intel MIPS SoC device tree bindings
+
+1, SoCs
+
+Each device tree must specify a compatible value for the Intel SoC
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,xrx500
+
+2, Boards
+
+Each device tree must specify a compatible value for the Intel Board
+it uses in the compatible property of the root node. The compatible
+value must be one of the following values:
+
+  intel,easy350-anywan
-- 
2.11.0
