Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Feb 2010 16:35:51 +0100 (CET)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:33632 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab0B1Pfs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Feb 2010 16:35:48 +0100
Received: id: bigeasy by Chamillionaire.breakpoint.cc authenticated by bigeasy with local
        (easymta 1.00 BETA 1)
        id 1NllBJ-0004M7-5w; Sun, 28 Feb 2010 16:35:45 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        linux-ide@vger.kernel.org
Subject: Fix ide on Swarm and improve it a little
Date:   Sun, 28 Feb 2010 16:35:38 +0100
Message-Id: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
X-Mailer: git-send-email 1.6.5.2
Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

Patch #1 fixes the ide trouble on Swarm. We don't have dcache alliasing
         there but icache does not snoop dcache so we can't execute / boot
         from ide devices unless dcache is flushed.
Patch #2 is ths' old patch rebased with a few optimizations.
Patch #3 moves the dcache flush from arch code into ide subsystem. David,
         I hope I don't break any of your sparcs. The dcache flush in
         write path looks like a nop.

The whole series was tested on MIPS BCM1250 B2 aka Swarm with its default
config and CONFIG_BLK_DEV_PLATFORM=y instead PATA. PATA seems not to work
(yet).

Sebastian
