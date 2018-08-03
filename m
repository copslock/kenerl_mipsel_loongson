Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:05:25 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:36434 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994560AbeHCDEPiKn4H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:04:15 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="72976489"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 02 Aug 2018 20:04:10 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/18] MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
Date:   Fri,  3 Aug 2018 11:02:29 +0800
Message-Id: <20180803030237.3366-11-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65370
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

SWAP_IO_SPACE macro prevents serial driver /drivers/tty/serial/lantiq.c
to use readl/writel to replace ltq_r32/w32 which are SoC or platform
specific APIs.

readl/writel are used for this serial driver to support multiple
platforms and multiple architectures. The legacy lantiq platform(Danube)
enables SWAP_IO_SPACE for supporting PCI due to some hardware bugs.

It's a little-endian bus plus PCI TX/RX swap enable impacted both data
and control path for MIPS based platforms. But it is better to let PCI
device driver to do endian swap since SWAP_IO_SPACE is a global wide macro
which potentially impacts other peripheral like USB.
ltq_r32/ltq_w32 is not impacted in other device drivers based on MIPS when
SWAP_IO_SPACE is not selected as they use non-byte swapping OS API
(__raw_read/__raw_writel).

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 2d34f17f3e24..2e7e0b538e52 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -400,7 +400,6 @@ config LANTIQ
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
 	select GPIOLIB
-	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select CLKDEV_LOOKUP
 	select USE_OF
-- 
2.11.0
