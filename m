Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 12:06:34 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:53971 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903554Ab2E3KG2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 12:06:28 +0200
Received: by eekd17 with SMTP id d17so1928839eek.36
        for <multiple recipients>; Wed, 30 May 2012 03:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=SbBljVLCO6Gum7gcgAo3twryP+7S0NoNG43AOVUKXaE=;
        b=l7agXkLoOoZcOQWNfwKg/dc7P3OwZMdYlPciBigeFDZx855t5BBOkHY3ulcXTUdJ4L
         hec0ZGD/3NsWoCjJeUCqKuUOkEzrV+Yxh9IqQhmLj2Hq/1WhYOBSP0VsYTNmuG6sdlD8
         9iVrpUkzwiaINtz8mEHDJXUSxXolydXlH8QK64WDd8W/gAPJoCEub69Cf6BcAnAoZfyC
         BgZfTgDPbBL0HKMl3vEAtciMXO530Xz34n6UX1g9BNI6yf73zKSNI2f4EYv+/pCIzFv3
         VQumw5/VXFSIrAZivcTyf2PXJEZqGlqnDK7gryFSGJocgLhFLNKaEI2eRI4R5FhcvuQe
         qy6w==
Received: by 10.14.95.72 with SMTP id o48mr5903165eef.230.1338372383161;
        Wed, 30 May 2012 03:06:23 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id c51sm58705048eei.12.2012.05.30.03.06.19
        (version=SSLv3 cipher=OTHER);
        Wed, 30 May 2012 03:06:19 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH 0/9 v3] MIPS: BCM63XX: add support for SPI
Date:   Wed, 30 May 2012 12:04:14 +0200
Message-ID: <3262201.kIFrIcTNNo@flexo>
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic; KDE/4.8.2; x86_64; ; )
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33484
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Ralf,

On Tuesday 31 January 2012 15:10:39 Florian Fainelli wrote:
> This patch set depend on the serie "MIPS: BCM63XX: misc cleanup" and
> adds support for the SPI controller found in BCM63xx SoCs.
> 
> Grant, it probably makes sense to get this merged via the MIPS tree
> since it mostly depends on it.

Grant merged the SPI driver a while ago during 3.4, and now we can't build 
this driver because the platform-specific knobs have not been merged.

The only complains where from Maxime about the SPI driver itself, not the 
other changes, can you merge this series without the latest patch?

Thanks!

> 
> Florian Fainelli (9):
>   MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
>   MIPS: BCM63XX: define BCM6358 SPI base address
>   MIPS: BCM63XX: add BCM6368 SPI clock mask
>   MIPS: BCM63XX: define SPI register sizes.
>   MIPS: BCM63XX: remove SPI2 register
>   MIPS: BCM63XX: define internal registers offsets of the SPI
>     controller
>   MIPS: BCM63XX: add stub to register the SPI platform driver
>   MIPS: BCM63XX: make board setup code register the spi platform device
>   spi: add Broadcom BCM63xx SPI controller driver
> 
>  arch/mips/bcm63xx/Makefile                         |    3 +-
>  arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 +
>  arch/mips/bcm63xx/clk.c                            |    6 +-
>  arch/mips/bcm63xx/dev-spi.c                        |  119 +++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   23 +-
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 ++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  119 +++++
>  drivers/spi/Kconfig                                |    6 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-bcm63xx.c                          |  486 
++++++++++++++++++++
>  10 files changed, 842 insertions(+), 13 deletions(-)
>  create mode 100644 arch/mips/bcm63xx/dev-spi.c
>  create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
>  create mode 100644 drivers/spi/spi-bcm63xx.c
> 
> -- 
> 1.7.5.4
> 
