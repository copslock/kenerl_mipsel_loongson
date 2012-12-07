Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 11:19:43 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:35839 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817667Ab2LGKTlF-G6S (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Dec 2012 11:19:41 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 07 Dec 2012 02:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,236,1355126400"; 
   d="scan'208";a="260408354"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2012 02:19:32 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1Tgv17-0002rQ-8X; Fri, 07 Dec 2012 18:18:49 +0800
Date:   Fri, 07 Dec 2012 18:20:37 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 31/35] dma-default.c:(.text+0xb958):
 undefined reference to `hw_coherentio'
Message-ID: <50c1c2f5.TyQEXFiN4QI5UfpT%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 35244
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
head:   76965291af22d5e06b8ffff677cfe2b227a9487a
commit: 5e8848b05d0c0a6854c7de9f55122ccf2f47a248 [31/35] MIPS: Add option to disable software I/O coherency.
config: make ARCH=mips allnoconfig

All error/warnings:

arch/mips/built-in.o: In function `mips_dma_map_sg':
dma-default.c:(.text+0xb310): undefined reference to `coherentio'
dma-default.c:(.text+0xb360): undefined reference to `coherentio'
arch/mips/built-in.o: In function `mips_dma_map_page':
dma-default.c:(.text+0xb430): undefined reference to `coherentio'
dma-default.c:(.text+0xb434): undefined reference to `coherentio'
arch/mips/built-in.o: In function `mips_dma_unmap_sg':
dma-default.c:(.text+0xb58c): undefined reference to `coherentio'
arch/mips/built-in.o:dma-default.c:(.text+0xb5bc): more undefined references to `coherentio' follow
arch/mips/built-in.o: In function `mips_dma_free_coherent':
dma-default.c:(.text+0xb958): undefined reference to `hw_coherentio'
dma-default.c:(.text+0xb95c): undefined reference to `hw_coherentio'
arch/mips/built-in.o: In function `mips_dma_alloc_coherent':
dma-default.c:(.text+0xbae8): undefined reference to `coherentio'
dma-default.c:(.text+0xbaec): undefined reference to `coherentio'
dma-default.c:(.text+0xbb3c): undefined reference to `hw_coherentio'
dma-default.c:(.text+0xbb40): undefined reference to `hw_coherentio'
arch/mips/built-in.o: In function `mips_dma_unmap_page':
dma-default.c:(.text+0xbb6c): undefined reference to `coherentio'
dma-default.c:(.text+0xbb70): undefined reference to `coherentio'
arch/mips/built-in.o: In function `mips_dma_sync_single_for_cpu':
dma-default.c:(.text+0xbbf8): undefined reference to `coherentio'
dma-default.c:(.text+0xbbfc): undefined reference to `coherentio'
arch/mips/built-in.o: In function `mips_dma_sync_single_for_device':
dma-default.c:(.text+0xbc84): undefined reference to `coherentio'
arch/mips/built-in.o:dma-default.c:(.text+0xbc88): more undefined references to `coherentio' follow

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
