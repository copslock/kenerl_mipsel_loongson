Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 00:55:07 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4098 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492617Ab0LTXzE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 00:55:04 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d0fed000000>; Mon, 20 Dec 2010 15:55:44 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:21 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 20 Dec 2010 15:56:21 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id oBKNsrpX012884;
        Mon, 20 Dec 2010 15:54:53 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id oBKNsqSG012883;
        Mon, 20 Dec 2010 15:54:52 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] MIPS: Use Octeon BBIT instructions in TLB handlers.
Date:   Mon, 20 Dec 2010 15:54:48 -0800
Message-Id: <1292889290-12849-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 20 Dec 2010 23:56:21.0142 (UTC) FILETIME=[80366B60:01CBA0A1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Octeon has instructions that conditionally branch based on the value
of any single bit in any register.  We use these to reduce the number
of instructions in the generated TLB handlers.

This set applies on top of the recent KScratch patch set.

David Daney (2):
  MIPS: Declare uasm bbit0 and bbit1 functions.
  MIPS: Use BBIT instructions in TLB handlers

 arch/mips/include/asm/uasm.h |    2 +
 arch/mips/mm/tlbex.c         |  119 +++++++++++++++++++++++++++++++----------
 2 files changed, 92 insertions(+), 29 deletions(-)

-- 
1.7.2.3
