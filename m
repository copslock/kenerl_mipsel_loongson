Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U2Q5T30428
	for linux-mips-outgoing; Mon, 29 Oct 2001 18:26:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U2Pv030425;
	Mon, 29 Oct 2001 18:25:57 -0800
Received: from mvista.com (IDENT:ahennessy@penelope.mvista.com [10.0.0.122])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9U2RkB18788;
	Mon, 29 Oct 2001 18:27:46 -0800
Message-ID: <3BDE0FAF.1E3556A9@mvista.com>
Date: Mon, 29 Oct 2001 18:25:51 -0800
From: Alice Hennessy <ahennessy@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Carsten Langgaard <carstenl@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com> <20011030013223.B6614@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Oct 29, 2001 at 04:17:23PM -0800, Alice Hennessy wrote:
>
> > > This doesn't look right, you still need to enable the CU1 bit in the
> > > status register to let the FP emulator kick-in.  FPU-less CPUs should
> > > take a coprocessor unusable exception on any floating-point instructions.
> > > I have been running this on several FPU-less CPUs, and it works fine for
> > me.
> >
> > Maybe the FPU-less CPUs you have been using define the CU1 bit as reserved
> > or is unused (ignore on write, zero on read)? The TX3927 actually allows
> > the setting of the CU1 bit.  Have you seen a case where you need to set
> > the CU1 bit for the emulation to kick-in?   I would think that the CU1
> > bit should never be set to one for FPU-less CPUs.
>
> There are subtle differences in how CUx bits for unimplemented coprocessors
> are handled in the various processors.  MIPS32 and MIPS64 specifies the
> behaviour as 0 on read, writes ignored; previous processors such as the
> R4000 handled this differently and as a consequence a fp instruction on
> a fpu-less r4000 class cpu may either throw a CU or a reserved instruction
> exception.  To make things easier for everybody this is documented in the
> R10000 user's manual ...
>
>   Ralf

So,  we should not set CU1 generically for FPU-less CPUs especially since a
known problem exists
for the tx3927?  Ie, qualify all setting of CU1 as follows:

if (mips_cpu.options & MIPS_CPU_FPU)
                   set_cp0_status(ST0_CU1);


Alice
