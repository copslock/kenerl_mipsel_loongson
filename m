Received:  by oss.sgi.com id <S553743AbRBHIsN>;
	Thu, 8 Feb 2001 00:48:13 -0800
Received: from mail.sonytel.be ([193.74.243.200]:33923 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553738AbRBHIrt>;
	Thu, 8 Feb 2001 00:47:49 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA00884;
	Thu, 8 Feb 2001 09:45:57 +0100 (MET)
Date:   Thu, 8 Feb 2001 09:45:57 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Joe deBlaquiere <jadb@redhat.com>
cc:     Jun Sun <jsun@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <3A81B388.1090806@redhat.com>
Message-ID: <Pine.GSO.4.10.10102080944510.23477-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 7 Feb 2001, Joe deBlaquiere wrote:
> Jun Sun wrote:
> > Alan Cox wrote:
> >> Also we missed a trick on the x86 and I want to fix that one day, which is
> >> to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
> >> box you regain 47K
> > 
> > 
> > Ironically for MIPS you MUST have the FPU emulater when the CPU actually has a
> > FPU. :-)
> 
> I'm confused here... why is this?

Because a MIPS CPU may implement only some functionality with some operands,
and decide to throw an `unsupported' exception if the operation is too complex.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
