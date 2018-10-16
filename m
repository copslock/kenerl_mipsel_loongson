Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 11:19:45 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:9376 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992735AbeJPJTmeWsbF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Oct 2018 11:19:42 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 02:19:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="272803445"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2018 02:19:33 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     gregkh@linuxfoundation.org, paul.burton@mips.com, jslaby@suse.com,
        Songjun Wu <songjun.wu@linux.intel.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [RESEND PATCH 00/14] serial: lantiq: Add CCF suppport
Date:   Tue, 16 Oct 2018 17:19:01 +0800
Message-Id: <20181016091915.19909-1-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66862
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
for lantiq serial driver, mainly includes:
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
