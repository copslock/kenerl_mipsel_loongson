Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 14:51:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37972 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011605AbcBANvFk8Tio (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 14:51:05 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id DAAA199BBFBCA;
        Mon,  1 Feb 2016 13:50:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Mon, 1 Feb 2016 13:50:59 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 1 Feb 2016 13:50:58 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: [PATCH 0/2] MIPS: Fix FPU preemption issues
Date:   Mon, 1 Feb 2016 13:50:35 +0000
Message-ID: <1454334637-3860-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51585
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

These patches aim to prevent the FPU being left enabled across a task
context switch due to full kernel preemption. This could result in
returning to a KVM guest with FPU enabled.

Patch 1 fixes a more theoretical case that I spotted where TIF_USEDFPU
is cleared without disabling the FPU in the execve path.

Patch 2 fixes a much easier to hit case (multiple WARNs before reaching
login prompt if only the WARN part of patch is applied) due to saved
Status in interrupt context not being updated when FPU is disabled. In
doing so it also allows an orphaned enabled FPU to remain enabled
through to user mode, hence the new WARN on context switch to catch
future cases of it.

James Hogan (2):
  MIPS: Properly disable FPU in start_thread()
  MIPS: Fix FPU disable with preemption

 arch/mips/include/asm/fpu.h        | 4 ++++
 arch/mips/include/asm/stackframe.h | 4 ++--
 arch/mips/kernel/process.c         | 6 ++----
 3 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.4.10
