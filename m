Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 20:22:45 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19452 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491888Ab0HCSWl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 20:22:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c585e890000>; Tue, 03 Aug 2010 11:23:05 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:36 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:36 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73IMWEK026410;
        Tue, 3 Aug 2010 11:22:32 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73IMRgu026400;
        Tue, 3 Aug 2010 11:22:27 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/5] KProbes support for MIPS
Date:   Tue,  3 Aug 2010 11:22:17 -0700
Message-Id: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 03 Aug 2010 18:22:36.0641 (UTC) FILETIME=[D942CD10:01CB3338]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set adds KProbs, JProbs and KRetProbes support for the MIPS
archetecture.

It was tested on a 64-bit big-endian kernel (Octeon), but should work
equally well on 32-bit and little-endian as well.

As you can see from the patches it is partially based on previous work
by Sony and Himanshu Chauhan.

David Daney (5):
  MIPS: Define regs_return_value()
  MIPS: Add instrunction format for BREAK and SYSCALL
  MIPS: Add KProbe support.
  samples: kprobe_example: Make it print something on MIPS.
  documentation: Mention that KProbes is supported on MIPS

 Documentation/kprobes.txt        |    1 +
 arch/mips/Kconfig                |    2 +
 arch/mips/Makefile               |    3 +
 arch/mips/include/asm/break.h    |    2 +
 arch/mips/include/asm/inst.h     |   15 +-
 arch/mips/include/asm/kdebug.h   |    3 +
 arch/mips/include/asm/kprobes.h  |   91 ++++++
 arch/mips/include/asm/ptrace.h   |    1 +
 arch/mips/kernel/Makefile        |    1 +
 arch/mips/kernel/kprobes.c       |  562 ++++++++++++++++++++++++++++++++++++++
 arch/mips/kernel/traps.c         |   22 ++-
 arch/mips/mm/fault.c             |   15 +-
 samples/kprobes/kprobe_example.c |    9 +
 13 files changed, 724 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/include/asm/kprobes.h
 create mode 100644 arch/mips/kernel/kprobes.c
