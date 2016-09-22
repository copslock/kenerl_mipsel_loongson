Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 15:38:55 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:49058 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992172AbcIVNisrWJwr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 15:38:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 28E18EC1214E8;
        Thu, 22 Sep 2016 14:38:38 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 22 Sep 2016 14:38:41 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 0/3] MIPS uprobe fixes
Date:   Thu, 22 Sep 2016 15:38:30 +0200
Message-ID: <1474551513-30647-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

This patch set fixes a few issues with uprobe support on MIPS:
1) uretprobe support
2) probe removal
3) branch instruction emulation

With these changes I believe all of uprobe tracing for MIPSr2 works properly.
There are outstanding issues with uprobe tracing for MIPSr6 if a probe is placed
over compact branch instructions (as these are not currently emulated properly).

Marcin Nowakowski (3):
  MIPS: fix uretprobe implementation
  MIPS: uprobes: remove incorrect set_orig_insn
  MIPS: uprobes: fix use of uninitialised variable

 arch/mips/include/asm/uprobes.h |  1 -
 arch/mips/kernel/uprobes.c      | 25 +++----------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

-- 
2.7.4
