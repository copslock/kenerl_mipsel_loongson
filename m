Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2010 02:21:24 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19791 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492639Ab0DTAU3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Apr 2010 02:20:29 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bccf3580002>; Mon, 19 Apr 2010 17:20:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:08 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 19 Apr 2010 17:20:07 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o3K0K1BZ027934;
        Mon, 19 Apr 2010 17:20:01 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o3K0JtMl027931;
        Mon, 19 Apr 2010 17:19:55 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     ltt-dev@lists.casi.polymtl.ca
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/3] LTTng patches for MIPS CPUs.
Date:   Mon, 19 Apr 2010 17:19:48 -0700
Message-Id: <1271722791-27885-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 20 Apr 2010 00:20:07.0969 (UTC) FILETIME=[3B763110:01CAE01F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

After speaking with Mathieu at the Linux Collaboration Summit, I
worked up these patches.  Thanks Mathieu, for helping me with this.

They should be fairly straight forward, the first one enables syscall
entry tracing, the second gives us system call names in lttv, and the
third fixes up the trace clock to work better on Octeon CPUs.

The base of the patch set is the patch-2.6.32.9-lttng-0.198.tar.gz
bundle from the download page on the web site.  The patches are really
only tested on a 64-bit kernel running on a 12 CPU Octeon SOC.  I
think the 32-bit code will compile and is correct, but I have not
tested it.

David Daney (3):
  lttng: MIPS: Fix syscall entry tracing.
  lttng: MIPS: Dump MIPS system call tables.
  lttng: MIPS: Use 64 bit counter for trace clock on Octeon CPUs.

 arch/mips/Kconfig                   |    5 ++-
 arch/mips/include/asm/trace-clock.h |   39 +++++++++++++++++++++++-
 arch/mips/kernel/scall32-o32.S      |    2 +-
 arch/mips/kernel/scall64-64.S       |    5 ++-
 arch/mips/kernel/scall64-n32.S      |    4 ++-
 arch/mips/kernel/scall64-o32.S      |   10 +++---
 arch/mips/kernel/smp.c              |    2 +
 arch/mips/kernel/syscall.c          |   58 +++++++++++++++++++++++++++++++++++
 8 files changed, 113 insertions(+), 12 deletions(-)
