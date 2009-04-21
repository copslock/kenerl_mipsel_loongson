Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 22:33:20 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53686 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S29034976AbZDUVbi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 22:31:38 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ee3b280000>; Tue, 21 Apr 2009 17:31:20 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 14:30:55 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Apr 2009 14:30:55 -0700
Message-ID: <49EE3B0F.3040506@caviumnetworks.com>
Date:	Tue, 21 Apr 2009 14:30:55 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Move signal return trampolines off the stack.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2009 21:30:55.0769 (UTC) FILETIME=[74542890:01C9C2C8]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set (against 2.6.29.1) creates a vdso and moves the signal
trampolines to it from their previous home on the stack.

Tested with a 64-bit kernel on a Cavium Octeon cn3860 where I have the
following results from lmbench2:

Before:
n64 - Signal handler overhead: 14.517 microseconds
n32 - Signal handler overhead: 14.497 microseconds
o32 - Signal handler overhead: 16.637 microseconds

After:

n64 - Signal handler overhead: 7.935 microseconds
n32 - Signal handler overhead: 7.334 microseconds
o32 - Signal handler overhead: 8.628 microseconds

Comments encourged.

I will reply with two patches.

David Daney (2):
  MIPS: Preliminary vdso.
  MIPS: Move signal trampolines off of the stack.

 arch/mips/include/asm/abi.h         |    6 +-
 arch/mips/include/asm/elf.h         |    4 +
 arch/mips/include/asm/mmu.h         |    5 +-
 arch/mips/include/asm/mmu_context.h |    2 +-
 arch/mips/include/asm/processor.h   |    5 +-
 arch/mips/include/asm/vdso.h        |   29 ++++++++++
 arch/mips/kernel/Makefile           |    2 +-
 arch/mips/kernel/signal-common.h    |    5 --
 arch/mips/kernel/signal.c           |   86 ++++++----------------------
 arch/mips/kernel/signal32.c         |   55 +++++--------------
 arch/mips/kernel/signal_n32.c       |   26 ++-------
 arch/mips/kernel/syscall.c          |    2 +-
 arch/mips/kernel/vdso.c             |  104 +++++++++++++++++++++++++++++++++++
 13 files changed, 190 insertions(+), 141 deletions(-)
 create mode 100644 arch/mips/include/asm/vdso.h
 create mode 100644 arch/mips/kernel/vdso.c
