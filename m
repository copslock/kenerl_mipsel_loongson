Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2015 11:11:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3646 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006747AbbIHJLH40xum (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Sep 2015 11:11:07 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 386DB3593EEDE;
        Tue,  8 Sep 2015 10:11:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 8 Sep 2015 10:11:01 +0100
Received: from asmith-linux.le.imgtec.org (192.168.154.115) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 8 Sep 2015 10:11:01 +0100
From:   Alex Smith <alex.smith@imgtec.com>
To:     <linux-mtd@lists.infradead.org>
CC:     Alex Smith <alex@alex-smith.me.uk>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: [PATCH v5 0/4] mtd: nand: jz4780: Add NAND and BCH drivers
Date:   Tue, 8 Sep 2015 10:10:49 +0100
Message-ID: <1441703453-2838-1-git-send-email-alex.smith@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.115]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Hi,

This series adds support for the BCH controller and NAND devices on
the Ingenic JZ4780 SoC.

Tested on the MIPS Creator Ci20 board. All dependencies are now in
mainline.

This version of the series is based on current mainline (pre 4.3-rc1).

Review and feedback welcome.

Thanks,
Alex

Alex Smith (4):
  mtd: nand: increase ready wait timeout and report timeouts
  dt-bindings: binding for jz4780-{nand,bch}
  mtd: nand: jz4780: driver for NAND devices on JZ4780 SoCs
  MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND device tree nodes

 .../bindings/mtd/ingenic,jz4780-nand.txt           |  57 ++++
 arch/mips/boot/dts/ingenic/ci20.dts                |  51 +++
 arch/mips/boot/dts/ingenic/jz4780.dtsi             |  26 ++
 drivers/mtd/nand/Kconfig                           |   7 +
 drivers/mtd/nand/Makefile                          |   1 +
 drivers/mtd/nand/jz4780_bch.c                      | 348 +++++++++++++++++++
 drivers/mtd/nand/jz4780_bch.h                      |  42 +++
 drivers/mtd/nand/jz4780_nand.c                     | 378 +++++++++++++++++++++
 drivers/mtd/nand/nand_base.c                       |  14 +-
 9 files changed, 921 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
 create mode 100644 drivers/mtd/nand/jz4780_bch.c
 create mode 100644 drivers/mtd/nand/jz4780_bch.h
 create mode 100644 drivers/mtd/nand/jz4780_nand.c

-- 
2.5.0
