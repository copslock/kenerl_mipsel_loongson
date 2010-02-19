Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2010 01:14:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9515 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492155Ab0BSANx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2010 01:13:53 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7dd7c70002>; Thu, 18 Feb 2010 16:13:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 18 Feb 2010 16:13:28 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.2) with ESMTP id o1J0DPbJ029135;
        Thu, 18 Feb 2010 16:13:25 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o1J0DOj0029134;
        Thu, 18 Feb 2010 16:13:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] MIPS vdso and signal delivery optimization (v2)
Date:   Thu, 18 Feb 2010 16:13:02 -0800
Message-Id: <1266538385-29088-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6
X-OriginalArrivalTime: 19 Feb 2010 00:13:28.0838 (UTC) FILETIME=[5CC6A260:01CAB0F8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set creates a vdso and moves the signal
trampolines to it from their previous home on the stack.

In the original patch set:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=49EE3B0F.3040506%40caviumnetworks.com

I stated:

Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
following results from lmbench2:

Before:
n64 - Signal handler overhead: 14.517 microseconds
n32 - Signal handler overhead: 14.497 microseconds
o32 - Signal handler overhead: 16.637 microseconds

After:

n64 - Signal handler overhead: 7.935 microseconds
n32 - Signal handler overhead: 7.334 microseconds
o32 - Signal handler overhead: 8.628 microsecond

All that is still true.

Improvements from the first version:

* Compiles and runs in 32-bit kernels (on qemu at least).

* Updated for linux-queue based 2.6.33-rc8

David Daney (3):
  MIPS: Add SYSCALL to uasm.
  MIPS: Preliminary vdso.
  MIPS: Move signal trampolines off of the stack.

 arch/mips/include/asm/abi.h         |    6 +-
 arch/mips/include/asm/elf.h         |    4 +
 arch/mips/include/asm/mmu.h         |    5 +-
 arch/mips/include/asm/mmu_context.h |    2 +-
 arch/mips/include/asm/processor.h   |   11 +++-
 arch/mips/include/asm/uasm.h        |    1 +
 arch/mips/include/asm/vdso.h        |   29 +++++++++
 arch/mips/kernel/Makefile           |    2 +-
 arch/mips/kernel/signal-common.h    |    5 --
 arch/mips/kernel/signal.c           |   86 ++++++---------------------
 arch/mips/kernel/signal32.c         |   55 ++++-------------
 arch/mips/kernel/signal_n32.c       |   26 ++------
 arch/mips/kernel/syscall.c          |    6 ++-
 arch/mips/kernel/vdso.c             |  112 +++++++++++++++++++++++++++++++++++
 arch/mips/mm/uasm.c                 |   19 +++++-
 15 files changed, 226 insertions(+), 143 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso.h
 create mode 100644 arch/mips/kernel/vdso.c
