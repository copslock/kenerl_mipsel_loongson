Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 10:30:30 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:53370 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010410AbcA0Ja3WhsHB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 10:30:29 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP; 27 Jan 2016 01:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,354,1449561600"; 
   d="scan'208";a="642099389"
Received: from wfg-t540p.sh.intel.com ([10.239.199.100])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2016 01:30:19 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
        (envelope-from <fengguang.wu@intel.com>)
        id 1aOMQc-0005iz-ND; Wed, 27 Jan 2016 17:30:18 +0800
Date:   Wed, 27 Jan 2016 17:30:18 +0800
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
Message-ID: <20160127093018.GA21190@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <3724678.Yr2Z2lv3F9@wuerfel>
 <20160127083745.GA9933@wfg-t540p.sh.intel.com>
 <1947556.38OyJnvGS5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1947556.38OyJnvGS5@wuerfel>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51461
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

On Wed, Jan 27, 2016 at 10:11:47AM +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 16:37:45 Fengguang Wu wrote:
> > 
> > Thank you for the tips! I've updated the lists accordingly.
> > 
> > 1st priority
> > ============
> > 
> > arm-allmodconfig
> > arm-allnoconfig
> > arm-at91_dt_defconfig
> > arm-efm32_defconfig
> > arm-exynos_defconfig
> > arm-multi_v7_defconfig
> > arm-multi_v8_defconfig
> > arm-shmobile_defconfig
> > arm-sunxi_defconfig
> > 
> > 2nd priority
> > ============
> > 
> > arm-arm5
> > arm-arm67
> > arm-imx_v6_v7_defconfig
> > arm-ixp4xx_defconfig
> > arm-mvebu_v7_defconfig
> > arm-omap2plus_defconfig
> > arm-sa1100
> > arm-samsung
> > arm-sh
> > arm-tegra_defconfig
> > 
> > 3nd priority
> > ============
> > 
> > arch/*/configs/*
> 
> Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> exist. Do you mean multi_v5_defconfig?

Ah yes, multi_v8_defconfig does not exist actually.

> I also wonder if you include 'randconfig' builds for some architectures.
> I have patches for all remaining errors and warnings that I see with
> ARM randconfig builds today. Not all of them are merged yet, but I could
> probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> to eliminate the known-broken configurations, if you are interested.

If the are mostly ready for upstream, it may be easier to wait until
upstream randconfig works just fine for ARM.

Thanks,
Fengguang
