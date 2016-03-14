Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 03:00:40 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:18506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007564AbcCNCAimQLfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Mar 2016 03:00:38 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 13 Mar 2016 19:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,334,1455004800"; 
   d="scan'208";a="668970181"
Received: from elu2-mobl98.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.254.214.171])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Mar 2016 19:00:28 -0700
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.86)
        (envelope-from <fengguang.wu@intel.com>)
        id 1afHo3-0000q0-IO; Mon, 14 Mar 2016 10:00:27 +0800
Date:   Mon, 14 Mar 2016 10:00:27 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Alex Smith <alex.smith@imgtec.com>
Cc:     Markos Chandras <markos.chandras@imgtec.com>, kbuild-all@01.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [kbuild-all] arch/mips/vdso/elf.S:1:0: error: '-march=r3900'
 requires '-mfp32'
Message-ID: <20160314020027.GA3055@wfg-t540p.sh.intel.com>
References: <201603131744.eo9ZTwix%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201603131744.eo9ZTwix%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52577
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

Hi Alex,

This error has been there for some time. Shall I stop reporting it
by adding this error to blacklist?

Thanks,
Fengguang

On Sun, Mar 13, 2016 at 05:08:45PM +0800, kbuild test robot wrote:
> Hi Alex,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f414ca64be4b36c30deb5b5fa25c5a8ff42ea56b
> commit: ebb5e78cc63417a35254a791de66e1cc84f963cc MIPS: Initial implementation of a VDSO
> date:   4 months ago
> config: mips-jmr3927_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ebb5e78cc63417a35254a791de66e1cc84f963cc
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/mips/vdso/elf.S:1:0: error: '-march=r3900' requires '-mfp32'
>     /*
>     ^
> --
> >> arch/mips/vdso/sigreturn.S:1:0: error: '-march=r3900' requires '-mfp32'
>     /*
>     ^
> 
> vim +1 arch/mips/vdso/elf.S
> 
>    > 1	/*
>      2	 * Copyright (C) 2015 Imagination Technologies
>      3	 * Author: Alex Smith <alex.smith@imgtec.com>
>      4	 *
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
