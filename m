Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 23:51:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7309 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab1AXWvu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 23:51:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e02b40000>; Mon, 24 Jan 2011 14:52:36 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:47 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:46 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0OMpfTs023354;
        Mon, 24 Jan 2011 14:51:42 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0OMpctS023353;
        Mon, 24 Jan 2011 14:51:38 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/4] MIPS specific GCC-4.6 fixes.
Date:   Mon, 24 Jan 2011 14:51:33 -0800
Message-Id: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 24 Jan 2011 22:51:46.0862 (UTC) FILETIME=[476B74E0:01CBBC19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

These are the patches to MIPS specific code needed to build the kernel
with GCC-4.6 (not yet released).

There is a separate patch so fs/binfmt_elf.c I will send separately.

David Daney (4):
  MIPS: Fix GCC-4.6 'set but not used' warning in signal*.c
  MIPS: Remove unused code from arch/mips/kernel/syscall.c
  MIPS: Fix GCC-4.6 'set but not used' warning in ieee754int.h
  MIPS: Fix GCC-4.6 'set but not used' warning in arch/mips/mm/init.c

 arch/mips/kernel/signal.c       |    2 +-
 arch/mips/kernel/signal32.c     |    2 +-
 arch/mips/kernel/syscall.c      |    3 +--
 arch/mips/math-emu/ieee754int.h |    4 ++--
 arch/mips/mm/init.c             |    2 +-
 5 files changed, 6 insertions(+), 7 deletions(-)

-- 
1.7.2.3
