Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jul 2010 22:15:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7334 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492267Ab0GSUPQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jul 2010 22:15:16 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c44b26c0000>; Mon, 19 Jul 2010 13:15:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:13 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 19 Jul 2010 13:15:13 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6JKF6mx011095;
        Mon, 19 Jul 2010 13:15:06 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6JKExNK011094;
        Mon, 19 Jul 2010 13:14:59 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/2] MIPS memory space randomization
Date:   Mon, 19 Jul 2010 13:14:55 -0700
Message-Id: <1279570497-11060-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
X-OriginalArrivalTime: 19 Jul 2010 20:15:13.0075 (UTC) FILETIME=[18369030:01CB277F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

x86, PPC and SPARC will randomize the application heap and library
load addresses depending on the value of randomize_va_space.  This
patch set implements address space randomization for MIPS.

Tested with a 64-bit kernel (OCTEON) and verified, for all three ABIs,
that the result of 'cat /proc/self/maps' gives different values for
[heap] and shared libraries with each invocation.  The stack was
already randomized and also gets a different value for each
invocation.

Someone may want to test it on a 32-bit kernel, but it should work
there as well.

I will reply with the two patches.


David Daney (2):
  MIPS: Randomize mmap if randomize_va_space is set
  MIPS: Enable heap randomization.

 arch/mips/include/asm/elf.h       |    5 ++++
 arch/mips/include/asm/processor.h |   11 ++++++++
 arch/mips/kernel/syscall.c        |   49 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletions(-)
