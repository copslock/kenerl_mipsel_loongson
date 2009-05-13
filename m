Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 21:48:38 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20634 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025127AbZEMUsc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 21:48:32 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0b31f50000>; Wed, 13 May 2009 16:47:49 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 13:47:02 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 May 2009 13:47:02 -0700
Message-ID: <4A0B31C6.9050804@caviumnetworks.com>
Date:	Wed, 13 May 2009 13:47:02 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>,
	"VomLehn, David" <dvomlehn@cisco.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 0/2] MIPS: Cleanup and optimize tlbex.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2009 20:47:02.0828 (UTC) FILETIME=[F80FBEC0:01C9D40B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The main motivation for this patch set is to optimize the tlb refill
handler in the case where it would be split on an eret instruction.
However, it was brought to my attention that the existing code was a
bit cryptic, so I start by trying to clean up the existing code before
patching it.

The first patch should be purely cosmetic, and the second adds the
optimization.

I will reply with the two patches.

David Daney (2):
  MIPS: Replace some magic numbers with symbolic values in tlbex.c
  MIPS: Don't branch to eret in TLB refill.

 arch/mips/mm/tlbex.c |   80 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 56 insertions(+), 24 deletions(-)
