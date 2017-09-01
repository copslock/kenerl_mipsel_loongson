Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2017 04:57:03 +0200 (CEST)
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18543 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992079AbdIAC44doAFU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2017 04:56:56 +0200
X-IronPort-AV: E=Sophos;i="5.41,456,1498492800"; 
   d="scan'208";a="25090026"
Received: from localhost (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Sep 2017 10:56:43 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id EFBD14724E61;
        Fri,  1 Sep 2017 10:56:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.167.226.106) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.319.2; Fri, 1 Sep 2017 10:56:44 +0800
From:   Dou Liyang <douly.fnst@cn.fujitsu.com>
To:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-ia64@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        <linux-s390@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>
Subject: [PATCH v2 0/7] Remove the parent_node() for each arch
Date:   Fri, 1 Sep 2017 10:56:32 +0800
Message-ID: <1504234599-29533-1-git-send-email-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.5.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: EFBD14724E61.A1DA6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Return-Path: <douly.fnst@cn.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: douly.fnst@cn.fujitsu.com
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

Changelog:

v1 --> v2:
   --Remove the patches which have been add to each arch tree individually.
      [01/11] arm64   ...Has been added to arm64 tree, Queued for 4.14
      [03/11] metag   ...Has been added to the -mm tree
      [05/11] powerpc ...Has been added to the powerpc tree
      [10/11] x86     ...Has been added to the tip sched/core

   --Rebase the remaining patches and repost.

Michael reports the parent_node() will never be invoked since the
Commit a7be6e5a7f8d ("mm: drop useless local parameters of
__register_one_node()") removes the last user of it. 

So we start removing it from the topology.h headers for each arch.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org

Dou Liyang (7):
  ia64: topology: Remove the unused parent_node() macro
  MIPS: numa: Remove the unused parent_node() macro
  s390/topology: Remove the unused parent_node() macro
  sh/numa: Remove the unused parent_node() macro
  sparc64/topology: Remove the unused parent_node() macro
  tile/topology: Remove the unused parent_node() macro
  asm-generic: numa: Remove the unused parent_node() macro

 arch/ia64/include/asm/topology.h                 | 7 -------
 arch/mips/include/asm/mach-ip27/topology.h       | 1 -
 arch/mips/include/asm/mach-loongson64/topology.h | 1 -
 arch/s390/include/asm/topology.h                 | 6 ------
 arch/sh/include/asm/topology.h                   | 1 -
 arch/sparc/include/asm/topology_64.h             | 2 --
 arch/tile/include/asm/topology.h                 | 6 ------
 include/asm-generic/topology.h                   | 3 ---
 8 files changed, 27 deletions(-)

-- 
2.5.5
