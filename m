Return-Path: <SRS0=9u5Z=PZ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68347C43444
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3744D20657
	for <linux-mips@archiver.kernel.org>; Thu, 17 Jan 2019 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAQKFJ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:05:09 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60541 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfAQKFF (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 17 Jan 2019 05:05:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 999D0209C0; Thu, 17 Jan 2019 11:05:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73BCB206DC;
        Thu, 17 Jan 2019 11:05:02 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, alexandre.belloni@bootlin.com,
        UNGLinuxDriver@microchip.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: [PATCH net-next 0/8] net: mscc: PTP offloading support
Date:   Thu, 17 Jan 2019 11:02:04 +0100
Message-Id: <20190117100212.2336-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi all,

This series adds support for the PTP offloading support in the Mscc
Ocelot Ethernet switch driver. Both PTP 1-step and 2-step modes are
supported.

In order to make use of the PTP offloading support, two new register
banks were described in the Ocelot device tree. The use of those
registers by the Mscc Ocelot Ethernet switch driver is made optional for
dt compatibility reasons. For the same reason a new interrupt is
described, and its use is also made optinal for compatibility reasons.
All of this is done ine patches 1-5.

The PTP offloading support itself is added in patch 8.

While doing this support, a few reworks were done in the Ocelot switch
driver, in patches 6-7.

Patches 2 and 4 should probably go through the MIPS tree.

Thanks!
Antoine

Antoine Tenart (8):
  Documentation/bindings: net: ocelot: document the VCAP and PTP banks
  MIPS: dts: mscc: describe VCAP and PTP register ranges
  Documentation/bindings: net: ocelot: document the PTP ready IRQ
  MIPS: dts: mscc: describe the PTP ready interrupt
  net: mscc: describe the VCAP and PTP register ranges
  net: mscc: improve the frame header parsing readability
  net: mscc: remove the frame_info cpuq member
  net: mscc: PTP offloading support

 .../devicetree/bindings/net/mscc-ocelot.txt   |  22 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           |  14 +-
 drivers/net/ethernet/mscc/ocelot.c            | 509 +++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot.h            |  55 +-
 drivers/net/ethernet/mscc/ocelot_board.c      | 150 +++++-
 drivers/net/ethernet/mscc/ocelot_ptp.h        |  41 ++
 drivers/net/ethernet/mscc/ocelot_regs.c       |  22 +
 drivers/net/ethernet/mscc/ocelot_vcap.h       | 104 ++++
 8 files changed, 877 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ptp.h
 create mode 100644 drivers/net/ethernet/mscc/ocelot_vcap.h

-- 
2.20.1

