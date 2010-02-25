Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 07:30:26 +0100 (CET)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:35376 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492276Ab0BYGaX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 07:30:23 +0100
Received: by gwj21 with SMTP id 21so2038682gwj.36
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2010 22:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=n4oyeDvsKjrirYQrZ9BRsGEjq29zthlhG95C7nd4BlM=;
        b=s7glxqvWLMard9Gd7aoGsF+SVlRGfnSmSI/fqvwEgW9SAnKOLWKhj9qHDqyvlKod2L
         QXOAYXHa9plRQc0EboPnPhBKT+WRqoyJM9QiqT0CWQdcfu6QJxz5KTjkTa0Daprr3yQq
         wiNtx0IF0E+UdgMQBcdsZ2mqGXdgKWLBggPJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=JhmpsgRmVpN7B2OFuBSIXd0itU6wdjIg2Zw3Qy5gsX55G2RD9iV/k7Z7ZuQl/XKINV
         5JJ6IFW+gfdmcFW/qSVvJdQBpWr4G1WPhdTZ1W2rm2uP3nwnyrED1/8+WNymUOytnd1c
         12uJKdRiOcMFWjXs5O/A+Up384R70WWgeJz8I=
Received: by 10.150.119.35 with SMTP id r35mr974310ybc.49.1267079415198;
        Wed, 24 Feb 2010 22:30:15 -0800 (PST)
Received: from ?10.0.0.13? (eth7090.sa.adsl.internode.on.net [150.101.58.177])
        by mx.google.com with ESMTPS id 8sm1103808yxg.60.2010.02.24.22.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 22:30:14 -0800 (PST)
Message-ID: <4B861890.6090002@gmail.com>
Date:   Thu, 25 Feb 2010 16:58:32 +1030
From:   Graham Gower <graham.gower@gmail.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090820)
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH 0/3] XBurst JZ4730 support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips

This patch set contains support for Ingenic's XBurst cpu, plus basic
support for their JZ4730 reference boards.


Graham Gower (3):
  Add XBurst JZ4730 support.
  8250: serial driver changes for XBurst SoCs.
  net: add driver for JZ4730 ethernet controller.

 arch/mips/Kconfig                                |   13 +
 arch/mips/Makefile                               |   14 +-
 arch/mips/boot/Makefile                          |   15 +-
 arch/mips/include/asm/bootinfo.h                 |    7 +
 arch/mips/include/asm/cpu.h                      |    9 +
 arch/mips/include/asm/mach-generic/irq.h         |    2 +-
 arch/mips/include/asm/mach-xburst/clock-jz4730.h |   41 +
 arch/mips/include/asm/mach-xburst/dma-jz4730.h   |  156 +++
 arch/mips/include/asm/mach-xburst/irq-jz4730.h   |   33 +
 arch/mips/include/asm/mach-xburst/uart-jz4730.h  |  141 +++
 arch/mips/include/asm/mach-xburst/war.h          |   25 +
 arch/mips/include/asm/mach-xburst/xburst.h       |   20 +
 arch/mips/include/asm/r4kcache.h                 |  240 +++++
 arch/mips/kernel/cpu-probe.c                     |   21 +
 arch/mips/mm/c-r4k.c                             |   30 +
 arch/mips/mm/tlbex.c                             |    5 +
 arch/mips/xburst/Kconfig                         |   23 +
 arch/mips/xburst/Makefile                        |    3 +
 arch/mips/xburst/jz4730/Makefile                 |   11 +
 arch/mips/xburst/jz4730/board-libra.c            |   32 +
 arch/mips/xburst/jz4730/board-pmp.c              |   32 +
 arch/mips/xburst/jz4730/clocks.c                 |  294 +++++
 arch/mips/xburst/jz4730/irq.c                    |  104 ++
 arch/mips/xburst/jz4730/platform.c               |   49 +
 arch/mips/xburst/jz4730/prom.c                   |  104 ++
 arch/mips/xburst/jz4730/setup.c                  |  136 +++
 arch/mips/xburst/jz4730/time.c                   |  140 +++
 drivers/net/Kconfig                              |   10 +
 drivers/net/Makefile                             |    1 +
 drivers/net/jz_eth.c                             | 1232 ++++++++++++++++++++++
 drivers/net/jz_eth.h                             |  403 +++++++
 drivers/serial/8250.c                            |   12 +
 32 files changed, 3355 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-xburst/clock-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/dma-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/irq-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/uart-jz4730.h
 create mode 100644 arch/mips/include/asm/mach-xburst/war.h
 create mode 100644 arch/mips/include/asm/mach-xburst/xburst.h
 create mode 100644 arch/mips/xburst/Kconfig
 create mode 100644 arch/mips/xburst/Makefile
 create mode 100644 arch/mips/xburst/jz4730/Makefile
 create mode 100644 arch/mips/xburst/jz4730/board-libra.c
 create mode 100644 arch/mips/xburst/jz4730/board-pmp.c
 create mode 100644 arch/mips/xburst/jz4730/clocks.c
 create mode 100644 arch/mips/xburst/jz4730/irq.c
 create mode 100644 arch/mips/xburst/jz4730/platform.c
 create mode 100644 arch/mips/xburst/jz4730/prom.c
 create mode 100644 arch/mips/xburst/jz4730/setup.c
 create mode 100644 arch/mips/xburst/jz4730/time.c
 create mode 100644 drivers/net/jz_eth.c
 create mode 100644 drivers/net/jz_eth.h
