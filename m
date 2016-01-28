Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2016 04:15:05 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:58115 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010579AbcA1DOx3j9zE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2016 04:14:53 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 27 Jan 2016 19:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,356,1449561600"; 
   d="scan'208";a="642543055"
Received: from unknown (HELO wfg-t540p.sh.intel.com) ([10.239.192.27])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2016 19:14:38 -0800
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
        (envelope-from <fengguang.wu@intel.com>)
        id 1aOd2Z-0006tp-NK; Thu, 28 Jan 2016 11:14:35 +0800
Date:   Thu, 28 Jan 2016 11:14:35 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re:
 [linux-review:James-Hogan/kbuild-Remove-stale-asm-generic-wrappers/20160119-183642]
 d979f99e9cc14e2667e9b6e268db695977e4197a BUILD DONE
Message-ID: <20160128031435.GA25625@wfg-t540p.sh.intel.com>
References: <569e1dbb.MgLv8OaZwklOxxtU%fengguang.wu@intel.com>
 <1947556.38OyJnvGS5@wuerfel>
 <20160127093018.GA21190@wfg-t540p.sh.intel.com>
 <3596300.IYfzmako0c@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3596300.IYfzmako0c@wuerfel>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51505
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

On Wed, Jan 27, 2016 at 10:44:01AM +0100, Arnd Bergmann wrote:
> On Wednesday 27 January 2016 17:30:18 Fengguang Wu wrote:
> 
> > > Looks good, I'm just unsure about "multi_v8_defconfig", this does not
> > > exist. Do you mean multi_v5_defconfig?
> 
> > Ah yes, multi_v8_defconfig does not exist actually.
> 
> Ok, can you include multi_v5_defconfig than?
 
OK, done.

> I see you have one named "arm-arm5", which may be the same.

Yes, looks so -- it's provided by someone else long time ago.

> > > I also wonder if you include 'randconfig' builds for some architectures.
> > > I have patches for all remaining errors and warnings that I see with
> > > ARM randconfig builds today. Not all of them are merged yet, but I could
> > > probably come up with a file to be used as input to KCONFIG_ALLCONFIG
> > > to eliminate the known-broken configurations, if you are interested.
> > 
> > If the are mostly ready for upstream, it may be easier to wait until
> > upstream randconfig works just fine for ARM.
> 
> I have around 130 patches for warnings that I'm submitting at the moment, but
> there are a couple of really tricky ones that I don't currently have
> a good plan for:
> 
> - in some configurations, you end up without any boards selected, hitting
>   an #error in the final link
> - ARMv3 support in gcc is rather broken and causes internal compiler errors
>   among other things
> - the old ELF format (OABI) doesn't work in some cases
> - GCOV_PROFILE_ALL causes problems that need to be debugged
> - XIP_KERNEL sometimes causes kallsyms to fail
> - not all platforms implement the complete clk API, if they don't
>   use CONFIG_COMMON_CLK (I have patch for that we can probably merge)

The robot may explicitly enable/disable some CONFIG_* after randconfig
to workaround known problems.

> - CONFIG_PHYS_OFFSET needs to be entered manually to be a number
>   in 'make config'

That's a problem for auto tests.

> - same for DEBUG_LL

Thanks,
Fengguang
