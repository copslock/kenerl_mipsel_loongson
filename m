Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2010 03:08:40 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8879 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0L1CIh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Dec 2010 03:08:37 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d1946ce0000>; Mon, 27 Dec 2010 18:09:18 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:32 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 27 Dec 2010 18:08:32 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBS28Dni009233;
        Mon, 27 Dec 2010 18:08:13 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBS280NP009231;
        Mon, 27 Dec 2010 18:08:00 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] MIPS: Optimize TLB Refill for Octeon/Octeon2
Date:   Mon, 27 Dec 2010 18:07:55 -0800
Message-Id: <1293502077-9196-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 28 Dec 2010 02:08:32.0587 (UTC) FILETIME=[209D21B0:01CBA634]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Octeon and Octeon2 have scratch memory, and/or scratch registers that
allow us to save some instructions in the TLB refill handler.  Octeon2
has indexed load instructions that also can help.

The first patch adds uASM support for the indexed loads.  The second
essentially hand codes the refill handler with a view to optimally
scheduling the instructions to reduce stalls and increase the number
of dual issue slots that can be filled.

David Daney (2):
  MIPS: Add LDX and LWX instructions to uasm.
  MIPS: Optimize TLB handlers for Octeon CPUs

 arch/mips/include/asm/inst.h |   14 ++
 arch/mips/include/asm/uasm.h |    4 +
 arch/mips/mm/tlbex.c         |  361 ++++++++++++++++++++++++++++++++++++------
 arch/mips/mm/uasm.c          |    7 +-
 4 files changed, 334 insertions(+), 52 deletions(-)

-- 
1.7.2.3
