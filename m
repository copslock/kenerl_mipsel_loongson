Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 12:32:11 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:6673 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeIXKcH6ruxU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Sep 2018 12:32:07 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="91386610"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2018 03:28:41 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/14] MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
Date:   Mon, 24 Sep 2018 18:27:54 +0800
Message-Id: <20180924102803.30263-6-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66512
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

 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 138d60cf19bc..dcc1fd39cbf3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -406,7 +406,6 @@ config LANTIQ
 	select SYS_SUPPORTS_VPE_LOADER
 	select SYS_HAS_EARLY_PRINTK
 	select GPIOLIB
-	select SWAP_IO_SPACE
 	select BOOT_RAW
 	select CLKDEV_LOOKUP
 	select USE_OF
-- 
2.11.0
