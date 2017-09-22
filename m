Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 08:45:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42309 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991163AbdIVGpRB3wBc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 08:45:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4A4F0EF2F6BE3
        for <linux-mips@linux-mips.org>; Fri, 22 Sep 2017 07:45:08 +0100 (IST)
Received: from localhost (10.20.79.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 22 Sep
 2017 07:45:09 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 0/4] MIPS: Prevent users killing the kernel or spamming its log
Date:   Thu, 21 Sep 2017 23:44:43 -0700
Message-ID: <20170922064447.28728-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.79.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60105
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

This series fixes up an issue discovered running crashme - user code can
cause the kernel to die() by performing unaligned accesses to the GIC
user page. The first patch fixes this by allowing the kernel to recover
from bus errors resulting from bad accesses to the GIC user page (or
anywhere else we expect might fault). The remaining 3 patches silence
kernel log output from such bus errors in cases where they are somewhat
expected.

It'd be great to get these into v4.14, but especially patch 1 in order
to prevent users killing the kernel.

Thanks,
    Paul

Paul Burton (4):
  MIPS: Search main exception table for data bus errors
  MIPS: Don't dump CM error state for fixed up bus errors
  MIPS: Allow bus error handlers to request quiet behaviour
  MIPS: Silence kernel log output for GIC user page bus errors

 arch/mips/include/asm/mips-cm.h | 11 ++++++++---
 arch/mips/include/asm/traps.h   |  1 +
 arch/mips/kernel/mips-cm.c      | 39 ++++++++++++++++++++++++++++++++++-----
 arch/mips/kernel/traps.c        | 15 +++++++++------
 4 files changed, 52 insertions(+), 14 deletions(-)

-- 
2.14.1
