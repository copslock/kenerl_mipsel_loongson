Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 09:15:07 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:27864 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823062Ab2KMIPGXurIO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Nov 2012 09:15:06 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 13 Nov 2012 00:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,764,1344236400"; 
   d="scan'208";a="218808638"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2012 00:14:58 -0800
Received: from [192.168.1.1] (helo=bee)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYBds-000AdQ-Ti; Tue, 13 Nov 2012 16:14:44 +0800
Date:   Tue, 13 Nov 2012 16:14:44 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 7/16] arch/mips/kernel/traps.c:1822:6:
 warning: "cpu_data" is not defined
Message-ID: <50a20174.JL3AqbvMzr+q2Po9%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.1
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 34980
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
config: make ARCH=mips allyesconfig

All warnings:

arch/mips/kernel/traps.c: In function 'trap_init':
arch/mips/kernel/traps.c:1822:6: warning: "cpu_data" is not defined [-Wundef]
arch/mips/kernel/traps.c:1822:6: error: token "[" is not valid in preprocessor expressions
arch/mips/kernel/traps.c:1955:6: warning: "cpu_data" is not defined [-Wundef]
arch/mips/kernel/traps.c:1955:6: error: token "[" is not valid in preprocessor expressions

vim +1822 +/cpu_data arch/mips/kernel/traps.c

e01402b1 Ralf Baechle   2005-07-14  1806  	memcpy((void *)(uncached_ebase + offset), addr, size);
e01402b1 Ralf Baechle   2005-07-14  1807  }
e01402b1 Ralf Baechle   2005-07-14  1808  
5b10496b Atsushi Nemoto 2006-09-11  1809  static int __initdata rdhwr_noopt;
5b10496b Atsushi Nemoto 2006-09-11  1810  static int __init set_rdhwr_noopt(char *str)
5b10496b Atsushi Nemoto 2006-09-11  1811  {
5b10496b Atsushi Nemoto 2006-09-11  1812  	rdhwr_noopt = 1;
5b10496b Atsushi Nemoto 2006-09-11  1813  	return 1;
5b10496b Atsushi Nemoto 2006-09-11  1814  }
5b10496b Atsushi Nemoto 2006-09-11  1815  
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
c65a5480 Atsushi Nemoto 2007-11-12  1826  	int rollback;
c65a5480 Atsushi Nemoto 2007-11-12  1827  
c65a5480 Atsushi Nemoto 2007-11-12  1828  	check_wait();
c65a5480 Atsushi Nemoto 2007-11-12  1829  	rollback = (cpu_wait == r4k_wait);
^1da177e Linus Torvalds 2005-04-16  1830  

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
