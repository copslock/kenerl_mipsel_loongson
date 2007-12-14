Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 09:34:41 +0000 (GMT)
Received: from dns0.mips.com ([63.167.95.198]:46579 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20023038AbXLNJec (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 14 Dec 2007 09:34:32 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id lBE9QLMf005921;
	Fri, 14 Dec 2007 01:26:21 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id lBE9QqPJ003446;
	Fri, 14 Dec 2007 01:26:53 -0800 (PST)
Message-ID: <00c801c83e33$75572a00$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@gnss.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <9D98C51005D80D43A19A3DF329A61D690106A282@INDEXCH2003.gmi.domain> <20071213125847.GA1352@linux-mips.org> <9D98C51005D80D43A19A3DF329A61D690106A297@INDEXCH2003.gmi.domain>
Subject: Re: Inter processor synchronization
Date:	Fri, 14 Dec 2007 10:26:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1914
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1914
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> >> I have a scenario where two images of the same Linux kernel are
> >> running on two MIPS cores. One is 24K and another is 4KEC. What is
> >> the best way to achieve inter processor synchronization between them?
> >> 
> >> I guess the locks for LL/SC are local to a particular core and can
> >> not be extended across a multi core system.

Just to be clear,  LL/SC are indeed local to a particular core *but*, 
in a cache coherent multiprocessor system, they provide multiprocessor
synchronization - the fact that another core has referenced the coherent
location will clear the link bit so that the SC will fail locally.

> > 4K and 24K cores don't support cache coherency.  So SMP is out of
> > question. 
> > This is a _total_ showstopper for SMP, don't waste your time thinking
> > on possible workarounds. 
> > 
> > The you could do is some sort of clusting, running two OS images, one
> > on the 4K and one on the 24K which would communicate through a
> > carefully cache managed or even uncached shared memory region.  
> 
> I guess I am left with only this option. Can you please throw some more
> lights On the IPC you are mentioning?

Unless one has special-purpose hardware that implements atomic operations
(e.g. a hardware semaphore device), one must use algorithms that do not
require atomic read-modify-write.  Most classically, one uses mailboxes 
where each memory location has a single reader and a single writer.  There 
are other, more general but less efficient algorithms (e.g. Decker's algorithm)
out there as well.  If one is doing this in cacheable memory, one needs
to take care that (a) an explicit forced cache writeback operation is done
to complete each update to the shared memory array, and (b) the "ownership" 
is at a granularity of a cache line, and not a memory word.  If the memory
is mapped uncached, and one has a message queue "next" pointer that
is written by CPU A and a "last-read" pointer that is written by B, those two
pointers can be in consecutive memory locations.  But if the memory is cached,
they must be in separate cache lines to avoid the writebacks of one CPU
destroying the writebacks of another.

            Regards,

            Kevin K.
