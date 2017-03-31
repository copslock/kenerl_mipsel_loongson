Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 18:10:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53329 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbdCaQK1h45zo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 18:10:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DEDA2A53839EC;
        Fri, 31 Mar 2017 17:10:17 +0100 (IST)
Received: from LDT-J-COWGILL.le.imgtec.org (10.150.130.85) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 31 Mar 2017 17:10:21 +0100
From:   James Cowgill <James.Cowgill@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <James.Cowgill@imgtec.com>
Subject: [PATCH 0/2] Fix indirect syscall handler for syscalls with > 4 args
Date:   Fri, 31 Mar 2017 17:09:57 +0100
Message-ID: <20170331160959.3192-1-James.Cowgill@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

These two patches fix a corner case in the o32 indirect syscall handler where
incorrect arguments might get passed to the underlying syscall function if more
than 4 arguments are passed to a restartable syscall.

The first patch hopefully removes the last use of pt_regs for reading syscall
arguments and the second patch removes the special pt_regs handling in the
indrect syscall handler which is no longer needed.


James Cowgill (2):
  MIPS: opt into HAVE_COPY_THREAD_TLS
  MIPS: Remove pt_regs adjustments in indirect syscall handler

 arch/mips/Kconfig              |  1 +
 arch/mips/kernel/process.c     |  6 +++---
 arch/mips/kernel/scall32-o32.S | 11 -----------
 arch/mips/kernel/scall64-o32.S |  6 ------
 4 files changed, 4 insertions(+), 20 deletions(-)

-- 
2.11.0
