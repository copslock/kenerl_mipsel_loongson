Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 09:09:25 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:7933 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225196AbTDKIJY>;
	Fri, 11 Apr 2003 09:09:24 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h3B89CUe024136;
	Fri, 11 Apr 2003 01:09:12 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA10536;
	Fri, 11 Apr 2003 01:09:09 -0700 (PDT)
Message-ID: <004a01c30002$b3b19480$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Dominic Sweetman" <dom@mips.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc: "Mike Uhler" <uhler@mips.com>, "Jun Sun" <jsun@mvista.com>,
	<linux-mips@linux-mips.org>
References: <20030410220906.B519@linux-mips.org><200304102028.h3AKSf211575@uhler-linux.mips.com><20030410225212.A3294@linux-mips.org> <16022.24992.314581.716649@gladsmuir.mips.com>
Subject: Re: way selection bit for multi-way cache
Date: Fri, 11 Apr 2003 10:15:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> Mike wrote:
> 
> > > I'm not sure what you mean by TLB translations required for hit
> > > cacheops.  If you mean the Index Writeback or Index Invalidate
> > > functions, note that you can (and should) use a kseg0 address to
> > > do this.
> 
> Mike was proposing a kseg0 address translating to the right physical
> address, and used with a hit-type cacheop.  I believe Ralf (and Linux)
> are just assuming that's no good because it doesn't work if you have
> cacheable memory above 512Mbytes physical address.

More importantly, it doesn't work in the case of virtually tagged caches,
such as those in the SB-1 and MIPS 20K.

> I wonder whether anything really bad would happen if you temporarily
> changed the (machine) ASID to that of the address space you wanted to
> invalidate?

I looked at that when we were investigating the aforementioned
issues with virtually-tagged I-caches.  It looked to me as if exceptions
can occur during the invalidation, and that processing those exceptions
can cause signals to be raised to the current process in a manner that 
assumes that the TLB and ASID are coherent and in sync with 
the scheduler.  It may be that just changing the ASID temporarily
would work - most of the time.  It may even be that, with a bit
of lashing down of state, disabling of interrupts, setting of flags
to be read by traps.c/signal.c, etc, etc, it could be made bulletproof.
But I don't think that the simple, obvious hack is safe.

            Kevin K.
