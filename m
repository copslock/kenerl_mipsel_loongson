Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 08:33:48 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:38935 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854764AbaEAG1nY29aA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 08:27:43 +0200
Received: by mail-pd0-f173.google.com with SMTP id p10so2721246pdj.4
        for <multiple recipients>; Wed, 30 Apr 2014 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Y92ONcaGCO1zLoK6Miv65Ot2ESOHKxfBI8Z12px92GY=;
        b=LIPwv/V7rq9UdITI4Gyipz9Rqs+hjZC6hBhCeQLBV4RZwsDt8wpi2RwLmn8hs6GrGg
         tQVBgmzkHe23tknG91AqBCZH4CnVZow5RXn9dDNDEsLe/EvVdU0AEN9xi6qsu9Ra2Qoj
         YeTkbDuvek99OaMT9RC25zgDSuzZROxSHcyui61nW3q+/QHczQ3fzxTUYrHU72NwixR0
         s/bDGatAtDwJ7lNcQ2glLHdECOS0rGBRCCn57oBZH0H1SnbHfTjaMimoSxkCwktmzJ8w
         6jE8WvpFasuY7uNQofCH0amEZQv1a1Mtnc1q9VIieSxFT5TbAWFyZH5OlHb3rkbV3Jf5
         nx+g==
X-Received: by 10.66.102.39 with SMTP id fl7mr17389003pab.43.1398925638956;
        Wed, 30 Apr 2014 23:27:18 -0700 (PDT)
Received: from norris-Latitude-E6410.globalsuite.net ([12.104.145.50])
        by mx.google.com with ESMTPSA id yq4sm149337568pab.34.2014.04.30.23.27.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 23:27:18 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Huang Shijie <b32955@freescale.com>,
        Marek Vasut <marex@denx.de>, <linux-mtd@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        adi-buildroot-devel@lists.sourceforge.net,
        Andrew Lunn <andrew@lunn.ch>,
        Andrew Victor <linux@maxim.org.za>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Shawn Guo <shawn.guo@freescale.com>,
        Simon Horman <horms@verge.net.au>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Steven Miao <realmz6@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 00/12] defconfigs: add MTD_SPI_NOR (new subsystem dependency for M25P80)
Date:   Wed, 30 Apr 2014 23:26:35 -0700
Message-Id: <1398925607-7482-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

v1 --> v2: split ARM defconfig changes into their sub-architectures. No change
           in the overall diff.

Hi all,

We are introducing a new SPI-NOR subsystem/framework for MTD, to support
various types of SPI-NOR flash controllers which require (or benefit from)
intimate knowledge of the flash interface, rather than just the relatively dumb
SPI interface. This framework borrows much of the m25p80 driver for its
abstraction and moves this code into a spi-nor module.

This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
should be added to the defconfigs. I expect that each (sub)architecture
maintainer can merge these patches to their own tree.

Note that without the new CONFIG_MTD_SPI_NOR symbol in your defconfig, Kconfig
will automatically drop M25P80 for you.

Please keep general comments to the cover letter, so all parties can see.

This series is based on 3.15-rc1.

The SPI-NOR development code (in -next, queued for 3.16) is here:

  git://git.infradead.org/l2-mtd.git +spinor

This defconfig series is available in the same repo at:

  git://git.infradead.org/l2-mtd.git +defconfigs

Thanks,
Brian

Brian Norris (12):
  ARM: imx/mxs defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: keystone: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: tegra: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: lpc32xx: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: at91: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: shmobile: add MTD_SPI_NOR (new dependency for M25P80)
  ARM: marvell: add MTD_SPI_NOR (new dependency for M25P80)
  blackfin: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
  mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
  powerpc: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
  sh: defconfig: add MTD_SPI_NOR (new dependency for M25P80)

 arch/arm/configs/bockw_defconfig               | 2 +-
 arch/arm/configs/dove_defconfig                | 2 +-
 arch/arm/configs/imx_v6_v7_defconfig           | 1 +
 arch/arm/configs/keystone_defconfig            | 1 +
 arch/arm/configs/kirkwood_defconfig            | 1 +
 arch/arm/configs/koelsch_defconfig             | 1 +
 arch/arm/configs/lager_defconfig               | 1 +
 arch/arm/configs/lpc32xx_defconfig             | 2 +-
 arch/arm/configs/multi_v5_defconfig            | 1 +
 arch/arm/configs/multi_v7_defconfig            | 1 +
 arch/arm/configs/mvebu_v5_defconfig            | 1 +
 arch/arm/configs/mvebu_v7_defconfig            | 1 +
 arch/arm/configs/mxs_defconfig                 | 1 +
 arch/arm/configs/sama5_defconfig               | 2 +-
 arch/arm/configs/shmobile_defconfig            | 1 +
 arch/arm/configs/tegra_defconfig               | 1 +
 arch/blackfin/configs/BF526-EZBRD_defconfig    | 2 +-
 arch/blackfin/configs/BF527-EZKIT-V2_defconfig | 2 +-
 arch/blackfin/configs/BF527-EZKIT_defconfig    | 2 +-
 arch/blackfin/configs/BF548-EZKIT_defconfig    | 2 +-
 arch/blackfin/configs/BF609-EZKIT_defconfig    | 2 +-
 arch/blackfin/configs/BlackStamp_defconfig     | 3 +--
 arch/blackfin/configs/H8606_defconfig          | 3 +--
 arch/mips/configs/ath79_defconfig              | 3 +--
 arch/mips/configs/db1xxx_defconfig             | 1 +
 arch/mips/configs/rt305x_defconfig             | 2 +-
 arch/powerpc/configs/corenet32_smp_defconfig   | 2 +-
 arch/powerpc/configs/corenet64_smp_defconfig   | 2 +-
 arch/powerpc/configs/mpc85xx_defconfig         | 2 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig     | 2 +-
 arch/sh/configs/sh7757lcr_defconfig            | 2 +-
 31 files changed, 31 insertions(+), 21 deletions(-)

-- 
1.8.3.2
