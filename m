Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 07:19:44 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:62617 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821191AbaDIFTlwdMeY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Apr 2014 07:19:41 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 22:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,823,1389772800"; 
   d="scan'208";a="517340896"
Received: from unknown (HELO wfg-t420.sh.intel.com) ([10.239.13.119])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2014 22:19:29 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
        (envelope-from <fengguang.wu@intel.com>)
        id 1WXkv3-0007ed-A1; Wed, 09 Apr 2014 13:19:29 +0800
Date:   Wed, 9 Apr 2014 13:19:29 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Michal Marek <mmarek@suse.cz>
Cc:     kbuild-all@01.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140409051929.GA29246@localhost>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39733
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04535d273ee3edacd9551b2512b4e939ba20277f
commit: e4d6152b520184be87aa65cb7035bf87acd27c14 Merge branch 'kconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild-2.6
date:   3 years, 8 months ago
config: make ARCH=mips ip28_defconfig

All error/warnings:

>> arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.
   make: *** [sub-make] Error 2

vim +29 arch/mips/sgi-ip22/Platform

b9dbdce1 Ralf Baechle 2010-08-05  13  load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
b9dbdce1 Ralf Baechle 2010-08-05  14  endif
b9dbdce1 Ralf Baechle 2010-08-05  15  ifdef CONFIG_64BIT
b9dbdce1 Ralf Baechle 2010-08-05  16  load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
b9dbdce1 Ralf Baechle 2010-08-05  17  endif
b9dbdce1 Ralf Baechle 2010-08-05  18  
b9dbdce1 Ralf Baechle 2010-08-05  19  #
b9dbdce1 Ralf Baechle 2010-08-05  20  # SGI IP28 (Indigo2 R10k)
b9dbdce1 Ralf Baechle 2010-08-05  21  #
b9dbdce1 Ralf Baechle 2010-08-05  22  # Set the load address to >= 0xa800000020080000 if you want to leave space for
b9dbdce1 Ralf Baechle 2010-08-05  23  # symmon, 0xa800000020004000 for production kernels ?  Note that the value must
b9dbdce1 Ralf Baechle 2010-08-05  24  # be 16kb aligned or the handling of the current variable will break.
b9dbdce1 Ralf Baechle 2010-08-05  25  # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
b9dbdce1 Ralf Baechle 2010-08-05  26  #
b9dbdce1 Ralf Baechle 2010-08-05  27  ifdef CONFIG_SGI_IP28
b9dbdce1 Ralf Baechle 2010-08-05  28    ifeq ($(call cc-option-yn,-mr10k-cache-barrier=store), n)
b9dbdce1 Ralf Baechle 2010-08-05 @29        $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
b9dbdce1 Ralf Baechle 2010-08-05  30    endif
b9dbdce1 Ralf Baechle 2010-08-05  31  endif
b9dbdce1 Ralf Baechle 2010-08-05  32  platform-$(CONFIG_SGI_IP28)		+= sgi-ip22/
b9dbdce1 Ralf Baechle 2010-08-05  33  cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
b9dbdce1 Ralf Baechle 2010-08-05  34  load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000



---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
