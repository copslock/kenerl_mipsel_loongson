Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jun 2010 20:45:29 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:57150 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492025Ab0FLSpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 Jun 2010 20:45:24 +0200
Received: by pvg12 with SMTP id 12so1794395pvg.36
        for <multiple recipients>; Sat, 12 Jun 2010 11:45:15 -0700 (PDT)
Received: by 10.141.214.24 with SMTP id r24mr2746906rvq.273.1276368315763;
        Sat, 12 Jun 2010 11:45:15 -0700 (PDT)
Received: from localhost.localdomain ([122.167.28.178])
        by mx.google.com with ESMTPS id b12sm2671724rvn.10.2010.06.12.11.45.13
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 11:45:15 -0700 (PDT)
From:   Himanshu Chauhan <hschauhan@nulltrace.org>
To:     linux-kernel@vger.kernel.org
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH][UPDATED] MIPS: Kprobe support v0.2
Date:   Sat, 12 Jun 2010 21:50:55 +0530
Message-Id: <1276359656-2375-1-git-send-email-hschauhan@nulltrace.org>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1276359441-1846-1-git-send-email-hschauhan@nulltrace.org>
References: <1276359441-1846-1-git-send-email-hschauhan@nulltrace.org>
X-archive-position: 27124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hschauhan@nulltrace.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 8710

This updated version of patch incorporates some of the comments
from Daney. The list of changes are as follows:
o Instead of separate handler "do_break", do_bp is used to
  track and handle kprobe induced breaks. This cleans up ugly
  ifdef hack.
o Instead of using 0 and 5 code in break, new kprobe specific
  defines (515, 516) have been added and handled.

The use of notify_die could not be dropped because the kprobes
framework installs handlers on notify_die chain.

Himanshu Chauhan (1):
  MIPS: Kprobe support v0.2     This incorporates some of the comments
    from Daney.

 arch/mips/Kconfig               |   13 ++
 arch/mips/include/asm/break.h   |    2 +
 arch/mips/include/asm/kdebug.h  |    5 +
 arch/mips/include/asm/kprobes.h |   86 +++++++++
 arch/mips/kernel/Makefile       |    2 +
 arch/mips/kernel/kprobes.c      |  379 +++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c        |   46 +++++-
 arch/mips/mm/fault.c            |   11 +-
 8 files changed, 541 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/kprobes.h
 create mode 100644 arch/mips/kernel/kprobes.c
