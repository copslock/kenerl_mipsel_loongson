Received:  by oss.sgi.com id <S553764AbRBHKzC>;
	Thu, 8 Feb 2001 02:55:02 -0800
Received: from mail.sonytel.be ([193.74.243.200]:31900 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553761AbRBHKy4>;
	Thu, 8 Feb 2001 02:54:56 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id LAA06953;
	Thu, 8 Feb 2001 11:53:52 +0100 (MET)
Date:   Thu, 8 Feb 2001 11:53:52 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com,
        ralf@oss.sgi.com
Subject: Re: NON FPU cpus - way to go
In-Reply-To: <Pine.GSO.3.96.1010208112520.29177C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.4.10.10102081151560.23477-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 8 Feb 2001, Maciej W. Rozycki wrote:
> On Wed, 7 Feb 2001, Alan Cox wrote:
> > Also we missed a trick on the x86 and I want to fix that one day, which is
> > to have an __fpu ELF segment so if you boot an FPU emu kernel on an fpu
> > box you regain 47K
> 
>  A good idea, even though hardly anyone needs the emulator for i386 these
> days. ;-) 

Yep, I put it on my m68k TODO list as well ;-)

Alternatively you can make (most of) it a loadable module. I don't think
/sbin/modprobe needs the FPU :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
