Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jul 2004 08:49:25 +0100 (BST)
Received: from bay1-f25.bay1.hotmail.com ([IPv6:::ffff:65.54.245.25]:45582
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224950AbUGWHtV>; Fri, 23 Jul 2004 08:49:21 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 23 Jul 2004 00:49:13 -0700
Received: from 24.6.61.8 by by1fd.bay1.hotmail.msn.com with HTTP;
	Fri, 23 Jul 2004 07:49:13 GMT
X-Originating-IP: [24.6.61.8]
X-Originating-Email: [kommu@hotmail.com]
X-Sender: kommu@hotmail.com
From: "Srinivas Kommu" <kommu@hotmail.com>
To: linux-mips@linux-mips.org
Cc: kommu@hotmail.com
Subject: mips32 kernel memory mapping
Date: Fri, 23 Jul 2004 00:49:13 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F25sCR6nWqNG2Y00092cf9@hotmail.com>
X-OriginalArrivalTime: 23 Jul 2004 07:49:13.0935 (UTC) FILETIME=[8C448DF0:01C47089]
Return-Path: <kommu@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kommu@hotmail.com
Precedence: bulk
X-list: linux-mips

Can a 32-bit mips kernel access beyond KSEG0 contiguously? I have a Sibyte 
1250 with 1 Gig RAM, but only 256 MB is located at phyical 0x0. The rest is 
all located at 0x8000_0000. Does that mean the kernel can access only 256 
meg contiguously? Do I need to enabled CONFIG_HIGHMEM to even reach the 
remaining RAM? It appears Highmem gives me only a 4 meg window at a time. 
Can't I set up a page mapping into KSEG2 for the rest of the memory? KSEG2 
seems to be unused from what I read.

Since the user space has a 2 Gig address space, it should be able to access 
it, right? Does the kernel allocate from the whole 1 Gig when the process 
issues a malloc()?

thanks!
Srini

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
