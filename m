Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2006 11:07:03 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:33995 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133435AbWGYKGx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2006 11:06:53 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 98357205EF;
	Tue, 25 Jul 2006 15:33:44 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 6E1EE205E2;
	Tue, 25 Jul 2006 15:33:44 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 25 Jul 2006 15:36:45 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Multiple page size support for AU1xxx
Date:	Tue, 25 Jul 2006 15:36:33 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D6F3@blr-m2-msg.wipro.com>
In-Reply-To: <20060725034619.GA22617@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multiple page size support for AU1xxx
Thread-Index: AcavnPb35TBFRvN5QpSkFe2jX1iUNwAMnsUQ
From:	<hemanth.venkatesh@wipro.com>
To:	<ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 25 Jul 2006 10:06:45.0930 (UTC) FILETIME=[093810A0:01C6AFD2]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

>>Currently only 16kB works and only for 64-bit kernels.  I'm planning
to
>> fix that rsn.

Thanks for the info, did u mean 16KB would be supported for 32 bit
kernel also. I also saw code changes in arch/mips/mm/tlb-r8k.c only, is
there a plan to port it to r4k TLB also.


Help on 2.6.14 and 2.6.17 kernels provide the below info. Does it mean
some changes are required at user level also.

config PAGE_SIZE_16KB
        help
          Note that you will need a suitable Linux distribution to
support 
          this.
          There are also issues with compatibility of user applications

Thanks
Hemanth

  
