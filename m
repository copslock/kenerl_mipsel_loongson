Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2018 03:09:47 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:45835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992328AbeI0BJnyi1iN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Sep 2018 03:09:43 +0200
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 18:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,308,1534834800"; 
   d="gz'50?scan'50,208,50";a="92227832"
Received: from unknown (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2018 18:09:26 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g5Ko2-000A4Y-5I; Thu, 27 Sep 2018 09:09:26 +0800
Date:   Thu, 27 Sep 2018 09:09:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org
Subject: [mips-linux:mips-fixes 1/1] arch/mips/include/asm/mips-gic.h:12:3:
 error: #error Please include asm/mips-cps.h rather than asm/mips-gic.h
Message-ID: <201809270905.9w6w5PuR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <lkp@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66594
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git mips-fixes
head:   f41f5d3b507ac6a18a63d948d3594952b294b43a
commit: f41f5d3b507ac6a18a63d948d3594952b294b43a [1/1] MIPS: VDSO: Always map near top of user memory
config: mips-allnoconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f41f5d3b507ac6a18a63d948d3594952b294b43a
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from arch/mips/kernel/process.c:43:0:
>> arch/mips/include/asm/mips-gic.h:12:3: error: #error Please include asm/mips-cps.h rather than asm/mips-gic.h
    # error Please include asm/mips-cps.h rather than asm/mips-gic.h
      ^~~~~
>> arch/mips/include/asm/mips-gic.h:168:17: error: expected ')' before numeric constant
    GIC_ACCESSOR_RW(32, 0x000, config)
                    ^
   arch/mips/include/asm/mips-gic.h:39:23: note: in definition of macro 'GIC_ACCESSOR_RW'
     CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
                          ^~
   arch/mips/include/asm/mips-gic.h: In function 'read_gic_pol':
>> arch/mips/include/asm/mips-gic.h:98:23: error: implicit declaration of function 'addr_gic_pol'; did you mean 'read_gic_pol'? [-Werror=implicit-function-declaration]
     void __iomem *addr = addr_gic_##name();    \
                          ^
>> arch/mips/include/asm/mips-gic.h:114:2: note: in expansion of macro 'GIC_ACCESSOR_RO_INTR_BIT'
     GIC_ACCESSOR_RO_INTR_BIT(off, name)    \
     ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:98:23: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
     void __iomem *addr = addr_gic_##name();    \
                          ^
>> arch/mips/include/asm/mips-gic.h:114:2: note: in expansion of macro 'GIC_ACCESSOR_RO_INTR_BIT'
     GIC_ACCESSOR_RO_INTR_BIT(off, name)    \
     ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:101:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
>> arch/mips/include/asm/mips-gic.h:114:2: note: in expansion of macro 'GIC_ACCESSOR_RO_INTR_BIT'
     GIC_ACCESSOR_RO_INTR_BIT(off, name)    \
     ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h:101:6: note: each undeclared identifier is reported only once for each function it appears in
     if (mips_cm_is64) {      \
         ^
>> arch/mips/include/asm/mips-gic.h:114:2: note: in expansion of macro 'GIC_ACCESSOR_RO_INTR_BIT'
     GIC_ACCESSOR_RO_INTR_BIT(off, name)    \
     ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'write_gic_pol':
   arch/mips/include/asm/mips-gic.h:118:23: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
     void __iomem *addr = addr_gic_##name();    \
                          ^
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h:120:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'change_gic_pol':
   arch/mips/include/asm/mips-gic.h:132:23: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
     void __iomem *addr = addr_gic_##name();    \
                          ^
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h:134:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
>> arch/mips/include/asm/mips-gic.h:180:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'read_gic_trig':
>> arch/mips/include/asm/mips-gic.h:101:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
>> arch/mips/include/asm/mips-gic.h:114:2: note: in expansion of macro 'GIC_ACCESSOR_RO_INTR_BIT'
     GIC_ACCESSOR_RO_INTR_BIT(off, name)    \
     ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h:187:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x180, trig)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'write_gic_trig':
   arch/mips/include/asm/mips-gic.h:120:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
   arch/mips/include/asm/mips-gic.h:187:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x180, trig)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'change_gic_trig':
   arch/mips/include/asm/mips-gic.h:134:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^
   arch/mips/include/asm/mips-gic.h:187:1: note: in expansion of macro 'GIC_ACCESSOR_RW_INTR_BIT'
    GIC_ACCESSOR_RW_INTR_BIT(0x180, trig)
    ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/include/asm/mips-gic.h: In function 'read_gic_dual':
