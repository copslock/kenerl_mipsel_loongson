Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U8aZJ05123
	for linux-mips-outgoing; Tue, 30 Oct 2001 00:36:35 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U8aS005118;
	Tue, 30 Oct 2001 00:36:28 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA19555;
	Tue, 30 Oct 2001 00:36:18 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02764;
	Tue, 30 Oct 2001 00:36:18 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f9U8a2a28619;
	Tue, 30 Oct 2001 09:36:17 +0100 (MET)
Message-ID: <3BDE6671.7776CB4B@mips.com>
Date: Tue, 30 Oct 2001 09:36:01 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Alice Hennessy <ahennessy@mvista.com>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com> <20011030013223.B6614@dea.linux-mips.net> <3BDE0FAF.1E3556A9@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alice Hennessy wrote:

> Ralf Baechle wrote:
>
> > On Mon, Oct 29, 2001 at 04:17:23PM -0800, Alice Hennessy wrote:
> >
> > > > This doesn't look right, you still need to enable the CU1 bit in the
> > > > status register to let the FP emulator kick-in.  FPU-less CPUs should
> > > > take a coprocessor unusable exception on any floating-point instructions.
> > > > I have been running this on several FPU-less CPUs, and it works fine for
> > > me.
> > >
> > > Maybe the FPU-less CPUs you have been using define the CU1 bit as reserved
> > > or is unused (ignore on write, zero on read)? The TX3927 actually allows
> > > the setting of the CU1 bit.  Have you seen a case where you need to set
> > > the CU1 bit for the emulation to kick-in?   I would think that the CU1
> > > bit should never be set to one for FPU-less CPUs.
> >
> > There are subtle differences in how CUx bits for unimplemented coprocessors
> > are handled in the various processors.  MIPS32 and MIPS64 specifies the
> > behaviour as 0 on read, writes ignored; previous processors such as the
> > R4000 handled this differently and as a consequence a fp instruction on
> > a fpu-less r4000 class cpu may either throw a CU or a reserved instruction
> > exception.  To make things easier for everybody this is documented in the
> > R10000 user's manual ...
> >
> >   Ralf
>
> So,  we should not set CU1 generically for FPU-less CPUs especially since a
> known problem exists
> for the tx3927?  Ie, qualify all setting of CU1 as follows:
>
> if (mips_cpu.options & MIPS_CPU_FPU)
>                    set_cp0_status(ST0_CU1);

And while we are at it, could we handle the CP0 hazard of 4 nops, between setting
the CU1 bit in the status register and executing
the first floating point instruction, on CPU which got a FPU.

>
>
> Alice

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
