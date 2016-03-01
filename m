Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 03:38:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58872 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011399AbcCACi3XqtE- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 03:38:29 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D2ADB4664902D;
        Tue,  1 Mar 2016 02:38:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 02:38:23 +0000
Received: from localhost (10.100.200.88) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 1 Mar
 2016 02:38:22 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Lars Persson <lars.persson@axis.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "Huacai Chen" <chenhc@lemote.com>,
        David Daney <david.daney@cavium.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/4] MIPS cache & highmem fixes
Date:   Tue, 1 Mar 2016 02:37:55 +0000
Message-ID: <1456799879-14711-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This series fixes up a few issues with our current cache maintenance
code, some specific to highmem & some not. It fixes an issue with icache
corruption seen on the pistachio SoC & Ci40, and icache corruption seen
using highmem on MIPS Malta boards with a P5600 CPU.

Applies atop v4.5-rc6. It would be great to squeeze these in for v4.5,
but I recognise it's quite late in the cycle & this brokenness has been
around for a while so won't object to v4.6.

Thanks,
    Paul

Paul Burton (4):
  MIPS: Flush dcache for flush_kernel_dcache_page
  MIPS: Flush highmem pages in __flush_dcache_page
  MIPS: Handle highmem pages in __update_cache
  MIPS: Sync icache & dcache in set_pte_at

 arch/mips/include/asm/cacheflush.h |  7 +------
 arch/mips/include/asm/pgtable.h    | 26 +++++++++++++++++++-----
 arch/mips/mm/cache.c               | 41 +++++++++++++++++++-------------------
 3 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.7.1
