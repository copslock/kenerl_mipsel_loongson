Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2010 20:31:16 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:41342 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491930Ab0FGSbN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jun 2010 20:31:13 +0200
Received: by pvg11 with SMTP id 11so1202448pvg.36
        for <multiple recipients>; Mon, 07 Jun 2010 11:31:02 -0700 (PDT)
Received: by 10.142.195.20 with SMTP id s20mr10990049wff.248.1275935462335;
        Mon, 07 Jun 2010 11:31:02 -0700 (PDT)
Received: from localhost.localdomain ([122.167.126.7])
        by mx.google.com with ESMTPS id 20sm3225963pzk.3.2010.06.07.11.30.59
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 11:31:01 -0700 (PDT)
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
To:     ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Himanshu Chauhan <hschauhan@nulltrace.org>
Subject: [PATCH] Kprobes support for MIPS architecture.
Date:   Mon,  7 Jun 2010 22:03:59 +0530
Message-Id: <1275928440-21052-1-git-send-email-hschauhan@nulltrace.org>
X-Mailer: git-send-email 1.7.0.4
X-archive-position: 27086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4972

This is an initial draft of Kprobes support for MIPS architecture.
It is based on a patch series submitted on CELinux mailing list
from Sony for 2.6.16 series. Since then many things changed including
APIs and file paths. So this is essentially a patch replayed on
latest series.

Please review and provide your feedback.

Signed-off-by: Himanshu Chauhan <hschauhan@nulltrace.org>
---
Himanshu Chauhan (1):
  MIPS: KProbes support v0.1

 arch/mips/Kconfig               |   13 ++
 arch/mips/include/asm/kdebug.h  |    5 +
 arch/mips/include/asm/kprobes.h |   85 +++++++++
 arch/mips/kernel/Makefile       |    2 +
 arch/mips/kernel/genex.S        |    6 +
 arch/mips/kernel/kprobes.c      |  380 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c        |   40 ++++-
 arch/mips/mm/fault.c            |   11 +-
 8 files changed, 539 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/kprobes.h
 create mode 100644 arch/mips/kernel/kprobes.c
