Return-Path: <SRS0=aTje=VC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A73C46499
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 20:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227F6216E3
	for <linux-mips@archiver.kernel.org>; Fri,  5 Jul 2019 20:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfGEUtG (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:49:06 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:56530 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfGEUtG (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 5 Jul 2019 16:49:06 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A94D53A5DF1;
        Fri,  5 Jul 2019 19:55:19 +0000 (UTC)
Received: from localhost (lfbn-1-2078-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3F710200006;
        Fri,  5 Jul 2019 19:55:07 +0000 (UTC)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next v2 0/8] net: mscc: PTP Hardware Clock (PHC) support
Date:   Fri,  5 Jul 2019 21:52:05 +0200
Message-Id: <20190705195213.22041-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

This series introduces the PTP Hardware Clock (PHC) support to the Mscc
Ocelot switch driver. In order to make use of this, a new register bank
is added and described in the device tree, as well as a new interrupt.
The use this bank and interrupt was made optional in the driver for dt
compatibility reasons.

Patches 2 and 4 should probably go through the MIPS tree.

Thanks!
Antoine

Since v1:
  - Used list_for_each_safe() in ocelot_deinit().
  - Fixed a memory leak in ocelot_deinit() by calling
    dev_kfree_skb_any().
  - Fixed a locking issue in get_hwtimestamp().
  - Handled the NULL case of ptp_clock_register().
  - Added comments on optional dt properties.

Antoine Tenart (8):
  Documentation/bindings: net: ocelot: document the PTP bank
  MIPS: dts: mscc: describe the PTP register range
  Documentation/bindings: net: ocelot: document the PTP ready IRQ
  MIPS: dts: mscc: describe the PTP ready interrupt
  net: mscc: describe the PTP register range
  net: mscc: improve the frame header parsing readability
  net: mscc: remove the frame_info cpuq member
  net: mscc: PTP Hardware Clock (PHC) support

 .../devicetree/bindings/net/mscc-ocelot.txt   |  20 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           |   7 +-
 drivers/net/ethernet/mscc/ocelot.c            | 393 +++++++++++++++++-
 drivers/net/ethernet/mscc/ocelot.h            |  47 ++-
 drivers/net/ethernet/mscc/ocelot_board.c      | 139 ++++++-
 drivers/net/ethernet/mscc/ocelot_ptp.h        |  41 ++
 drivers/net/ethernet/mscc/ocelot_regs.c       |  11 +
 7 files changed, 626 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/ethernet/mscc/ocelot_ptp.h

-- 
2.21.0

