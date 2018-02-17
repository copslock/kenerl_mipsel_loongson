Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 21:14:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:32908 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbeBQUOIS1yHG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 21:14:08 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 20:13:58 +0000
Received: from pburton-laptop.mipstec.com (10.20.1.18) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018
 12:09:26 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     <netdev@vger.kernel.org>
CC:     Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>
Subject: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
Date:   Sat, 17 Feb 2018 12:10:23 -0800
Message-ID: <20180217201037.3006-1-paul.burton@mips.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-BESS-ID: 1518898437-298552-4261-69366-5
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190134
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

The Intel EG20T Platform Controller Hub is used on the MIPS Boston
development board to provide various peripherals including ethernet.
This series fixes some issues with the pch_gbe driver discovered whilst
in use on the Boston board, and implements support for device tree which
we use to provide the PHY reset GPIO.

Applies atop v4.16-rc1.

Hassan Naveed (1):
  net: pch_gbe: Fix TX RX descriptor accesses for big endian systems

Paul Burton (13):
  net: pch_gbe: Mark Minnow PHY reset GPIO active low
  net: pch_gbe: Pull PHY GPIO handling out of Minnow code
  dt-bindings: net: Document Intel pch_gbe binding
  net: pch_gbe: Add device tree support
  net: pch_gbe: Always reset PHY along with MAC
  net: pch_gbe: Allow longer for resets
  net: pch_gbe: Fix handling of TX padding
  net: pch_gbe: Fold pch_gbe_setup_[rt]ctl into pch_gbe_configure_[rt]x
  net: pch_gbe: Use pch_gbe_disable_dma_rx() in pch_gbe_configure_rx()
  net: pch_gbe: Disable TX DMA whilst configuring descriptors
  net: pch_gbe: Ensure DMA is ordered with descriptor writes
  ptp: pch: Allow build on MIPS platforms
  net: pch_gbe: Allow build on MIPS platforms

 Documentation/devicetree/bindings/net/pch_gbe.txt  |  25 ++
 drivers/net/ethernet/oki-semi/pch_gbe/Kconfig      |   2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe.h    |  27 +-
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 283 ++++++++++++---------
 drivers/ptp/Kconfig                                |   2 +-
 5 files changed, 204 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/pch_gbe.txt

-- 
2.16.1
