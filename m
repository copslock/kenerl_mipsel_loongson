Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 08:54:27 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.154]:52724 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491815Ab0BYHyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 08:54:23 +0100
Received: by fg-out-1718.google.com with SMTP id l26so57463fgb.6
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 23:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=ZvWsWOX0i+YDt/9wZFbg4j7qHWXUqw07ySfMSOf0WD8=;
        b=H4gVPusO2vhumvPoCUxH/TlY0UEnq2a5XjUQ2vsJ9KQHk/hEhvnVkS10OhKK+ssjw/
         O6Wvnmvvt5qtpZLQIXmLONRgxs80c5e4Pswe1PeTcIG6al6msnvGk0/muUjhn89l/fmN
         SafARDhGulcTQqcoqXmBe7o5d5FLYLIb8E1CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=DOQTxgwPwpfU6fHHxzoGs7qagxmQpvIYaZeEr5OwlLzpCqmx3Cu6wWn8nf4kTXlM7h
         CMNotC/juA0cz0r98r7BI+oBZhtL2LYea2kc1V6z6JQ78yoIRQ7P2ky07KgJd1siG+bk
         vq0VE7Xv6BxsQKETiunw1Zx+RJquOOP5yl1EM=
Received: by 10.87.69.26 with SMTP id w26mr1604947fgk.39.1267084460537;
        Wed, 24 Feb 2010 23:54:20 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id e11sm555983fga.21.2010.02.24.23.54.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 23:54:19 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Graham Gower <graham.gower@gmail.com>, Mirko Vogt <lists@nanl.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH 0/3] XBurst JZ4730 support
Date:   Thu, 25 Feb 2010 08:52:09 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <4B861890.6090002@gmail.com>
In-Reply-To: <4B861890.6090002@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201002250852.09638.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Graham,

On Thursday 25 February 2010 07:28:32 Graham Gower wrote:
> This patch set contains support for Ingenic's XBurst cpu, plus basic
> support for their JZ4730 reference boards.
> 
> 
> Graham Gower (3):
>   Add XBurst JZ4730 support.
>   8250: serial driver changes for XBurst SoCs.
>   net: add driver for JZ4730 ethernet controller.

Seems like patches 1 and 3 were too big and got retained by the mailing-list 
program.

Maybe you should work with the OpenWrt and qi-hardware guys to get the jz4740 
also merged in the same time?

> 
>  arch/mips/Kconfig                                |   13 +
>  arch/mips/Makefile                               |   14 +-
>  arch/mips/boot/Makefile                          |   15 +-
>  arch/mips/include/asm/bootinfo.h                 |    7 +
>  arch/mips/include/asm/cpu.h                      |    9 +
>  arch/mips/include/asm/mach-generic/irq.h         |    2 +-
>  arch/mips/include/asm/mach-xburst/clock-jz4730.h |   41 +
>  arch/mips/include/asm/mach-xburst/dma-jz4730.h   |  156 +++
>  arch/mips/include/asm/mach-xburst/irq-jz4730.h   |   33 +
>  arch/mips/include/asm/mach-xburst/uart-jz4730.h  |  141 +++
>  arch/mips/include/asm/mach-xburst/war.h          |   25 +
>  arch/mips/include/asm/mach-xburst/xburst.h       |   20 +
>  arch/mips/include/asm/r4kcache.h                 |  240 +++++
>  arch/mips/kernel/cpu-probe.c                     |   21 +
>  arch/mips/mm/c-r4k.c                             |   30 +
>  arch/mips/mm/tlbex.c                             |    5 +
>  arch/mips/xburst/Kconfig                         |   23 +
>  arch/mips/xburst/Makefile                        |    3 +
>  arch/mips/xburst/jz4730/Makefile                 |   11 +
>  arch/mips/xburst/jz4730/board-libra.c            |   32 +
>  arch/mips/xburst/jz4730/board-pmp.c              |   32 +
>  arch/mips/xburst/jz4730/clocks.c                 |  294 +++++
>  arch/mips/xburst/jz4730/irq.c                    |  104 ++
>  arch/mips/xburst/jz4730/platform.c               |   49 +
>  arch/mips/xburst/jz4730/prom.c                   |  104 ++
>  arch/mips/xburst/jz4730/setup.c                  |  136 +++
>  arch/mips/xburst/jz4730/time.c                   |  140 +++
>  drivers/net/Kconfig                              |   10 +
>  drivers/net/Makefile                             |    1 +
>  drivers/net/jz_eth.c                             | 1232
>  ++++++++++++++++++++++ drivers/net/jz_eth.h                             | 
>  403 +++++++
>  drivers/serial/8250.c                            |   12 +
>  32 files changed, 3355 insertions(+), 3 deletions(-)
>  create mode 100644 arch/mips/include/asm/mach-xburst/clock-jz4730.h
>  create mode 100644 arch/mips/include/asm/mach-xburst/dma-jz4730.h
>  create mode 100644 arch/mips/include/asm/mach-xburst/irq-jz4730.h
>  create mode 100644 arch/mips/include/asm/mach-xburst/uart-jz4730.h
>  create mode 100644 arch/mips/include/asm/mach-xburst/war.h
>  create mode 100644 arch/mips/include/asm/mach-xburst/xburst.h
>  create mode 100644 arch/mips/xburst/Kconfig
>  create mode 100644 arch/mips/xburst/Makefile
>  create mode 100644 arch/mips/xburst/jz4730/Makefile
>  create mode 100644 arch/mips/xburst/jz4730/board-libra.c
>  create mode 100644 arch/mips/xburst/jz4730/board-pmp.c
>  create mode 100644 arch/mips/xburst/jz4730/clocks.c
>  create mode 100644 arch/mips/xburst/jz4730/irq.c
>  create mode 100644 arch/mips/xburst/jz4730/platform.c
>  create mode 100644 arch/mips/xburst/jz4730/prom.c
>  create mode 100644 arch/mips/xburst/jz4730/setup.c
>  create mode 100644 arch/mips/xburst/jz4730/time.c
>  create mode 100644 drivers/net/jz_eth.c
>  create mode 100644 drivers/net/jz_eth.h
> 

-- 
Regards, Florian
