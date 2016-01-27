Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 09:37:58 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:30873 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010139AbcA0Ih4YP5sT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 09:37:56 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 27 Jan 2016 00:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,354,1449561600"; 
   d="scan'208";a="642079276"
Received: from wfg-t540p.sh.intel.com ([10.239.199.100])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2016 00:37:47 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
        (envelope-from <fengguang.wu@intel.com>)
        id 1aOLbl-0003ct-Ta; Wed, 27 Jan 2016 16:37:45 +0800
Date:   Wed, 27 Jan 2016 16:37:45 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Message-ID: <20160127083745.GA9933@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <20160126053050.GB20385@wfg-t540p.sh.intel.com>
 <20160126053504.GA22301@wfg-t540p.sh.intel.com>
 <3724678.Yr2Z2lv3F9@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3724678.Yr2Z2lv3F9@wuerfel>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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

Hi Arnd,

Thank you for the tips! I've updated the lists accordingly.

1st priority
============

arm-allmodconfig
arm-allnoconfig
arm-at91_dt_defconfig
arm-efm32_defconfig
arm-exynos_defconfig
arm-multi_v7_defconfig
arm-multi_v8_defconfig
arm-shmobile_defconfig
arm-sunxi_defconfig

2nd priority
============

arm-arm5
arm-arm67
arm-imx_v6_v7_defconfig
arm-ixp4xx_defconfig
arm-mvebu_v7_defconfig
arm-omap2plus_defconfig
arm-sa1100
arm-samsung
arm-sh
arm-tegra_defconfig

3nd priority
============

arch/*/configs/*

Thanks,
Fengguang

On Tue, Jan 26, 2016 at 05:27:46PM +0100, Arnd Bergmann wrote:
> On Tuesday 26 January 2016 13:35:04 Fengguang Wu wrote:
> > > There are a fixed set of config files for fast build tests (which I
> > > selected randomly, feel free to ask me to change the list to more
> > > reasonable ones):
> > > 
> > >       arm-allnoconfig
> > >       arm-at91_dt_defconfig
> > >       arm-at_hdmac
> > >       arm-ep93xx
> > >       arm-imx_v6_v7_defconfig
> > >       arm-iop-adma
> > >       arm-marzen_defconfig
> > >       arm-prima2_defconfig
> > >       arm-sa1100
> > >       arm-samsung
> > >       arm-sh
> > >       arm-spear13xx_defconfig
> > 
> > And there is another set of best effort configs whose priority is
> > in-between the above list and the arch/*/configs/* ones.
> > 
> >         arm-arm5
> >         arm-arm67
> >         arm-mmp
> >         arm-omap2plus_defconfig
> >         arm-s3c2410_defconfig
> >         arm-tegra_defconfig
> > 
> 
> I think we want at least one ARMv7-M NOMMU target in the list,
> I'd pick efm32_defconfig as it has the least overlap with the
> drivers in the other configs.
> 
> I don't know what arm-sh is, but I assume it's a superset of
> marzen, so you can probably drop marzen or move it down to the
> low-prio set. Similarly, the at_hdmac is likely a subset of
> at91_dt_defconfig and could be dropped.
> 
> prima2, ep93xx and spear13xx, mmp and s3c2410 are all
> slow-moving platforms, I would not expect to see much
> results from running those compared to the more active
> platforms.
> 
> The platforms with the most changes these days are omap2plus,
> sunxi, shmobile, and exynos (samsung), followed by some
> that are widely used but not changed as much including
> tegra, imx_v6_v7, mvebu_v7, and qcom (previously msm).
> 
> iop and sa1100 are rather old and won't change much, but it
> can be good to keep them in there because they are for older
> CPU architectures and behave a little different from the
> modern ones. It might be better to replace iop with ixp4xx,
> as this one is the only big-endian defconfig build we have,
> and that sometimes catches build-time bugs.
> 
> 	Arnd
