Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 19:46:49 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16972 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991894AbcKYSqlT0sTI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2016 19:46:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3E6EE7C6CCFC2;
        Fri, 25 Nov 2016 18:46:31 +0000 (GMT)
Received: from localhost (10.100.200.171) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 25 Nov
 2016 18:46:35 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/3] MIPS: A few DMA & caching fixes
Date:   Fri, 25 Nov 2016 18:46:08 +0000
Message-ID: <20161125184611.28396-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.171]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55892
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

This series fixes a few issues with caching around DMA operations.
Please see individual commit messages for further details &
descriptions.

The series applies atop v4.9-rc6.


Paul Burton (3):
  MIPS: WARN_ON invalid DMA cache maintenance, not BUG_ON
  MIPS: Don't writeback when cache-invalidating DMA buffers
  MIPS: Sanitise DMA unmapping cache sync operations

 arch/mips/mm/c-r4k.c       | 13 +++++++++++--
 arch/mips/mm/dma-default.c |  4 ++--
 arch/mips/mm/sc-mips.c     | 36 ++++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.10.2
