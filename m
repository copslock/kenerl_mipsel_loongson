Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 23:19:27 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12580 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491758Ab0LUWTX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 23:19:23 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1128140000>; Tue, 21 Dec 2010 14:20:04 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:41 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 14:20:41 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBLMJFxj011454;
        Tue, 21 Dec 2010 14:19:15 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBLMJDMD011453;
        Tue, 21 Dec 2010 14:19:13 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH v2 0/3] Allow processors with scratch registers to use them for TLB refill.
Date:   Tue, 21 Dec 2010 14:19:08 -0800
Message-Id: <1292969951-11418-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 21 Dec 2010 22:20:41.0956 (UTC) FILETIME=[4DCDE240:01CBA15D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

v2: Declare pgd_current for mipsr1 and mips32 builds.

This other patch set:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1292889290-12849-1-git-send-email-ddaney%40caviumnetworks.com

Should still be applied *after* this one.

From v1:

The MIPS32r2 and MIPS64r2 specifications allow processors to have
scratch registers in coprocessor 0.  If these are present, we can use
one of them to carry the current PGD and save three instructions in
the TLB handlers.

There are three patches:

1 - Probe for presence of scratch registers an print number found in
    /proc/cpuinfo.

2 - Add DINSM to uasm for use by patch 3.

3 - Convert the TLB handlers.  This also involves dynamically
    generating tlbmiss_handler_setup_pgd, which used to be statically
    defined.


David Daney (3):
  MIPS: Probe for presence of KScratch registers.
  MIPS: Add DINSM to uasm.
  MIPS: Use C0_KScratch (if present) to hold PGD pointer.

 arch/mips/include/asm/cpu-info.h    |    1 +
 arch/mips/include/asm/mmu_context.h |    8 +--
 arch/mips/include/asm/uasm.h        |    1 +
 arch/mips/kernel/cpu-probe.c        |    2 +
 arch/mips/kernel/proc.c             |    2 +
 arch/mips/kernel/traps.c            |    2 +-
 arch/mips/mm/tlbex.c                |  116 ++++++++++++++++++++++++++++++++---
 arch/mips/mm/uasm.c                 |   11 +++-
 8 files changed, 124 insertions(+), 19 deletions(-)

-- 
1.7.2.3
