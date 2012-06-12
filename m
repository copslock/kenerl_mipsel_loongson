Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2012 13:29:17 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:60178 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903699Ab2FLL3K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2012 13:29:10 +0200
Received: by ggcs5 with SMTP id s5so3609335ggc.36
        for <multiple recipients>; Tue, 12 Jun 2012 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=tdQZLiE0rP/3IULZbjyXeAn7a+E/0q9n+/p5QQjtT0E=;
        b=1B59d1VAFWkPViHk6knyTspx6gHMTrDXfc1TTiBN/zbnGhQ7NfuXhubo2WictOejoN
         1UMDZ3tIA/eIZrirJJrmpEl6PVzTB9QOOQ89xz17X1aMT8Bq/ZLklPhqzodxrtHldqlM
         sgBG+ZcdNNAl9GskHePKyh+lyDf2fzkwLMB28XHd5DniXWchpq/3AoEncH59wj20ysoX
         xRUACRqnTwfDG+LCdSwmwpXqSPO6lpiEfRGKQHveY2T9hFAhD1fu0P43Y1yqPYOJMMSb
         5KfTB9NJ5zxXpAWFwKjNaoBtj9b/493ByzpVFavyaPWTi3VCNajwUGTlgX7n73pQRM1U
         u59Q==
Received: by 10.236.193.99 with SMTP id j63mr25906579yhn.45.1339500544809;
        Tue, 12 Jun 2012 04:29:04 -0700 (PDT)
Received: from flexo.localnet ([2a01:e34:ec0d:4090:cf5:eedc:2b17:f9d0])
        by mx.google.com with ESMTPS id n37sm30904284anq.0.2012.06.12.04.29.01
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jun 2012 04:29:03 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 0/8] Add basic support for BCM6328
Date:   Tue, 12 Jun 2012 13:26:44 +0200
Message-ID: <1525623.di3mH0BcIS@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33621
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

Hi Jonas,

On Tuesday 12 June 2012 10:23:37 Jonas Gorski wrote:
> This patchset adds basic support for BCM6328 and its PCIe port.
> 
> The BCM6328 is an ADSL2+ SoC with support for NAND and SPI flash,
> integrated five port ethernet switch, and one PCIe port.
> 
> Patches 1 and 2 add generic flash type detection, as different chips
> support different flash types, and the BCM6328 does not support
> parallel CFI flashes.
> 
> Patches 3-4 add support for detecting and handling the BCM6328 itself.
> This allows booting to command line.
> 
> Patches 5-7 add support for the PCIe port of the BCM6328 and expose
> the PCIe port driver for MIPS (I wonder what is so special about it
> that it isn't included in the standard PCI drivers).
> 
> Patch 8 then adds a 6328 reference board definition, so one can actually
> boot to command line.

Your patchset looks good to me. Feel free to add my Reviewed-by: Florian 
Fainelli <florian@openwrt.org> tag to it.

Thanks!

> 
> Jonas Gorski (8):
>   MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
>   MIPS: BCM63XX: add flash type detection
>   MIPS: BCM63XX: use the Chip ID register for identifying the SoC
>   MIPS: BCM63XX: add basic BCM6328 CPU support
>   MIPS: BCM63XX: Move the PCI initialization into its own function
>   MIPS: BCM63XX: Add PCIe Support for BCM6328
>   MIPS: expose PCIe drivers for MIPS
>   MIPS: BCM63XX: add 96328avng reference board
> 
>  arch/mips/Kconfig                                  |    2 +
>  arch/mips/bcm63xx/Kconfig                          |    4 +
>  arch/mips/bcm63xx/Makefile                         |    4 +-
>  arch/mips/bcm63xx/boards/board_bcm963xx.c          |  106 ++++++++--------
>  arch/mips/bcm63xx/cpu.c                            |   63 ++++++++--
>  arch/mips/bcm63xx/dev-flash.c                      |  123 ++++++++++++++++++
>  arch/mips/bcm63xx/dev-spi.c                        |    2 +-
>  arch/mips/bcm63xx/irq.c                            |   21 +++
>  arch/mips/bcm63xx/prom.c                           |    4 +-
>  arch/mips/bcm63xx/setup.c                          |   13 ++-
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |  120 
+++++++++++++++++-
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_flash.h   |   12 ++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h  |    2 +
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_io.h    |    8 ++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  117 +++++++++++++++++
>  arch/mips/include/asm/mach-bcm63xx/ioremap.h       |    1 +
>  arch/mips/pci/ops-bcm63xx.c                        |   61 +++++++++
>  arch/mips/pci/pci-bcm63xx.c                        |  133 
+++++++++++++++++++-
>  arch/mips/pci/pci-bcm63xx.h                        |    5 +
>  19 files changed, 729 insertions(+), 72 deletions(-)
>  create mode 100644 arch/mips/bcm63xx/dev-flash.c
>  create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
> 
> -- 
> 1.7.2.5
> 
-- 
Florian
