Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:53:47 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44380 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835135Ab3FDVxqopA4w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:53:46 +0200
Received: by mail-wi0-f175.google.com with SMTP id hn14so4208221wib.14
        for <multiple recipients>; Tue, 04 Jun 2013 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=fK7ImkAWwWfW0oCDJb/pYlhkR4RNwCitlNbZzsp3UsY=;
        b=ff2XgSmYgB7Ueanic8PSzlrgpV8aeicb3Od8IvYQ7Am5nPJKS5YctoZSmARRxohYtD
         847ZLmwdyFGB3KtP+RqqmEqpJtpOuHaAur5ZsGmzypzVNjBBuBo5SCSzoeFV/PkulCuA
         TUBrZDTfH+GtYC3cs8hwHSPN26e61sxdy5gNyZ67INnNi2zO2qVPWZUqu3rd+hdOiyyO
         IgMqRQ7lM0hDT2TRgFQrZBO/qTbWRTnZp+5GO+ypDRax0WvO+iKxavghuzQuDp4TLdAT
         88NBQXYNkdQdlyCybD3tst8daXPHtqQPwxv4YrRxePNh0AA6CD7iURPPdnZxCvqj6Kfl
         LEqA==
X-Received: by 10.180.93.74 with SMTP id cs10mr3442123wib.42.1370382821410;
        Tue, 04 Jun 2013 14:53:41 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id eq15sm5699480wic.4.2013.06.04.14.53.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:53:40 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        netdev@vger.kernel.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/3 net-next] bcm63xx_enet: add support for BCM63xx gigabit integrated switch
Date:   Tue,  4 Jun 2013 22:53:32 +0100
Message-Id: <1370382815-17904-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

David, Ralf,

This patchset contains changes to enable the BCM63xx gitabit integrated switch
found on BCM6328, BCM6362 and BCM6368 SoCs. It contains changes both to
arch/mips/bcm63xx and drivers/net/ethernet/bcm63xx_enet.c. The changes are
pretty difficult to split so I would rather see these merged via the net-tree.

(this time with netdev CC'd)

Thanks!

Maxime Bizon (3):
  bcm63xx_enet: implement reset autoneg ethtool callback
  bcm63xx_enet: split DMA channel register accesses
  bcm63xx_enet: add support for Broadcom BCM63xx integrated gigabit
    switch

 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    4 +
 arch/mips/bcm63xx/dev-enet.c                       |  118 +-
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |    4 +-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    |   28 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |   63 ++
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |    2 +
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       | 1135 ++++++++++++++++++--
 drivers/net/ethernet/broadcom/bcm63xx_enet.h       |   75 ++
 8 files changed, 1331 insertions(+), 98 deletions(-)

-- 
1.7.10.4
