Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2014 09:23:04 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:65094 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816900AbaDQHW4jXPHT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Apr 2014 09:22:56 +0200
Received: by mail-pb0-f50.google.com with SMTP id md12so71540pbc.9
        for <multiple recipients>; Thu, 17 Apr 2014 00:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JRSYuCHTdf/tf6tsYs60FNXIt5MFa80KKY1p2IAMkZA=;
        b=E/8UIq8Z70hyRe+w1OstkPlus///kMPkSW03PoYVPxWo43iOABwKvqJ346yZQpG5VP
         +seY1kwuprsYD2Ozf1DQ79pvP/iEsaRXHaDeunRJ7b7S8lUtcNFB/W11FteWLQv7rrCj
         9BdaRmrQvDw0HeYiRXS3jHDPWnUQw+wuriuq8SSzmN2eA9V6UVi0eAOdZUjS2pIBlm9+
         uf+aQcljN5SIjZZQLkuQROUs0UuEYf69MudJtXk0eXzaZXXI2zv/eJlB75zdmLcC6KgR
         86O2d+WzGO8Gsv3zWk2izIYSlG3l7yoafCHwn52rkEwAje7KFuhrBiaSOPhdls/E3UAj
         JSUQ==
X-Received: by 10.67.4.169 with SMTP id cf9mr13624981pad.45.1397719369770;
        Thu, 17 Apr 2014 00:22:49 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-154-223-43.socal.res.rr.com. [98.154.223.43])
        by mx.google.com with ESMTPSA id yx3sm51572778pbb.6.2014.04.17.00.22.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Apr 2014 00:22:49 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marex@denx.de>, <linux-mtd@lists.infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@freescale.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Steven Miao <realmz6@gmail.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
Date:   Thu, 17 Apr 2014 00:21:44 -0700
Message-Id: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39847
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

Hi all,

We are introducing a new SPI-NOR library/framework for MTD, to support various
types of SPI-NOR flash controllers which require (or benefit from) intimate
knowledge of the flash interface, rather than just the relatively dumb SPI
interface. This library borrows much of the m25p80 driver for its abstraction
and moves this code into a spi-nor module.

This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
should be added to the defconfigs. I'm not sure what is the best process for
doing this. Should each $ARCH maintainer just take their respective patch, even
if the MTD_SPI_NOR Kconfig symbol is not defined for them yet? Or should
maintainers plan on merging the relevant SPI-NOR code into their trees during
the development cycle? Or some third option?

Anyway, the patches are here. Please keep general comments to the cover letter,
so all parties can see.

This series is based on the development repo for MTD, in the 'spinor' branch:

  git://git.infradead.org/l2-mtd.git +spinor

This series is available in the same repo at:

  git://git.infradead.org/l2-mtd.git +defconfigs

I tried locally merging this into linux-next and saw a trivial conflict in
arch/arm/configs/shmobile_defconfig. I can resubmit based on an appropriate
tree, if requested.

Thanks,
Brian

P.S. I was going to purely automatically generate this diff as follows, but
it generated a lot of defconfig noise:

	#!/bin/sh
	for i in arm blackfin mips powerpc sh
	do 
		for j in `git grep -l M25P80 arch/$i/configs`
		do 
			echo $j
			cp $j .config
			echo CONFIG_MTD_SPI_NOR=y >> .config
			make ARCH=$i savedefconfig
			mv defconfig $j
		done
	done

So I did a mixed approach, where I filtered most of the noise out of the diff.

Brian Norris (5):
  ARM: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
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
