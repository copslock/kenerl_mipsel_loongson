Received:  by oss.sgi.com id <S553806AbRBORK7>;
	Thu, 15 Feb 2001 09:10:59 -0800
Received: from mx.mips.com ([206.31.31.226]:1169 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553735AbRBORK2>;
	Thu, 15 Feb 2001 09:10:28 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA05969;
	Thu, 15 Feb 2001 09:10:23 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA22693;
	Thu, 15 Feb 2001 09:10:20 -0800 (PST)
Message-ID: <00e101c09772$b65ba860$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     <michaels@jungo.com>, "Paul Kleist" <paulk@mips.com>
Cc:     <linux-mips@oss.sgi.com>
References: <3A8ABA30.1D42A067@jungo.com> <3A8BCC28.32E9E240@mips.com> <3A8C0079.9B8DDAA@jungo.com>
Subject: Re: MIPS R5Kc core configuration
Date:   Thu, 15 Feb 2001 18:14:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

The 5KC should run an 4KC MIPS32 kernel with
no modifications if you want to run in 32-bit "mode".
As far as 64-bit operation is concerned, the 5KC
gives you an option that the R4xxx and R5xxx do
not, which is to enable 64-bit load/store/math operations
without also enabling 64-bit addressing.  But the
UX/KX bits in the Status register have the same
semantics on the 5KC as on the 4xxx and R5xxx,
as do the 64-bit memory management registers
and exceptions.  Yes, the R5261 would be a pretty
close match, though not perfect:  The basic 5KC
has no FPU, and the 5KC cache geometry cannot
be assumed based on the PrID register, and should
be inferred from the Config registers in the same
manner as on a 4KC, though of course as an expedient
you can set the cache size/associativity for the 5KC
in the kernel source to correpsond to your Core
board CPU.

        Kevin K.

----- Original Message -----
From: <michaels@jungo.com>
To: "Paul Kleist" <paulk@mips.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Thursday, February 15, 2001 5:14 PM
Subject: Re: MIPS R5Kc core configuration


> Paul,
>
> What I meant is: when configuring linux for some specific MIPS CPU,
> right now there is no MIPS64 CPU option (like there was MIPS32 for
> Atlas), therefore I don't know what CPU configuration may be used for
> 5Kc core.
>
> Do we have an FPU? What are the permitted CP register operations, and
> how do we set up the kernel for 64 bit architecture. I guess there were
> another 64 bit CPUs that are configured like the LJA0004 MIPS-5KC that
> is sitting on our Core board.
>
> Are you suggesting that QED's 5261 is a close shot?
>
> Thanks,
> Michael.
>
> Paul Kleist wrote:
> >
> > Hi Michael,
> >
> > what do you mean by the phrase 'that can be used for kernel
> > configuration' ?
> >
> > You can look at eg. QED or NEC websites for other 64 bit mips
> > processors, but they
> > are not nescessarily identical implementations so do not be sure that
> > you can use
> > another processor instead of 5Kc which is a MIPS64 implementation.
> >
> > The QED5261 is *close*, and we do have 200/100 MHz boards (core/bus
> > freq) that can run
> > on Atlas/Malta, and this cpuboard run our Linux also.
> >
> > Regards
> > Paul Kleist
> >
> > michaels@jungo.com wrote:
> > >
> > > Hello,
> > >
> > > I have recently started to work with the new R5Kc core from MIPS.
> > > It is defined to be 64 Bit. I wonder if you know of other processors
> > > that are also 64
> > > bits that can be safely used for kernel configuration (R10000 maybe?).
> >
> > --
> > _    _ ____  ___    Paul Kleist        Mailto:paulk@mips.com
> > |\  /|||___)(___    MIPS Denmark       Direct: +45 44 86 55 43
> > | \/ |||    ____)   Lautrupvang 4 B    Switch: +45 44 86 55 55
> >   TECHNOLOGIES      DK-2750 Ballerup   Fax...: +45 44 86 55 56
> >                     Denmark            http://www.mips.com/
>
> --
> Sincerely yours,
> Michael Shmulevich
> ______________________________________
> Software Developer
> Jungo - R&D
> email: michaels@jungo.com
> web: http://www.jungo.com
> Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
> Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
