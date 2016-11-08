Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 00:47:18 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:64259 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992285AbcKHXrLVYEQj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2016 00:47:11 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP; 08 Nov 2016 15:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,611,1473145200"; 
   d="gz'50?scan'50,208,50";a="1057097580"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2016 15:47:01 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1c4G7K-000TOr-18; Wed, 09 Nov 2016 07:47:50 +0800
Date:   Wed, 9 Nov 2016 07:46:32 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     kbuild-all@01.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] MIPS: fix duplicate define
Message-ID: <201611090756.rtyiialH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <1478641415-6986-1-git-send-email-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55730
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


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sudip,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc4 next-20161108]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sudip-Mukherjee/MIPS-fix-duplicate-define/20161109-054643
config: mips-jz4740 (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from arch/mips/include/asm/mach-ip22/spaces.h:25:0,
                    from arch/mips/include/asm/addrspace.h:13,
                    from arch/mips/include/asm/barrier.h:11,
                    from arch/mips/include/asm/bitops.h:18,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/sched.h:17,
                    from arch/mips/kernel/asm-offsets.c:13:
   arch/mips/include/asm/page.h: In function '___pa':
>> arch/mips/include/asm/mach-generic/spaces.h:93:23: error: 'CAC_BASE' undeclared (first use in this function)
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
>> arch/mips/include/asm/page.h:190:13: note: in expansion of macro 'PAGE_OFFSET'
     return x - PAGE_OFFSET + PHYS_OFFSET;
                ^~~~~~~~~~~
   arch/mips/include/asm/mach-generic/spaces.h:93:23: note: each undeclared identifier is reported only once for each function it appears in
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
>> arch/mips/include/asm/page.h:190:13: note: in expansion of macro 'PAGE_OFFSET'
     return x - PAGE_OFFSET + PHYS_OFFSET;
                ^~~~~~~~~~~
   arch/mips/include/asm/io.h: In function 'phys_to_virt':
>> arch/mips/include/asm/mach-generic/spaces.h:93:23: error: 'CAC_BASE' undeclared (first use in this function)
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
>> arch/mips/include/asm/io.h:138:28: note: in expansion of macro 'PAGE_OFFSET'
     return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
                               ^~~~~~~~~~~
   arch/mips/include/asm/io.h: In function 'isa_virt_to_bus':
>> arch/mips/include/asm/mach-generic/spaces.h:93:23: error: 'CAC_BASE' undeclared (first use in this function)
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
   arch/mips/include/asm/io.h:146:34: note: in expansion of macro 'PAGE_OFFSET'
     return (unsigned long)address - PAGE_OFFSET;
                                     ^~~~~~~~~~~
   arch/mips/include/asm/io.h: In function 'isa_bus_to_virt':
>> arch/mips/include/asm/mach-generic/spaces.h:93:23: error: 'CAC_BASE' undeclared (first use in this function)
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
   arch/mips/include/asm/io.h:151:28: note: in expansion of macro 'PAGE_OFFSET'
     return (void *)(address + PAGE_OFFSET);
                               ^~~~~~~~~~~
   include/linux/mm.h: In function 'lowmem_page_address':
>> arch/mips/include/asm/mach-generic/spaces.h:93:23: error: 'CAC_BASE' undeclared (first use in this function)
    #define PAGE_OFFSET  (CAC_BASE + PHYS_OFFSET)
                          ^
   arch/mips/include/asm/page.h:193:49: note: in expansion of macro 'PAGE_OFFSET'
    #define __va(x)  ((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
                                                    ^~~~~~~~~~~
>> include/linux/mm.h:76:25: note: in expansion of macro '__va'
    #define page_to_virt(x) __va(PFN_PHYS(page_to_pfn(x)))
                            ^~~~
>> include/linux/mm.h:1005:9: note: in expansion of macro 'page_to_virt'
     return page_to_virt(page);
            ^~~~~~~~~~~~
   make[2]: *** [arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/CAC_BASE +93 arch/mips/include/asm/mach-generic/spaces.h

875d43e7 include/asm-mips/mach-generic/spaces.h      Ralf Baechle   2005-09-03  87  #endif /* CONFIG_64BIT */
^1da177e include/asm-mips/mach-generic/spaces.h      Linus Torvalds 2005-04-16  88  
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  89  /*
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  90   * This handles the memory map.
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  91   */
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  92  #ifndef PAGE_OFFSET
db385015 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04 @93  #define PAGE_OFFSET		(CAC_BASE + PHYS_OFFSET)
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  94  #endif
c4612c85 include/asm-mips/mach-generic/spaces.h      Franck Bui-Huu 2007-06-04  95  
565b60de arch/mips/include/asm/mach-generic/spaces.h Kevin Cernekee 2010-09-07  96  #ifndef FIXADDR_TOP

:::::: The code at line 93 was first introduced by commit
:::::: db38501511a7513ec4f0ae9922d847c135cf3c78 [MIPS] Make PAGE_OFFSET aware of PHYS_OFFSET

:::::: TO: Franck Bui-Huu <fbuihuu@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qMm9M+Fa2AknHoGS
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
bI3jOQEA

--qMm9M+Fa2AknHoGS--
