Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 19:38:26 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:20896 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025100AbZETSiK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 19:38:10 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a144dfb0000>; Wed, 20 May 2009 14:37:47 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 11:37:51 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 20 May 2009 11:37:51 -0700
Message-ID: <4A144DFF.90602@caviumnetworks.com>
Date:	Wed, 20 May 2009 11:37:51 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 0/2] Optimize TLB refill handler folding and cleanup.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2009 18:37:51.0693 (UTC) FILETIME=[14EAA7D0:01C9D97A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The first patch in the set is unchanged from that last time I sent it,
but since it is a prerequisite for the second, I am sending it again.
In it we add some documentation on the TLB refill handler folding and
replace some magic numbers with symbolic constants.

The second patch is the latest iteration on eliminating unnecessary
branches from the refill handler.  We now use macro's patch rebased
onto the first patch.

I will reply with the two patches.

David Daney (2):
   MIPS: Replace some magic numbers with symbolic values in tlbex.c (v2)
   MIPS: Fold the TLB refill at the vmalloc path if possible.

  arch/mips/mm/tlbex.c |   87 
+++++++++++++++++++++++++++++++++++++------------
  1 files changed, 65 insertions(+), 22 deletions(-)
