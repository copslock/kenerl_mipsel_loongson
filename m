Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 02:04:00 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:62125 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22053893AbYJVBD6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 02:03:58 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48fe7bee0000>; Tue, 21 Oct 2008 21:03:42 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Oct 2008 18:03:40 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 21 Oct 2008 18:03:40 -0700
Message-ID: <48FE7BEB.80906@caviumnetworks.com>
Date:	Tue, 21 Oct 2008 18:03:39 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Question about rdhwr emulation.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2008 01:03:40.0180 (UTC) FILETIME=[05543540:01C933E2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

I was looking at the rdhwr emulation code in genex.S and wondering about the following:

If cpu_has_vtag_icache is true we run handle_ri_rdhwr_vivt() instead of handle_ri_rdhwr().

And handle_ri_rdhwr_vivt() probes the tlb to see if the faulting instruction can be reached through the TLB, if it can the 'fast path' is taken, otherwise the 'slow path'.

Why is this probe of the TLB necessary?  Or perhaps more concisely under which conditions can I set cpu_has_vtag_icache to false (noting that for our cpu this is the only place cpu_has_vtag_icache is tested)?

Thanks in advance for enlightening me,
David Daney
