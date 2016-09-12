Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Sep 2016 17:40:46 +0200 (CEST)
Received: from mga06.intel.com ([134.134.136.31]:55269 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992127AbcILPkkPREsG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Sep 2016 17:40:40 +0200
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP; 12 Sep 2016 08:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,323,1470726000"; 
   d="gz'50?scan'50,208,50";a="877869754"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2016 08:40:33 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1bjTLy-000Bn0-0v; Mon, 12 Sep 2016 23:41:02 +0800
Date:   Mon, 12 Sep 2016 23:40:13 +0800
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
Message-ID: <201609122325.DsiRey1J%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
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
X-archive-position: 55108
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoyou,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc6 next-20160912]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Baoyou-Xie/mm-move-phys_mem_access_prot_allowed-declaration-to-pgtable-h/20160912-211348
config: m32r-m32104ut_defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All errors (new ones prefixed by >>):

   include/asm-generic/pgtable.h: Assembler messages:
>> include/asm-generic/pgtable.h:817: Error: bad instruction `struct file'
>> include/asm-generic/pgtable.h:818: Error: bad instruction `int phys_mem_access_prot_allowed(struct file*file,...'
>> include/asm-generic/pgtable.h:819: Error: bad instruction `unsigned long size,pgprot_t*vma_prot)'

vim +817 include/asm-generic/pgtable.h

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

--Nq2Wo0NMKNjxTN9z
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qAAA

--Nq2Wo0NMKNjxTN9z--
