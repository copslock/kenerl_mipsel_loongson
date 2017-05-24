Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 13:23:24 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:26941 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993918AbdEXLWpjSVB8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 13:22:45 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP; 24 May 2017 04:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,385,1491289200"; 
   d="gz'50?scan'50,208,50";a="91192360"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2017 04:22:39 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dDUQp-000UoX-6g; Wed, 24 May 2017 19:26:23 +0800
Date:   Wed, 24 May 2017 19:22:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     kbuild-all@01.org, monstr@monstr.eu, ralf@linux-mips.org,
        liqin.linux@gmail.com, lennox.wu@gmail.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
Message-ID: <201705241905.OzPQLbyr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20170523220546.16758-7-palmer@dabbelt.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Palmer,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.12-rc2]
[cannot apply to next-20170524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/lib-Add-shared-copies-of-some-GCC-library-routines/20170524-170717
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

>> make[3]: *** No rule to make target 'arch/sh/lib/ashldi3.c', needed by 'arch/sh/boot/compressed/ashldi3.c'.
   make[3]: Target 'arch/sh/boot/compressed/vmlinux' not remade because of errors.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
