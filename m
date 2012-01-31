Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:22:01 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57806 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904031Ab2AaRTa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:30 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4C1ED44895A;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MUQxrKAW5-Mi; Tue, 31 Jan 2012 18:19:29 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id D624E434D36;
        Tue, 31 Jan 2012 18:19:29 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/6] MIPS: use IS_ENABLED() macro
Date:   Tue, 31 Jan 2012 18:19:02 +0100
Message-Id: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
X-archive-position: 32372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

This patch replaces the traditionnal use of:
CONFIG_FOO || CONFIG_FOO_MODULE by IS_ENABLED(CONFIG_FOO)

Florian Fainelli (6):
  MIPS: Alchemy: use IS_ENABLED() macro
  MIPS: PNX833x: use IS_ENABLED() macro
  MIPS: TXX9: use IS_ENABLED() macro
  MIPS: TX49XX: use IS_ENABLED()
  MIPS: DEC: use IS_ENABLED()
  MIPS: loongson: use IS_ENABLED()

 arch/mips/alchemy/board-mtx1.c                  |    4 ++--
 arch/mips/alchemy/devboards/pb1100.c            |    4 ++--
 arch/mips/alchemy/devboards/pb1500.c            |    4 ++--
 arch/mips/dec/prom/memory.c                     |    2 +-
 arch/mips/include/asm/mach-loongson/loongson.h  |    3 ++-
 arch/mips/include/asm/mach-tx49xx/mangle-port.h |    2 +-
 arch/mips/pnx833x/stb22x/board.c                |    4 ++--
 arch/mips/txx9/generic/setup.c                  |   12 +++++-------
 arch/mips/txx9/generic/setup_tx4939.c           |    2 +-
 arch/mips/txx9/rbtx4939/setup.c                 |   11 +++++------
 10 files changed, 23 insertions(+), 25 deletions(-)

-- 
1.7.5.4
