Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 04:21:51 +0000 (GMT)
Received: from mail.gnss.com ([209.47.22.10]:10256 "EHLO tormf01.gmi.domain")
	by ftp.linux-mips.org with ESMTP id S20021610AbXLNEVl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 04:21:41 +0000
Received: from tormf01.gmi.domain (127.0.0.1) by tormf01.gmi.domain (MlfMTA v3.2r9) id hc82da0171sb; Thu, 13 Dec 2007 23:21:27 -0500 (envelope-from <Nilanjan.Roychowdhury@gnss.com>)
Received: from INDEXCH2003.gmi.domain ([10.41.1.181])
	by tormf01.gmi.domain (SonicWALL 6.0.1.9157)
	with ESMTP; Thu, 13 Dec 2007 23:21:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Inter processor synchronization
Date:	Fri, 14 Dec 2007 09:51:23 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D690106A297@INDEXCH2003.gmi.domain>
In-Reply-To: <20071213125847.GA1352@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Inter processor synchronization
Thread-Index: Acg9h+v6X6nQlzAoSFKIiGz9oKlz7AAgHufA
References: <9D98C51005D80D43A19A3DF329A61D690106A282@INDEXCH2003.gmi.domain> <20071213125847.GA1352@linux-mips.org>
From:	"Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@gnss.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
X-Mlf-Version: 6.0.1.9157
X-Mlf-UniqueId:	o200712140421240079106
Return-Path: <Nilanjan.Roychowdhury@gnss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nilanjan.Roychowdhury@gnss.com
Precedence: bulk
X-list: linux-mips



on Thursday, December 13, 2007 6:29 PM:, Ralf Baechle wrote:
> On Thu, Dec 13, 2007 at 09:07:20AM +0530, Nilanjan Roychowdhury wrote:
> 
>> I have a scenario where two images of the same Linux kernel are
>> running on two MIPS cores. One is 24K and another is 4KEC. What is
>> the best way to achieve inter processor synchronization between them?
>> 
>> I guess the locks for LL/SC are local to a particular core and can
>> not be extended across a multi core system.

 
> 4K and 24K cores don't support cache coherency.  So SMP is out of
> question. 
> This is a _total_ showstopper for SMP, don't waste your time thinking
> on possible workarounds. 
> 
> The you could do is some sort of clusting, running two OS images, one
> on the 4K and one on the 24K which would communicate through a
> carefully cache managed or even uncached shared memory region.  

I guess I am left with only this option. Can you please throw some more
lights
On the IPC you are mentioning?



>> Will it be easier for me if both of them becomes same core ( like
>> both 24k) and I run the SMP version of Linux.
> 
> 
> Within limits Linux supports mixing different CPU types such as
> R4000MC / R4400MC and R10000 / R12000 / R14000 mixes because those
> processors are similar enough  
> 
>   Ralf

Thanks,
Nilanjan
