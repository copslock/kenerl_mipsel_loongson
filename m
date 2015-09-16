Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Sep 2015 13:37:15 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36790 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008008AbbIPLhNjy40L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Sep 2015 13:37:13 +0200
Received: by wicgb1 with SMTP id gb1so69630165wic.1
        for <linux-mips@linux-mips.org>; Wed, 16 Sep 2015 04:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vUbYNSQuBPRdlvl4xeku3gVYRnQwgra+aizkg3L2tpk=;
        b=Hg23dM3Jaqc+6MjXyfQnxH3P1Zx2wVH20+I/zT4YyDATPiOZTLBnB6n6OMY+uZEoSD
         sUgUx3sOOTYevexDxpqJQ31cNB4STidqM/wFUvlxoMWw/4rVHWUvBLtlEgjAHoczitnK
         AOk9F67NXM08HM79t7udb1J+rzhXyuznmrOwMPN19e3SWQTMAmVUVWEyErNSLs7Rp7U3
         bO6fF/lQp/LDETA2YWbcn1qMfFJEbLmnEGolSjinVfdfDSZR2QoHi/FO43QDrAKMISEA
         nMgXznlSlXjFIAHDDk+CbA+rykg1/dZyIhGMx4ENVtMnobUl8tB/89QbKNIMgz3Rauzl
         RehA==
X-Gm-Message-State: ALoCoQntsJbEPful5aZ9j/NG+NvamtGHmzon4zD34TYId8XA59rfZbEro5DjqaNKEXps0xtLEbtg
X-Received: by 10.180.24.102 with SMTP id t6mr18340142wif.83.1442403428217;
        Wed, 16 Sep 2015 04:37:08 -0700 (PDT)
Received: from alex-pc.localdomain (host81-147-157-240.range81-147.btcentralplus.com. [81.147.157.240])
        by smtp.gmail.com with ESMTPSA id qq4sm26112430wjc.14.2015.09.16.04.37.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Sep 2015 04:37:07 -0700 (PDT)
From:   Alex Smith <alex@alex-smith.me.uk>
To:     linux-mtd@lists.infradead.org
Cc:     Alex Smith <alex@alex-smith.me.uk>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v6 0/4] mtd: nand: jz4780: Add NAND and BCH drivers
Date:   Wed, 16 Sep 2015 12:36:53 +0100
Message-Id: <1442403417-5288-1-git-send-email-alex@alex-smith.me.uk>
X-Mailer: git-send-email 2.5.2
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

This version of the series is based on 4.3-rc1.

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
 drivers/mtd/nand/jz4780_nand.c                     | 375 +++++++++++++++++++++
 drivers/mtd/nand/nand_base.c                       |  33 +-
 9 files changed, 927 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
 create mode 100644 drivers/mtd/nand/jz4780_bch.c
 create mode 100644 drivers/mtd/nand/jz4780_bch.h
 create mode 100644 drivers/mtd/nand/jz4780_nand.c

-- 
2.5.2
