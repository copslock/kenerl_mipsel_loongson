Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2010 19:12:17 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:35679 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492067Ab0FORMO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jun 2010 19:12:14 +0200
Received: by wwb17 with SMTP id 17so1453605wwb.36
        for <multiple recipients>; Tue, 15 Jun 2010 10:12:06 -0700 (PDT)
Received: by 10.216.85.194 with SMTP id u44mr3979175wee.10.1276621925872;
        Tue, 15 Jun 2010 10:12:05 -0700 (PDT)
Received: from localhost.localdomain ([122.171.5.172])
        by mx.google.com with ESMTPS id n50sm1710803weq.33.2010.06.15.10.12.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 10:12:05 -0700 (PDT)
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
To:     linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        ddaney@caviumnetworks.com
Subject: [PATCH 0/2] MIPS: Kprobes and Kretprobes Support
Date:   Tue, 15 Jun 2010 20:12:47 +0530
Message-Id: <1276612969-13508-1-git-send-email-hschauhan@nulltrace.org>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 27136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10484

This is a set of 2 patches for adding support of kprobes
and kretprobes support on MIPS architecture. All my tests
are done on Qemu's MALTA board. If somebody has _real_ MIPS
machine, I would appreciate a try on the machine.

Signed-off-by: Himanshu Chauhan <hschauhan@nulltrace.org>

---
Himanshu Chauhan (2):
  MIPS: KProbes Support
  MIPS: Kretprobe support

 arch/mips/Kconfig               |   14 ++
 arch/mips/include/asm/break.h   |    2 +
 arch/mips/include/asm/kdebug.h  |    5 +
 arch/mips/include/asm/kprobes.h |   86 +++++++
 arch/mips/kernel/Makefile       |    2 +
 arch/mips/kernel/kprobes.c      |  493 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c        |   43 ++++-
 arch/mips/mm/fault.c            |   12 +-
 8 files changed, 654 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/kprobes.h
 create mode 100644 arch/mips/kernel/kprobes.c
