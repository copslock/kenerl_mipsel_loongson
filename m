Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2003 19:48:03 +0100 (BST)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:19934 "EHLO
	butch.idealab.com") by linux-mips.org with ESMTP
	id <S8224861AbTFQSsA>; Tue, 17 Jun 2003 19:48:00 +0100
Received: (qmail 63686 invoked by uid 72); 17 Jun 2003 18:47:53 -0000
Received: from joseph@omnilux.net by butch.idealab.com with qmail-scanner-1.03 (sweep: 2.6/3.49. . Clean. Processed in 2.973729 secs); 17 Jun 2003 18:47:53 -0000
X-Qmail-Scanner-Mail-From: joseph@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 2.973729 secs)
Received: from unknown (HELO c002079) (10.1.2.63)
  by 0 with SMTP; 17 Jun 2003 18:47:50 -0000
From: "Joseph Chiu" <joseph@omnilux.net>
To: "Pete Popov" <ppopov@mvista.com>
Cc: "Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: RE: wired tlb entry?
Date: Tue, 17 Jun 2003 11:51:13 -0700
Message-ID: <BPEELMGAINDCONKDGDNCMEGADMAA.joseph@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <1055873800.4383.220.camel@zeus.mvista.com>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

Michael Guo suggested add_wired_entry -- I'm giving that a try now.  I'm
trying to stick to "the kernel that we trust" (from the perspective here)
because I'm worried about what I end up breaking trying to take a new
kernel.

I am behind the time, though, so I'll try to test out 2.4.21-pre4 when I get
back (I'm not available to run the tests during the rest of this week).

Thanks,
Joseph

-----Original Message-----
From: Pete Popov [mailto:ppopov@mvista.com]
Sent: Tuesday, June 17, 2003 11:17 AM
To: Joseph Chiu
Cc: Linux MIPS mailing list
Subject: RE: wired tlb entry?



Any chance you can try 2.4.21-pre4 (latest linux-mips) before we go any
further?

Pete

On Tue, 2003-06-17 at 11:12, Joseph Chiu wrote:
> (Sorry for the double-send of the original inquiry to the list -- I
actually
> got bounce notices from my mailer...)
>
> This is the kernel from almost a year ago with the changes you made to
> support the 36-bit phys addr. access on the Au1xxx.
> The Au1x00 PCMCIA (CS release 3.1.22) initialization maps phys_mem
f80000000
> to virt_io c0000000.
>
> I am running HostAP (0.0.3) on top of this PCMCIA support, using a
> Prism3-based WiFi card.
>
> During transmit/receive activity, the hardware interrupt invokes the
> prism2_interrupt() in hostap_cs.o which, in turn reads and writes from
> registers using the virtual i/o address of c0000000.
>
> Under light and moderate loading, there are no problems.  After heavy
> traffic loads, the system eventually dies with accesses to address
c000xxxx
> (one address gets hit 95% of the time - and there were other addresses a
few
> other times, but always in the c000xxxx address range).
>
> Thanks,
> Joseph
>
> -----Original Message-----
> From: Pete Popov [mailto:ppopov@mvista.com]
> Sent: Tuesday, June 17, 2003 10:19 AM
> To: Joseph Chiu
> Cc: Linux MIPS mailing list
> Subject: Re: wired tlb entry?
>
>
> On Mon, 2003-06-16 at 17:36, Joseph Chiu wrote:
> > Hi,
> > Is there a (proper) way to add a page entry in the TLB it's always
valid?
> > Specifically, accesses to memory-mapped hardware (PCMCIA) causes the
> kernel
> > to oops under heavy interrupt loading.
> > It seems to me that the page entry in the TLB is getting flushed out
under
> > the activity; and when the ioremap'd memory region is accesses, the
> > exception handling for the missing translation does not run.
> >
> > I'm afraid my two days of googling hasn't turned up the right
information.
> > I think I just don't know the right terminology and I hope someone can
at
> > least point me in the right direction.
> > Thanks.
> > Joseph
> > (I am running 2.4.18-mips)
>
> So is this a kernel from linux-mips.org?  Are you using the 36 bit I/O
> patch in that kernel, or the pseudo-address translation hack that I
> removed later? What pcmcia I/O card are you using and what tests are you
> running?
>
> Pete
>
>
>
