Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 14:16:12 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:39653 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007388AbbBZNQKt-aXo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 14:16:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id B6BFF18126;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id I1WtyMwRwGav; Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 1ABF618128;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 01C3B1169;
        Thu, 26 Feb 2015 14:16:05 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by boulder.se.axis.com (Postfix) with ESMTP id E6F4EFBA;
        Thu, 26 Feb 2015 14:16:04 +0100 (CET)
Received: from lnxlarper.se.axis.com (lnxlarper.se.axis.com [10.88.41.1])
        by thoth.se.axis.com (Postfix) with ESMTP id E46173432B;
        Thu, 26 Feb 2015 14:16:04 +0100 (CET)
Received: by lnxlarper.se.axis.com (Postfix, from userid 20456)
        id DE693801D2; Thu, 26 Feb 2015 14:16:04 +0100 (CET)
From:   Lars Persson <lars.persson@axis.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        paul.burton@imgtec.com
Cc:     linux-kernel@vger.kernel.org, Lars Persson <larper@axis.com>
Subject: [PATCH 0/2] New fix for icache coherency race
Date:   Thu, 26 Feb 2015 14:16:01 +0100
Message-Id: <1424956563-29535-1-git-send-email-larper@axis.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

This patch set proposes an improved fix for the race condition that
originally was fixed in commit 2a4a8b1e5d9d ("MIPS: Remove race window
in page fault handling").

I have used the flush_icache_page API that is marked as deprecated in
Documentation/cachetlb.txt. There are strong reasons to keep this API
because it is not possible to implement an efficient and race-free
lazy flushing using the other APIs.

You can refer to a discussion about the same issue in arch/arm where
they chose to implement the solution in set_pte_at. In arch/mips we
could not do this because we lack information about the executability
of the mapping in set_pte_at() and thus we would have to flush all
pages to be safe.

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/030915.html

Lars Persson (2):
  Revert "MIPS: Remove race window in page fault handling"
  MIPS: Fix race condition in lazy cache flushing.

 arch/mips/include/asm/cacheflush.h |   35 ++++++++++++++++++++---------------
 arch/mips/include/asm/pgtable.h    |   10 ++++++----
 arch/mips/mm/cache.c               |   27 ++++++++-------------------
 3 files changed, 34 insertions(+), 38 deletions(-)

-- 
1.7.10.4