>> arch/mips/include/asm/mips-gic.h:101:6: error: 'mips_cm_is64' undeclared (first use in this function); did you mean 'mips_hi16'?
     if (mips_cm_is64) {      \
         ^

vim +12 arch/mips/include/asm/mips-gic.h

582e2b4a Paul Burton 2017-08-12  @12  # error Please include asm/mips-cps.h rather than asm/mips-gic.h
582e2b4a Paul Burton 2017-08-12   13  #endif
582e2b4a Paul Burton 2017-08-12   14  
582e2b4a Paul Burton 2017-08-12   15  #ifndef __MIPS_ASM_MIPS_GIC_H__
582e2b4a Paul Burton 2017-08-12   16  #define __MIPS_ASM_MIPS_GIC_H__
582e2b4a Paul Burton 2017-08-12   17  
582e2b4a Paul Burton 2017-08-12   18  #include <linux/bitops.h>
582e2b4a Paul Burton 2017-08-12   19  
582e2b4a Paul Burton 2017-08-12   20  /* The base address of the GIC registers */
582e2b4a Paul Burton 2017-08-12   21  extern void __iomem *mips_gic_base;
582e2b4a Paul Burton 2017-08-12   22  
582e2b4a Paul Burton 2017-08-12   23  /* Offsets from the GIC base address to various control blocks */
582e2b4a Paul Burton 2017-08-12   24  #define MIPS_GIC_SHARED_OFS	0x00000
582e2b4a Paul Burton 2017-08-12   25  #define MIPS_GIC_SHARED_SZ	0x08000
582e2b4a Paul Burton 2017-08-12   26  #define MIPS_GIC_LOCAL_OFS	0x08000
582e2b4a Paul Burton 2017-08-12   27  #define MIPS_GIC_LOCAL_SZ	0x04000
582e2b4a Paul Burton 2017-08-12   28  #define MIPS_GIC_REDIR_OFS	0x0c000
582e2b4a Paul Burton 2017-08-12   29  #define MIPS_GIC_REDIR_SZ	0x04000
582e2b4a Paul Burton 2017-08-12   30  #define MIPS_GIC_USER_OFS	0x10000
582e2b4a Paul Burton 2017-08-12   31  #define MIPS_GIC_USER_SZ	0x10000
582e2b4a Paul Burton 2017-08-12   32  
582e2b4a Paul Burton 2017-08-12   33  /* For read-only shared registers */
582e2b4a Paul Burton 2017-08-12   34  #define GIC_ACCESSOR_RO(sz, off, name)					\
582e2b4a Paul Burton 2017-08-12   35  	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
582e2b4a Paul Burton 2017-08-12   36  
582e2b4a Paul Burton 2017-08-12   37  /* For read-write shared registers */
582e2b4a Paul Burton 2017-08-12   38  #define GIC_ACCESSOR_RW(sz, off, name)					\
582e2b4a Paul Burton 2017-08-12  @39  	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_SHARED_OFS + off, name)
582e2b4a Paul Burton 2017-08-12   40  
582e2b4a Paul Burton 2017-08-12   41  /* For read-only local registers */
582e2b4a Paul Burton 2017-08-12   42  #define GIC_VX_ACCESSOR_RO(sz, off, name)				\
582e2b4a Paul Burton 2017-08-12   43  	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
582e2b4a Paul Burton 2017-08-12   44  	CPS_ACCESSOR_RO(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
582e2b4a Paul Burton 2017-08-12   45  
582e2b4a Paul Burton 2017-08-12   46  /* For read-write local registers */
582e2b4a Paul Burton 2017-08-12   47  #define GIC_VX_ACCESSOR_RW(sz, off, name)				\
582e2b4a Paul Burton 2017-08-12  @48  	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_LOCAL_OFS + off, vl_##name)	\
582e2b4a Paul Burton 2017-08-12   49  	CPS_ACCESSOR_RW(gic, sz, MIPS_GIC_REDIR_OFS + off, vo_##name)
582e2b4a Paul Burton 2017-08-12   50  
582e2b4a Paul Burton 2017-08-12   51  /* For read-only shared per-interrupt registers */
582e2b4a Paul Burton 2017-08-12   52  #define GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
582e2b4a Paul Burton 2017-08-12   53  static inline void __iomem *addr_gic_##name(unsigned int intr)		\
582e2b4a Paul Burton 2017-08-12   54  {									\
582e2b4a Paul Burton 2017-08-12   55  	return mips_gic_base + (off) + (intr * (stride));		\
582e2b4a Paul Burton 2017-08-12   56  }									\
582e2b4a Paul Burton 2017-08-12   57  									\
582e2b4a Paul Burton 2017-08-12   58  static inline unsigned int read_gic_##name(unsigned int intr)		\
582e2b4a Paul Burton 2017-08-12   59  {									\
582e2b4a Paul Burton 2017-08-12   60  	BUILD_BUG_ON(sz != 32);						\
582e2b4a Paul Burton 2017-08-12  @61  	return __raw_readl(addr_gic_##name(intr));			\
582e2b4a Paul Burton 2017-08-12   62  }
582e2b4a Paul Burton 2017-08-12   63  
582e2b4a Paul Burton 2017-08-12   64  /* For read-write shared per-interrupt registers */
582e2b4a Paul Burton 2017-08-12   65  #define GIC_ACCESSOR_RW_INTR_REG(sz, off, stride, name)			\
582e2b4a Paul Burton 2017-08-12  @66  	GIC_ACCESSOR_RO_INTR_REG(sz, off, stride, name)			\
582e2b4a Paul Burton 2017-08-12   67  									\
582e2b4a Paul Burton 2017-08-12   68  static inline void write_gic_##name(unsigned int intr,			\
582e2b4a Paul Burton 2017-08-12   69  				    unsigned int val)			\
582e2b4a Paul Burton 2017-08-12   70  {									\
582e2b4a Paul Burton 2017-08-12   71  	BUILD_BUG_ON(sz != 32);						\
582e2b4a Paul Burton 2017-08-12  @72  	__raw_writel(val, addr_gic_##name(intr));			\
582e2b4a Paul Burton 2017-08-12   73  }
582e2b4a Paul Burton 2017-08-12   74  
582e2b4a Paul Burton 2017-08-12   75  /* For read-only local per-interrupt registers */
582e2b4a Paul Burton 2017-08-12   76  #define GIC_VX_ACCESSOR_RO_INTR_REG(sz, off, stride, name)		\
582e2b4a Paul Burton 2017-08-12   77  	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
582e2b4a Paul Burton 2017-08-12   78  				 stride, vl_##name)			\
582e2b4a Paul Burton 2017-08-12   79  	GIC_ACCESSOR_RO_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
582e2b4a Paul Burton 2017-08-12   80  				 stride, vo_##name)
582e2b4a Paul Burton 2017-08-12   81  
582e2b4a Paul Burton 2017-08-12   82  /* For read-write local per-interrupt registers */
582e2b4a Paul Burton 2017-08-12   83  #define GIC_VX_ACCESSOR_RW_INTR_REG(sz, off, stride, name)		\
582e2b4a Paul Burton 2017-08-12  @84  	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_LOCAL_OFS + off,		\
582e2b4a Paul Burton 2017-08-12   85  				 stride, vl_##name)			\
582e2b4a Paul Burton 2017-08-12   86  	GIC_ACCESSOR_RW_INTR_REG(sz, MIPS_GIC_REDIR_OFS + off,		\
582e2b4a Paul Burton 2017-08-12   87  				 stride, vo_##name)
582e2b4a Paul Burton 2017-08-12   88  
582e2b4a Paul Burton 2017-08-12   89  /* For read-only shared bit-per-interrupt registers */
582e2b4a Paul Burton 2017-08-12   90  #define GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
582e2b4a Paul Burton 2017-08-12   91  static inline void __iomem *addr_gic_##name(void)			\
582e2b4a Paul Burton 2017-08-12   92  {									\
582e2b4a Paul Burton 2017-08-12   93  	return mips_gic_base + (off);					\
582e2b4a Paul Burton 2017-08-12   94  }									\
582e2b4a Paul Burton 2017-08-12   95  									\
582e2b4a Paul Burton 2017-08-12   96  static inline unsigned int read_gic_##name(unsigned int intr)		\
582e2b4a Paul Burton 2017-08-12   97  {									\
582e2b4a Paul Burton 2017-08-12  @98  	void __iomem *addr = addr_gic_##name();				\
582e2b4a Paul Burton 2017-08-12   99  	unsigned int val;						\
582e2b4a Paul Burton 2017-08-12  100  									\
582e2b4a Paul Burton 2017-08-12 @101  	if (mips_cm_is64) {						\
582e2b4a Paul Burton 2017-08-12  102  		addr += (intr / 64) * sizeof(uint64_t);			\
582e2b4a Paul Burton 2017-08-12  103  		val = __raw_readq(addr) >> intr % 64;			\
582e2b4a Paul Burton 2017-08-12  104  	} else {							\
582e2b4a Paul Burton 2017-08-12  105  		addr += (intr / 32) * sizeof(uint32_t);			\
582e2b4a Paul Burton 2017-08-12  106  		val = __raw_readl(addr) >> intr % 32;			\
582e2b4a Paul Burton 2017-08-12  107  	}								\
582e2b4a Paul Burton 2017-08-12  108  									\
582e2b4a Paul Burton 2017-08-12  109  	return val & 0x1;						\
582e2b4a Paul Burton 2017-08-12  110  }
582e2b4a Paul Burton 2017-08-12  111  
582e2b4a Paul Burton 2017-08-12  112  /* For read-write shared bit-per-interrupt registers */
582e2b4a Paul Burton 2017-08-12  113  #define GIC_ACCESSOR_RW_INTR_BIT(off, name)				\
582e2b4a Paul Burton 2017-08-12 @114  	GIC_ACCESSOR_RO_INTR_BIT(off, name)				\
582e2b4a Paul Burton 2017-08-12  115  									\
582e2b4a Paul Burton 2017-08-12  116  static inline void write_gic_##name(unsigned int intr)			\
582e2b4a Paul Burton 2017-08-12  117  {									\
582e2b4a Paul Burton 2017-08-12  118  	void __iomem *addr = addr_gic_##name();				\
582e2b4a Paul Burton 2017-08-12  119  									\
582e2b4a Paul Burton 2017-08-12  120  	if (mips_cm_is64) {						\
582e2b4a Paul Burton 2017-08-12  121  		addr += (intr / 64) * sizeof(uint64_t);			\
582e2b4a Paul Burton 2017-08-12  122  		__raw_writeq(BIT(intr % 64), addr);			\
582e2b4a Paul Burton 2017-08-12  123  	} else {							\
582e2b4a Paul Burton 2017-08-12  124  		addr += (intr / 32) * sizeof(uint32_t);			\
582e2b4a Paul Burton 2017-08-12  125  		__raw_writel(BIT(intr % 32), addr);			\
582e2b4a Paul Burton 2017-08-12  126  	}								\
582e2b4a Paul Burton 2017-08-12  127  }									\
582e2b4a Paul Burton 2017-08-12  128  									\
582e2b4a Paul Burton 2017-08-12  129  static inline void change_gic_##name(unsigned int intr,			\
582e2b4a Paul Burton 2017-08-12  130  				     unsigned int val)			\
582e2b4a Paul Burton 2017-08-12  131  {									\
582e2b4a Paul Burton 2017-08-12  132  	void __iomem *addr = addr_gic_##name();				\
582e2b4a Paul Burton 2017-08-12  133  									\
582e2b4a Paul Burton 2017-08-12  134  	if (mips_cm_is64) {						\
582e2b4a Paul Burton 2017-08-12  135  		uint64_t _val;						\
582e2b4a Paul Burton 2017-08-12  136  									\
582e2b4a Paul Burton 2017-08-12  137  		addr += (intr / 64) * sizeof(uint64_t);			\
582e2b4a Paul Burton 2017-08-12  138  		_val = __raw_readq(addr);				\
582e2b4a Paul Burton 2017-08-12  139  		_val &= ~BIT_ULL(intr % 64);				\
582e2b4a Paul Burton 2017-08-12  140  		_val |= (uint64_t)val << (intr % 64);			\
582e2b4a Paul Burton 2017-08-12  141  		__raw_writeq(_val, addr);				\
582e2b4a Paul Burton 2017-08-12  142  	} else {							\
582e2b4a Paul Burton 2017-08-12  143  		uint32_t _val;						\
582e2b4a Paul Burton 2017-08-12  144  									\
582e2b4a Paul Burton 2017-08-12  145  		addr += (intr / 32) * sizeof(uint32_t);			\
582e2b4a Paul Burton 2017-08-12  146  		_val = __raw_readl(addr);				\
582e2b4a Paul Burton 2017-08-12  147  		_val &= ~BIT(intr % 32);				\
582e2b4a Paul Burton 2017-08-12  148  		_val |= val << (intr % 32);				\
582e2b4a Paul Burton 2017-08-12  149  		__raw_writel(_val, addr);				\
582e2b4a Paul Burton 2017-08-12  150  	}								\
582e2b4a Paul Burton 2017-08-12  151  }
582e2b4a Paul Burton 2017-08-12  152  
582e2b4a Paul Burton 2017-08-12  153  /* For read-only local bit-per-interrupt registers */
582e2b4a Paul Burton 2017-08-12  154  #define GIC_VX_ACCESSOR_RO_INTR_BIT(sz, off, name)			\
582e2b4a Paul Burton 2017-08-12  155  	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
582e2b4a Paul Burton 2017-08-12  156  				 vl_##name)				\
582e2b4a Paul Burton 2017-08-12  157  	GIC_ACCESSOR_RO_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
582e2b4a Paul Burton 2017-08-12  158  				 vo_##name)
582e2b4a Paul Burton 2017-08-12  159  
582e2b4a Paul Burton 2017-08-12  160  /* For read-write local bit-per-interrupt registers */
582e2b4a Paul Burton 2017-08-12  161  #define GIC_VX_ACCESSOR_RW_INTR_BIT(sz, off, name)			\
582e2b4a Paul Burton 2017-08-12  162  	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_LOCAL_OFS + off,		\
582e2b4a Paul Burton 2017-08-12  163  				 vl_##name)				\
582e2b4a Paul Burton 2017-08-12  164  	GIC_ACCESSOR_RW_INTR_BIT(sz, MIPS_GIC_REDIR_OFS + off,		\
582e2b4a Paul Burton 2017-08-12  165  				 vo_##name)
582e2b4a Paul Burton 2017-08-12  166  
582e2b4a Paul Burton 2017-08-12  167  /* GIC_SH_CONFIG - Information about the GIC configuration */
582e2b4a Paul Burton 2017-08-12 @168  GIC_ACCESSOR_RW(32, 0x000, config)
582e2b4a Paul Burton 2017-08-12  169  #define GIC_CONFIG_COUNTSTOP		BIT(28)
582e2b4a Paul Burton 2017-08-12  170  #define GIC_CONFIG_COUNTBITS		GENMASK(27, 24)
582e2b4a Paul Burton 2017-08-12  171  #define GIC_CONFIG_NUMINTERRUPTS	GENMASK(23, 16)
582e2b4a Paul Burton 2017-08-12  172  #define GIC_CONFIG_PVPS			GENMASK(6, 0)
582e2b4a Paul Burton 2017-08-12  173  
582e2b4a Paul Burton 2017-08-12  174  /* GIC_SH_COUNTER - Shared global counter value */
582e2b4a Paul Burton 2017-08-12  175  GIC_ACCESSOR_RW(64, 0x010, counter)
582e2b4a Paul Burton 2017-08-12  176  GIC_ACCESSOR_RW(32, 0x010, counter_32l)
582e2b4a Paul Burton 2017-08-12  177  GIC_ACCESSOR_RW(32, 0x014, counter_32h)
582e2b4a Paul Burton 2017-08-12  178  
582e2b4a Paul Burton 2017-08-12  179  /* GIC_SH_POL_* - Configures interrupt polarity */
582e2b4a Paul Burton 2017-08-12 @180  GIC_ACCESSOR_RW_INTR_BIT(0x100, pol)
582e2b4a Paul Burton 2017-08-12  181  #define GIC_POL_ACTIVE_LOW		0	/* when level triggered */
582e2b4a Paul Burton 2017-08-12  182  #define GIC_POL_ACTIVE_HIGH		1	/* when level triggered */
582e2b4a Paul Burton 2017-08-12  183  #define GIC_POL_FALLING_EDGE		0	/* when single-edge triggered */
582e2b4a Paul Burton 2017-08-12  184  #define GIC_POL_RISING_EDGE		1	/* when single-edge triggered */
582e2b4a Paul Burton 2017-08-12  185  
582e2b4a Paul Burton 2017-08-12  186  /* GIC_SH_TRIG_* - Configures interrupts to be edge or level triggered */
582e2b4a Paul Burton 2017-08-12  187  GIC_ACCESSOR_RW_INTR_BIT(0x180, trig)
582e2b4a Paul Burton 2017-08-12  188  #define GIC_TRIG_LEVEL			0
582e2b4a Paul Burton 2017-08-12  189  #define GIC_TRIG_EDGE			1
582e2b4a Paul Burton 2017-08-12  190  
582e2b4a Paul Burton 2017-08-12  191  /* GIC_SH_DUAL_* - Configures whether interrupts trigger on both edges */
582e2b4a Paul Burton 2017-08-12  192  GIC_ACCESSOR_RW_INTR_BIT(0x200, dual)
582e2b4a Paul Burton 2017-08-12  193  #define GIC_DUAL_SINGLE			0	/* when edge-triggered */
582e2b4a Paul Burton 2017-08-12  194  #define GIC_DUAL_DUAL			1	/* when edge-triggered */
582e2b4a Paul Burton 2017-08-12  195  
582e2b4a Paul Burton 2017-08-12  196  /* GIC_SH_WEDGE - Write an 'edge', ie. trigger an interrupt */
582e2b4a Paul Burton 2017-08-12 @197  GIC_ACCESSOR_RW(32, 0x280, wedge)
582e2b4a Paul Burton 2017-08-12  198  #define GIC_WEDGE_RW			BIT(31)
582e2b4a Paul Burton 2017-08-12  199  #define GIC_WEDGE_INTR			GENMASK(7, 0)
582e2b4a Paul Burton 2017-08-12  200  

:::::: The code at line 12 was first introduced by commit
:::::: 582e2b4aecdacc0a3bd39daa63648a88cad6a26f MIPS: GIC: Introduce asm/mips-gic.h with accessor functions

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--AqsLC8rIMeq19msA--
