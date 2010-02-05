Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2010 00:27:00 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11616 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492265Ab0BEX0w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2010 00:26:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b6ca9310000>; Fri, 05 Feb 2010 15:26:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:26:04 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 5 Feb 2010 15:26:04 -0800
Message-ID: <4B6CA90C.1000609@caviumnetworks.com>
Date:   Fri, 05 Feb 2010 15:26:04 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/4] MIPS Read Inhibit/eXecute Inhibit support.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Feb 2010 23:26:04.0793 (UTC) FILETIME=[96390E90:01CAA6BA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set adds execute and read inhibit support.  By default glibc
based tool chains will create mappings for data areas of a program and
shared libraries with PROT_EXEC cleared.  With this patch applied, a
SIGSEGV is correctly sent if an attempt is made to execute from data
areas.

We have been running this patch for close to a year.  So far it seems
to work well, so I ported it to the HEAD for your enjoyment.

I will reply with the four patches.

David Daney (4):
   MIPS: Use 64-bit stores to c0_entrylo on 64-bit kernels.
   MIPS: Add accessor functions and bit definitions for c0_PageGrain
   MIPS: Add TLBP to uasm.
   MIPS: Implement Read Inhibit/eXecute Inhibit

  arch/mips/Kconfig                    |    7 ++
  arch/mips/include/asm/mipsregs.h     |   11 +++
  arch/mips/include/asm/pgtable-64.h   |    4 +
  arch/mips/include/asm/pgtable-bits.h |   59 ++++++++++++-
  arch/mips/include/asm/pgtable.h      |   39 ++++++++-
  arch/mips/include/asm/uasm.h         |    1 +
  arch/mips/mm/cache.c                 |   11 +++
  arch/mips/mm/fault.c                 |   23 +++++
  arch/mips/mm/init.c                  |    2 +-
  arch/mips/mm/tlb-r4k.c               |   15 +++-
  arch/mips/mm/tlbex.c                 |  165 
++++++++++++++++++++++++++++-----
  arch/mips/mm/uasm.c                  |    5 +-
  12 files changed, 308 insertions(+), 34 deletions(-)
