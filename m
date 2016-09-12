Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 18:25:55 +0200 (CEST)
Received: from mga06.intel.com ([134.134.136.31]:44075 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992127AbcILQZsp1eUS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Sep 2016 18:25:48 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP; 12 Sep 2016 09:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,323,1470726000"; 
   d="gz'50?scan'50,208,50";a="7883485"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2016 09:25:41 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1bjU3d-000K5i-17; Tue, 13 Sep 2016 00:26:09 +0800
Date:   Tue, 13 Sep 2016 00:24:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Baoyou Xie <baoyou.xie@linaro.org>
Cc:     kbuild-all@01.org, ralf@linux-mips.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, paul.burton@imgtec.com,
        chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org,
        yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, toshi.kani@hpe.com, JBeulich@suse.com,
        dan.j.williams@intel.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        baoyou.xie@linaro.org, xie.baoyou@zte.com.cn
Subject: Re: [PATCH] mm: move phys_mem_access_prot_allowed() declaration to
 pgtable.h
Message-ID: <201609130001.Kkcqg3kB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1473683703-15727-1-git-send-email-baoyou.xie@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55109
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


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoyou,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc6 next-20160912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Baoyou-Xie/mm-move-phys_mem_access_prot_allowed-declaration-to-pgtable-h/20160912-211348
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   include/asm-generic/pgtable.h: Assembler messages:
>> include/asm-generic/pgtable.h:817: Error: unknown opcode or format name 'struct'
>> include/asm-generic/pgtable.h:818: Error: extra comma
>> include/asm-generic/pgtable.h:818: Error: syntax error
>> include/asm-generic/pgtable.h:819: Error: unknown opcode or format name 'unsigned'

vim +/struct +817 include/asm-generic/pgtable.h

   811	#define has_transparent_hugepage() 1
   812	#else
   813	#define has_transparent_hugepage() 0
   814	#endif
   815	#endif
   816	
 > 817	struct file;
 > 818	int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
 > 819				unsigned long size, pgprot_t *vma_prot);
   820	#endif /* _ASM_GENERIC_PGTABLE_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--CE+1k2dSO48ffgeK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--CE+1k2dSO48ffgeK--
