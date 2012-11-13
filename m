Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 09:42:16 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:7840 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822664Ab2KMImP0X00B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Nov 2012 09:42:15 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 13 Nov 2012 00:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,764,1344236400"; 
   d="scan'208";a="241218694"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2012 00:42:07 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYC49-000MjJ-ML; Tue, 13 Nov 2012 16:41:53 +0800
Date:   Tue, 13 Nov 2012 16:42:23 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 error: token "[" is not valid in preprocessor expressions
Message-ID: <50a207ef.gpSoNhAZ8NXm7FDK%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 34981
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
head:   bfba8d5f0844a1358022c8f8367a4f792335a94f
commit: e9ebe292b8b9df20a1f601e1dc4c85d31689359a [7/16] MIPS: Add support for microMIPS exception handling.
config: make ARCH=mips allmodconfig

All error/warnings:

arch/mips/kernel/traps.c: In function 'trap_init':
arch/mips/kernel/traps.c:1822:6: warning: "cpu_data" is not defined [-Wundef]
arch/mips/kernel/traps.c:1822:6: error: token "[" is not valid in preprocessor expressions
arch/mips/kernel/traps.c:1955:6: warning: "cpu_data" is not defined [-Wundef]
arch/mips/kernel/traps.c:1955:6: error: token "[" is not valid in preprocessor expressions

vim +1822 arch/mips/kernel/traps.c

5b10496b Atsushi Nemoto 2006-09-11  1816  __setup("rdhwr_noopt", set_rdhwr_noopt);
5b10496b Atsushi Nemoto 2006-09-11  1817  
^1da177e Linus Torvalds 2005-04-16  1818  void __init trap_init(void)
^1da177e Linus Torvalds 2005-04-16  1819  {
e9ebe292 Steven J. Hill 2012-07-19  1820  	extern char except_vec3_generic;
^1da177e Linus Torvalds 2005-04-16  1821  	extern char except_vec4;
e9ebe292 Steven J. Hill 2012-07-19 @1822  #if (cpu_has_vce != 0)
e9ebe292 Steven J. Hill 2012-07-19  1823  	extern char except_vec3_r4000;
e9ebe292 Steven J. Hill 2012-07-19  1824  #endif
^1da177e Linus Torvalds 2005-04-16  1825  	unsigned long i;

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
