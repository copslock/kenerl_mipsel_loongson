Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f71DXPu03115
	for linux-mips-outgoing; Wed, 1 Aug 2001 06:33:25 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f71DXOV03112
	for <linux-mips@oss.sgi.com>; Wed, 1 Aug 2001 06:33:24 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA03444;
	Wed, 1 Aug 2001 06:33:11 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA20898;
	Wed, 1 Aug 2001 06:33:08 -0700 (PDT)
Message-ID: <019701c11a8f$2561daa0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <paul@patton.com>, "James Simmons" <jsimmons@transvirtual.com>
Cc: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>,
   <linux-mips-kernel@lists.sourceforge.net>
References: <Pine.LNX.4.10.10107311435110.28897-100000@transvirtual.com> <3B67F510.A0CFB4E7@patton.com>
Subject: Re: sys_mips problems
Date: Wed, 1 Aug 2001 15:37:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > > > Since I was having problems with everything sefaulting due to the
sys_mips
> > > > bug I tried the patch floating around. It fixed the segfault problem
but
> > > > instead I get this error. Anyone knows why?
> > > >
> > > > : error while loading shared libraries: libc.so.6: cannot stat
shared
> > > > object: Error 14
> > >
> > > Which patch did you use?
> >
> > The fast_sysmips one.
> >
> > > Does your CPU have ll/sc instructions?
> >
> > I have a cobalt cube which has a MIPS Nevada chip which is a R52xx chip.
I
> > don't know if it does. By default I have ll/sc and lld/scd instructions
> > enabled.
>
> I don't know which R52xx chip you have, but my QED RM5261 has ll/sc but
> no mention of lld/scd instructions.

The RM52xx families are MIPS IV ISA devices, and lld/scd are
MIPS III (and therefore MIPS IV) instructions.  You've got 'em.
But you won't be able to use them in User mode unless the UX
bit of the CP0.Status register is set, which also turns on 64-bit
addressing, for which I rather doubt that your kernel is prepared.
User mode code should use only the 32-bit ll/sc's.  Not that it
sounds like that has anything to do with the problem reported
here, mind you...

            Kevin K.
