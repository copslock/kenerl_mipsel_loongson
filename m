Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 23:41:48 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:61105 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835128Ab3FDVlpPFH4g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 23:41:45 +0200
Received: by mail-wi0-f169.google.com with SMTP id hn14so4334226wib.0
        for <multiple recipients>; Tue, 04 Jun 2013 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=VEvCTvsavXlXNGsNRlSbVu3IihZyreokJ4EcAWO52C4=;
        b=JRGdZbBPhjc0K04O8JBabZV7wMqaz8JfEDPxydl1uiD012DesUwa+kKx+k4YAHhAab
         IT1Q0rIFxZCbmT8XlObJVYTeJN50XfCglZIRjJtCzaFmlcjYJD/vw2VFFYCLrlOJOJZU
         5hS+qkmKMckZYq8N5a2giG+a3ynHcW87QbYz7KR8qQpfwm/sw4PS+zTg5rbrcZlGb4+p
         /lKd4/igSlwqhjUFK0gcK+RqQqT3/X9CJx3HjB/0HBHsfQOq/b4aL6VHSv5efPQzpXt3
         g6yp9dEF5r1gLkNSC7F10tPfgHw8fMZITdSlmVAby58Oj7fyAZWTAyR0wRkqfxHoqZPh
         aVAA==
X-Received: by 10.194.220.72 with SMTP id pu8mr25959749wjc.2.1370382098968;
        Tue, 04 Jun 2013 14:41:38 -0700 (PDT)
Received: from localhost.localdomain (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id w8sm6473724wiz.0.2013.06.04.14.41.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 14:41:37 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     davem@davemloft.net
Cc:     ralf@linux-mips.org, blogic@openwrt.org, linux-mips@linux-mips.org,
        cernekee@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/3 net-next] bcm63xx_enet: add support for BCM63xx gigabit integrated switch
Date:   Tue,  4 Jun 2013 22:41:31 +0100
Message-Id: <1370382094-17821-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36683
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
