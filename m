Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 13:24:22 +0100 (CET)
Received: from mga05.intel.com ([192.55.52.43]:32861 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992279AbcKJMYP0hDp2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 13:24:15 +0100
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP; 10 Nov 2016 04:24:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,618,1473145200"; 
   d="gz'50?scan'50,208,50";a="29736406"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2016 04:24:04 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1c4oPV-000PVL-54; Thu, 10 Nov 2016 20:24:53 +0800
Date:   Thu, 10 Nov 2016 20:23:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     kbuild-all@01.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        james.hogan@imgtec.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] MIPS: fix duplicate define
Message-ID: <201611102022.W1caG4gN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <1478724294-15736-1-git-send-email-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55771
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sudip,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.9-rc4 next-20161110]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sudip-Mukherjee/MIPS-fix-duplicate-define/20161110-044738
config: mips-ip27_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from arch/mips/include/asm/page.h:194:0,
                    from arch/mips/vdso/vdso.h:26,
                    from arch/mips/vdso/gettimeofday.c:11:
   arch/mips/include/asm/io.h: In function 'phys_to_virt':
>> arch/mips/include/asm/io.h:138:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
            ^
   arch/mips/include/asm/io.h: In function 'isa_bus_to_virt':
   arch/mips/include/asm/io.h:151:9: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
     return (void *)(address + PAGE_OFFSET);
            ^
   cc1: all warnings being treated as errors

vim +138 arch/mips/include/asm/io.h

^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  122  }
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  123  
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  124  /*
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  125   *     phys_to_virt    -       map physical address to virtual
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  126   *     @address: address to remap
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  127   *
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  128   *     The returned virtual address is a current CPU mapping for
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  129   *     the memory address given. It is only valid to use this function on
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  130   *     addresses that have a kernel mapping
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  131   *
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  132   *     This function does not handle bus mappings for DMA transfers. In
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  133   *     almost all conceivable cases a device driver should not be using
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  134   *     this function
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  135   */
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  136  static inline void * phys_to_virt(unsigned long address)
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  137  {
6f284a2c include/asm-mips/io.h Franck Bui-Huu 2007-01-10 @138  	return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  139  }
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  140  
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  141  /*
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  142   * ISA I/O bus memory addresses are 1:1 with the physical address.
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  143   */
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  144  static inline unsigned long isa_virt_to_bus(volatile void * address)
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  145  {
^1da177e include/asm-mips/io.h Linus Torvalds 2005-04-16  146  	return (unsigned long)address - PAGE_OFFSET;

:::::: The code at line 138 was first introduced by commit
:::::: 6f284a2ce7b8bc49cb8455b1763357897a899abb [MIPS] FLATMEM: introduce PHYS_OFFSET.

:::::: TO: Franck Bui-Huu <fbuihuu@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xtoq3c/QMbNVWXofBOL8H/6mgCpu7AAA

--xHFwDpU9dbj6ez1V--
