Received:  by oss.sgi.com id <S554104AbRBVG4K>;
	Wed, 21 Feb 2001 22:56:10 -0800
Received: from mail.sonytel.be ([193.74.243.200]:40432 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S554100AbRBVG4C>;
	Wed, 21 Feb 2001 22:56:02 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id HAA22050;
	Thu, 22 Feb 2001 07:53:28 +0100 (MET)
Date:   Thu, 22 Feb 2001 07:53:24 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Crossfire <xfire@xware.cx>, kjlin <kj.lin@viditec-netmedia.com.tw>,
        linux-mips@oss.sgi.com
Subject: Re: Does linux support for microprocessor without MMU?
In-Reply-To: <3A949279.5020707@redhat.com>
Message-ID: <Pine.GSO.4.10.10102220752430.13615-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 21 Feb 2001, Joe deBlaquiere wrote:
> Crossfire wrote:
> > kjlin was once rumoured to have said:
> >> I got an embedded MIPS board recently.
> >> It has the following features:
> >> - CPU implements a five-stage pipeline with performance similar to the MIPS R3000 pipeline.
> >> - MIPS32 compatible instruction set
> >> - R4000 style privileged resource architecture.
> >> - Without MMU.
> >> 
> >> I am estimating the possibility of porting linux on it.
> >> Can Linux/MIPS 2.2 or 2.4 support for such a board which without MMU ?
> >> Because i consider it is the most difficult part in the porting process.
> >> Am i right?
> > 
> > the Standard Linux kernels all require an MMU.  However, there is a
> > version of the kernel known as "ucLinux" (Microcontroller Linux) which
> > will run on CPUs without MMU.
> > 
> > I don't know if ucLinux has a MIPS target yet.
> 
> There isn't (yet) support for MIPS on uClinux.

But it can't be that hard to add support for it...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
