Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jan 2010 02:16:41 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1985 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492776Ab0AIBQh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jan 2010 02:16:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b47d8f10000>; Fri, 08 Jan 2010 17:16:33 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:16:29 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Fri, 8 Jan 2010 17:16:29 -0800
Message-ID: <4B47D8ED.1020006@caviumnetworks.com>
Date:   Fri, 08 Jan 2010 17:16:29 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] Rearrange MIPS barriers and optimize for Octeon.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jan 2010 01:16:29.0755 (UTC) FILETIME=[5F7108B0:01CA90C9]
X-archive-position: 25549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6010

Locking/atomic performance on Octeon can be improved by using
optimized barrier instructions.  The first patch in this set
rearranges and simplifies (at least in my mind) the existing barriers.
Then the second patch adds Octeon specific barriers.

I will reply with the two patches.

David Daney (2):
   MIPS: New macro smp_mb__before_llsc.
   MIPS: Octeon: Use optimized memory barrier primitives.

  arch/mips/Kconfig                |    1 -
  arch/mips/include/asm/atomic.h   |   16 ++++++------
  arch/mips/include/asm/barrier.h  |   52 
+++++++++++++++++++++++++++-----------
  arch/mips/include/asm/bitops.h   |    8 +++---
  arch/mips/include/asm/cmpxchg.h  |   10 +++---
  arch/mips/include/asm/spinlock.h |    4 +-
  arch/mips/include/asm/system.h   |    4 +++
  7 files changed, 60 insertions(+), 35 deletions(-)
