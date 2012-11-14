Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 18:23:57 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:63971 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825655Ab2KNRX4VoL8N (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2012 18:23:56 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
  by azsmga101.ch.intel.com with ESMTP; 14 Nov 2012 09:23:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,252,1352102400"; 
   d="scan'208";a="168341180"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by AZSMGA002.ch.intel.com with ESMTP; 14 Nov 2012 09:23:47 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYggV-000Lc4-Q6; Thu, 15 Nov 2012 01:23:31 +0800
Date:   Thu, 15 Nov 2012 01:24:06 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 7/16] (.init.text+0x1f28): undefined
 reference to `except_vec3_r4000'
Message-ID: <50a3d3b6.IOHCoq2CXkkWxneU%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 35004
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
head:   ee9f3f81f9862ff37e0e98e1539d084a34c8445b
commit: 033dc27ea782e36d34102f13e26ed7f27ce1aa3d [7/16] MIPS: Add support for microMIPS exception handling.
config: make ARCH=mips allnoconfig

All error/warnings:

arch/mips/built-in.o: In function `trap_init':
(.init.text+0x1f28): undefined reference to `except_vec3_r4000'
arch/mips/built-in.o: In function `trap_init':
(.init.text+0x1f2c): undefined reference to `except_vec3_r4000'

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
