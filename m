Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2011 02:36:32 +0200 (CEST)
Received: from gandharva.secretlabs.de ([78.46.147.237]:14569 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491867Ab1HKAg3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2011 02:36:29 +0200
Received: from localhost.localdomain (unknown [1.202.86.226])
        by gandharva.secretlabs.de (Postfix) with ESMTPSA id 17E5A1B10C11;
        Thu, 11 Aug 2011 00:47:26 +0000 (UTC)
From:   Holger Hans Peter Freyther <zecke@selfish.org>
To:     linux-mips@linux-mips.org
Cc:     Holger Hans Peter Freyther <zecke@selfish.org>
Subject: [PATCH 0/2] Implement perf_callchain_user
Date:   Thu, 11 Aug 2011 02:36:04 +0200
Message-Id: <1313022966-28152-1-git-send-email-zecke@selfish.org>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 30848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zecke@selfish.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8019

Hi,
this is moving code from oprofile/backtrace.c to a commom
place and then implements perf_callchain_user using the common
code. Right now the unwind_user_frame will always be compiled
into the kernel.


Holger Hans Peter Freyther (2):
  MIPS: Move userspace stack unwinding into kernel/user_backtrace.c
  MIPS: Implement perf_callchain_user using unwind_user_frame

 arch/mips/include/asm/stacktrace.h |   10 +++
 arch/mips/kernel/Makefile          |    3 +-
 arch/mips/kernel/perf_event.c      |   14 ++++
 arch/mips/kernel/user_backtrace.c  |  129 ++++++++++++++++++++++++++++++++++
 arch/mips/oprofile/backtrace.c     |  133 ++----------------------------------
 5 files changed, 160 insertions(+), 129 deletions(-)
 create mode 100644 arch/mips/kernel/user_backtrace.c

-- 
1.7.4.1
