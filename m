Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 08:10:25 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:48254 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817207Ab2KOHKYmIw70 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Nov 2012 08:10:24 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 14 Nov 2012 23:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,254,1352102400"; 
   d="scan'208";a="218070347"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by azsmga001.ch.intel.com with ESMTP; 14 Nov 2012 23:10:16 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYtaK-000CHH-KK; Thu, 15 Nov 2012 15:10:00 +0800
Date:   Thu, 15 Nov 2012 15:10:36 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 12/21] arch/mips/kernel/traps.c:822:7:
 error: 'MM_BRK_MEMU' undeclared
Message-ID: <50a4956c.cUz8oGSCpnjIVqP4%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 35007
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
commit: a32041f908d5313323c6c8c8f06be9296a69038f [12/21] MIPS: Add support for microMIPS exception handling.
config: make ARCH=mips allmodconfig

All error/warnings:

arch/mips/kernel/traps.c: In function 'do_trap_or_bp':
arch/mips/kernel/traps.c:822:7: error: 'MM_BRK_MEMU' undeclared (first use in this function)
arch/mips/kernel/traps.c:822:7: note: each undeclared identifier is reported only once for each function it appears in

vim +822 +/MM_BRK_MEMU arch/mips/kernel/traps.c

^1da177e Linus Torvalds 2005-04-16  816  		force_sig_info(SIGFPE, &info, current);
^1da177e Linus Torvalds 2005-04-16  817  		break;
63dc68a8 Ralf Baechle   2006-10-16  818  	case BRK_BUG:
df270051 Ralf Baechle   2008-04-20  819  		die_if_kernel("Kernel bug detected", regs);
df270051 Ralf Baechle   2008-04-20  820  		force_sig(SIGTRAP, current);
63dc68a8 Ralf Baechle   2006-10-16  821  		break;
a32041f9 Steven J. Hill 2012-07-19 @822  	case MM_BRK_MEMU:
ba3049ed Ralf Baechle   2008-10-28  823  	case BRK_MEMU:
ba3049ed Ralf Baechle   2008-10-28  824  		/*
ba3049ed Ralf Baechle   2008-10-28  825  		 * Address errors may be deliberately induced by the FPU

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
