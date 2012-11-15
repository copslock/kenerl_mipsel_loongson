Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 08:04:13 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:52281 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817207Ab2KOHEMDKraJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Nov 2012 08:04:12 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 14 Nov 2012 23:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,254,1352102400"; 
   d="scan'208";a="168626726"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by AZSMGA002.ch.intel.com with ESMTP; 14 Nov 2012 23:04:03 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYtUJ-000A8k-ME; Thu, 15 Nov 2012 15:03:47 +0800
Date:   Thu, 15 Nov 2012 15:04:23 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, Leonid Yegoshin <yegoshin@mips.com>
Subject: [mips-sjhill:mti-next 11/21] arch/mips/math-emu/dsemul.c:104:10:
 error: 'MM_BRK_MEMU' undeclared
Message-ID: <50a493f7.nAXwnLkTR+G8x/Md%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 35006
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
Return-Path: <linux-mips-bounce@linux-mips.org>

tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill mti-next
head:   e96eec97d092418a7b156d7fab0c3f03860031ba
commit: 163e455bd1925e50225d81d190771119c8593014 [11/21] MIPS: Support microMIPS/MIPS16e floating point.
config: make ARCH=mips allmodconfig

All error/warnings:

arch/mips/math-emu/dsemul.c: In function 'mips_dsemul':
arch/mips/math-emu/dsemul.c:104:10: error: 'MM_BRK_MEMU' undeclared (first use in this function)
arch/mips/math-emu/dsemul.c:104:10: note: each undeclared identifier is reported only once for each function it appears in
arch/mips/math-emu/dsemul.c: In function 'do_dsemulret':
arch/mips/math-emu/dsemul.c:137:16: error: 'MM_BRK_MEMU' undeclared (first use in this function)

vim +104 +/MM_BRK_MEMU arch/mips/math-emu/dsemul.c

^1da177e Linus Torvalds 2005-04-16   98  	if (unlikely(!access_ok(VERIFY_WRITE, fr, sizeof(struct emuframe))))
^1da177e Linus Torvalds 2005-04-16   99  		return SIGBUS;
^1da177e Linus Torvalds 2005-04-16  100  
163e455b Steven J. Hill 2012-05-24  101  	if (regs->cp0_epc & 1) {
163e455b Steven J. Hill 2012-05-24  102  		err = __put_user(ir >> 16, (u16 __user *)(&fr->emul));
163e455b Steven J. Hill 2012-05-24  103  		err |= __put_user(ir & 0xffff, (u16 __user *)((long)(&fr->emul) + 2));
163e455b Steven J. Hill 2012-05-24 @104  		err |= __put_user(MM_BREAK_MATH >> 16, (u16 __user *)(&fr->badinst));
163e455b Steven J. Hill 2012-05-24  105  		err |= __put_user(MM_BREAK_MATH & 0xffff, (u16 __user *)((long)(&fr->badinst) + 2));
163e455b Steven J. Hill 2012-05-24  106  	} else {
163e455b Steven J. Hill 2012-05-24  107  		err = __put_user(ir, &fr->emul);

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
