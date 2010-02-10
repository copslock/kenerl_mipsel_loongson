Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2010 00:08:44 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15820 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492360Ab0BJXIk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2010 00:08:40 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b733c7d0002>; Wed, 10 Feb 2010 15:08:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:08:35 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 10 Feb 2010 15:08:35 -0800
Message-ID: <4B733C71.8030304@caviumnetworks.com>
Date:   Wed, 10 Feb 2010 15:08:33 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/6] MIPS Read Inhibit/eXecute Inhibit support (v2).
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2010 23:08:35.0267 (UTC) FILETIME=[F8B8D930:01CAAAA5]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25903
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

The first three patch just make a few tweaks in preperation for the
main body of the patch in 4/6.  The last two turn on the feature for
some Octeon CPUs.

I will reply with the six patches.

David Daney (6):
   MIPS: Use 64-bit stores to c0_entrylo on 64-bit kernels.
   MIPS: Add accessor functions and bit definitions for c0_PageGrain
   MIPS: Add TLBR and ROTR to uasm.
   MIPS: Implement Read Inhibit/eXecute Inhibit
   MIPS: Give Octeon+ CPUs their own cputype.
   MIPS: Enable Read Inhibit/eXecute Inhibit for Octeon+ CPUs

  arch/mips/include/asm/cpu-features.h               |    3 +
  arch/mips/include/asm/cpu.h                        |    2 +-
  .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    3 +
  arch/mips/include/asm/mipsregs.h                   |   11 ++
  arch/mips/include/asm/pgtable-32.h                 |    4 +-
  arch/mips/include/asm/pgtable-64.h                 |    4 +-
  arch/mips/include/asm/pgtable-bits.h               |  105 ++++++++++--
  arch/mips/include/asm/pgtable.h                    |   26 ++-
  arch/mips/include/asm/uasm.h                       |    4 +
  arch/mips/kernel/cpu-probe.c                       |    6 +-
  arch/mips/mm/c-octeon.c                            |    7 +-
  arch/mips/mm/cache.c                               |   53 ++++--
  arch/mips/mm/fault.c                               |   27 +++-
  arch/mips/mm/init.c                                |    2 +-
  arch/mips/mm/tlb-r4k.c                             |   19 ++-
  arch/mips/mm/tlbex.c                               |  183 
++++++++++++++++----
  arch/mips/mm/uasm.c                                |    9 +-
  17 files changed, 375 insertions(+), 93 deletions(-)
