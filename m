Received:  by oss.sgi.com id <S553753AbRAPVCj>;
	Tue, 16 Jan 2001 13:02:39 -0800
Received: from mclean.mail.mindspring.net ([207.69.200.57]:27967 "EHLO
        mclean.mail.mindspring.net") by oss.sgi.com with ESMTP
	id <S553655AbRAPVC3>; Tue, 16 Jan 2001 13:02:29 -0800
Received: from frednet.dyndns.org (user-33qt2v3.dialup.mindspring.com [199.174.139.227])
	by mclean.mail.mindspring.net (8.9.3/8.8.5) with SMTP id QAA15117
	for <linux-mips@oss.sgi.com>; Tue, 16 Jan 2001 16:02:26 -0500 (EST)
Received: (qmail 22283 invoked by uid 1000); 16 Jan 2001 21:02:25 -0000
Date:   Tue, 16 Jan 2001 15:02:25 -0600
From:   Matthew Fredrickson <matt@frednet.dyndns.org>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: Current CVS (010116) Boots OK
Message-ID: <20010116150225.A22161@frednet.dyndns.org>
References: <20010116192836.A26863@woody.ichilton.co.uk> <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.GSO.3.96.1010116210848.5546Z-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 09:17:45PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 09:17:45PM +0100, Maciej W. Rozycki wrote:
> On Tue, 16 Jan 2001, Ian Chilton wrote:
> 
> > Just cross compiled the kernel with GCC 2.95.2 and Binutils 2.10.1 and
> > booted my Indy R4600:
> [...]
> > Linux version 2.4.0 (ian@slinky) (gcc version 2.95.3 19991030
> > (prerelease)) #1 1
> > MC: SGI memory controller Revision 3
> > Determined physical RAM map:
> >  memory: 00001000 @ 00000000 (reserved)
> >  memory: 00001000 @ 00001000 (reserved)
> >  memory: 001c5000 @ 08002000 (reserved)
> >  memory: 00579000 @ 081c7000 (usable)
> >  memory: 000c0000 @ 08740000 (ROM data)
> >  memory: 05800000 @ 08800000 (usable)
> > On node 0 totalpages: 57344
> > zone(0): 57344 pages.
> > zone(1): 0 pages.
> > zone(2): 0 pages.
> > Kernel command line: console=ttyS0
> > Calibrating system timer... 500000 [100.00 MHz CPU]
> > NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A, xmap9
> > revision AD
> > NG1: Screensize 1280x1024

Does this mean we have support for the graphics hardware on SGIs?  Or is
it still limited to certain Indys?  I have an I2 I've been tempted to try
linux on but been spoofed off by the fact that I can't use my lovely 21"
monitor.  Is a search still being made for docs on the graphics hardware?

-- 
Matthew Fredrickson AIM MatthewFredricks
ICQ 13923212 matt@NOSPAMfredricknet.net 
http://www.fredricknet.net/~matt/
"Everything is relative"
