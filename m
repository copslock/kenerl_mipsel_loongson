Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:17:24 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1671 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493673AbZJNTRR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 21:17:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ad6237d0000>; Wed, 14 Oct 2009 12:16:18 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:15:31 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Oct 2009 12:15:31 -0700
Message-ID: <4AD62353.2080603@caviumnetworks.com>
Date:	Wed, 14 Oct 2009 12:15:31 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Put PGD in C0_CONTEXT for 64-bit R2 processors.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2009 19:15:31.0679 (UTC) FILETIME=[B2B266F0:01CA4D02]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This set of patches optimizes TLB handling in mips64r2 processors.  If
we have the mips64r2 ISA available, we can do enough bit twiddling
with out using a scratch register that it become possible and
desirable to carry the PGD pointer in c0_context rather than having to
always load it from memory.

The first patch adds some instructions to uasm that are needed by the
second patch.

The second patch contains the main changes.

I will reply with the two patches.

David Daney (2):
   MIPS: Add drotr and dins instructions to uasm.
   MIPS: Put PGD in C0_CONTEXT for 64-bit R2 processors.

  arch/mips/Kconfig                   |    3 +++
  arch/mips/include/asm/mmu_context.h |   29 ++++++++++++++++++++++++++++-
  arch/mips/include/asm/stackframe.h  |   20 ++++++++++----------
  arch/mips/mm/init.c                 |    2 ++
  arch/mips/mm/tlbex.c                |   28 +++++++++++++++++++++++++---
  arch/mips/mm/uasm.c                 |   16 +++++++++++++---
  arch/mips/mm/uasm.h                 |    7 +++++++
  7 files changed, 88 insertions(+), 17 deletions(-)
