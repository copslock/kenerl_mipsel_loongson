Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:19:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53979 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008292AbcCAWT6AFR0- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:19:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 0605B51D855B;
        Tue,  1 Mar 2016 22:19:48 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:51 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:51 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] MIPS: Watchpoint fixes and cleanups
Date:   Tue, 1 Mar 2016 22:19:35 +0000
Message-ID: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Patch 1 fixes watchpoint breakage since v4.3.

Patch 2 enables watchpoints in R6 kernels, where they are inadvertently
disabled.

Patches 3 and 4 are cosmetic cleanups, to replace magic numbers with
preprocessor definitions.

James Hogan (4):
  MIPS: Fix watchpoint restoration
  MIPS: Enable ptrace hw watchpoints on MIPS R6
  MIPS: Add and use CAUSEF_WP definition
  MIPS: Add and use watch register field definitions

 arch/mips/Kconfig                 |  2 +-
 arch/mips/include/asm/mipsregs.h  | 20 ++++++++++
 arch/mips/include/asm/switch_to.h |  2 +-
 arch/mips/include/asm/watch.h     | 10 ++---
 arch/mips/kernel/pm.c             |  2 +-
 arch/mips/kernel/ptrace.c         |  7 ++--
 arch/mips/kernel/traps.c          |  5 +--
 arch/mips/kernel/watch.c          | 79 +++++++++++++++++++++------------------
 8 files changed, 76 insertions(+), 51 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
-- 
2.4.10
