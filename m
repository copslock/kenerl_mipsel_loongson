Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:46:53 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9490 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024402AbZE1Aqe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:46:34 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1ddece0000>; Wed, 27 May 2009 20:46:06 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:46:16 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:46:16 -0700
Message-ID: <4A1DDED7.3020306@caviumnetworks.com>
Date:	Wed, 27 May 2009 17:46:15 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
CC:	wli@holomorphy.com
Subject: [PATCH 0/5] MIPS: Add hugeTLBfs support.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 May 2009 00:46:16.0068 (UTC) FILETIME=[B50ADC40:01C9DF2D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

This patch set adds hugetlbfs support to the MIPS architecture.

Huge pages are implemented by placing the PTE for the huge page
(flagged by the _PAGE_HUGE) in the PMD.  This gives a huge page size
of 2M (PTRS_PER_PTE * PAGE_SIZE) when the PAGE_SIZE is 4K.  Each huge
page occupies a complete TLB entry with the first half of the page
covered by entrylo0 and the second half by entrylo1.  Since there is
only a single PTE for the huge page in the PMD, the value of entrylo1
is derived from entrylo0 by adding a constant of half a huge page.  We
do this for several reasons:

1) The valid values of PageMask are such that this combination is
allowed.

2) Since the PageMask applies to both entrylo0 *and* entrylo1 we
cannot leave one of them empty because the current vma allocation
mechanisms don't handle excluding areas that would fall in any gaps
caused by an empty entrylo from allocation to normal sized pages.

When hugetlbfs is enabled, there is an approximately two instruction
overhead in the normal path of the TLB refill handler.  This is needed
to check the _PAGE_HUGE bit of each PMD entry.  With hugetlbfs
disabled, there is no change.

Currently the patch only works for 64-bit kernels because the value of
PTRS_PER_PTE in 32-bit kernels is such that it is impossible to have a
valid PageMask.  It is thought that by adjusting the page allocation
scheme, 32-bit kernels could be supported in the future.

All of the patches except the forth touch only the arch/mips tree.
The forth patch is the generic Kconfig change to allow MIPS to turn on
hugetlbfs.

I will reply with the five patches.

David Daney (5):
   MIPS: Add support files for hugeTLBfs.
   MIPS: Add hugeTLBfs page defines.
   MIPS: TLB support for hugeTLBfs.
   Enable hugetlbfs for more systems.
   MIPS: Add SYS_SUPPORTS_HUGETLBFS Kconfig variable and enable it for
     some systems.

  arch/mips/Kconfig                    |   11 +++
  arch/mips/include/asm/hugetlb.h      |  114 +++++++++++++++++++++++
  arch/mips/include/asm/mipsregs.h     |   16 ++++
  arch/mips/include/asm/page.h         |    5 +
  arch/mips/include/asm/pgtable-bits.h |    1 +
  arch/mips/include/asm/pgtable.h      |   10 ++
  arch/mips/mm/Makefile                |    1 +
  arch/mips/mm/hugetlbpage.c           |  101 +++++++++++++++++++++
  arch/mips/mm/tlb-r4k.c               |   43 +++++++---
  arch/mips/mm/tlbex.c                 |  165 
+++++++++++++++++++++++++++++++++-
  fs/Kconfig                           |    2 +-
  11 files changed, 456 insertions(+), 13 deletions(-)
  create mode 100644 arch/mips/include/asm/hugetlb.h
  create mode 100644 arch/mips/mm/hugetlbpage.c
