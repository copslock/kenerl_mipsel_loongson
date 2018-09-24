Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Sep 2018 12:28:29 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:24814 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991947AbeIXK2039S6U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Sep 2018 12:28:26 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="88803813"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2018 03:28:19 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 00/14] serial: langtiq: Add CCF suppport
Date:   Mon, 24 Sep 2018 18:27:49 +0800
Message-Id: <20180924102803.30263-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66510
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

This patch series is for adding common clock framework support
for langtiq serial driver, mainly includes:
1) Add common clock framework support.
2) Modify the dts file according to the DT conventions.
3) Replace the platform dependent functions with kernel functions


Songjun Wu (14):
  MIPS: dts: Change upper case to lower case
  MIPS: dts: Add aliases node for lantiq danube serial
  serial: lantiq: Get serial id from dts
  serial: lantiq: Change ltq_w32_mask to asc_update_bits
  MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
  serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
  serial: lantiq: Rename fpiclk to freqclk
  serial: lantiq: Replace clk_enable/clk_disable with clk generic API
  serial: lantiq: Add CCF support
  serial: lantiq: Reorder the head files
  include: Add lantiq.h in include/linux/
  serial: lantiq: Replace lantiq_soc.h with lantiq.h
  serial: lantiq: Change init_lqasc to static declaration
  dt-bindings: serial: lantiq: Add optional properties for CCF

 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++
 arch/mips/Kconfig                                  |   1 -
 arch/mips/boot/dts/lantiq/danube.dtsi              |  42 +++---
 arch/mips/boot/dts/lantiq/easy50712.dts            |  18 ++-
 drivers/tty/serial/lantiq.c                        | 145 ++++++++++++---------
 include/linux/lantiq.h                             |  23 ++++
 6 files changed, 155 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/lantiq.h

-- 
2.11.0
