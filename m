Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U0XEo28392
	for linux-mips-outgoing; Mon, 29 Oct 2001 16:33:14 -0800
Received: from dea.linux-mips.net (a1as03-p77.stg.tli.de [195.252.186.77])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U0X7028389
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 16:33:10 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9U0WNU06841;
	Tue, 30 Oct 2001 01:32:23 +0100
Date: Tue, 30 Oct 2001 01:32:23 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Alice Hennessy <ahennessy@mvista.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011030013223.B6614@dea.linux-mips.net>
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDDF193.B6405A7F@mvista.com>; from ahennessy@mvista.com on Mon, Oct 29, 2001 at 04:17:23PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 29, 2001 at 04:17:23PM -0800, Alice Hennessy wrote:

> > This doesn't look right, you still need to enable the CU1 bit in the
> > status register to let the FP emulator kick-in.  FPU-less CPUs should
> > take a coprocessor unusable exception on any floating-point instructions.
> > I have been running this on several FPU-less CPUs, and it works fine for
> me.
> 
> Maybe the FPU-less CPUs you have been using define the CU1 bit as reserved
> or is unused (ignore on write, zero on read)? The TX3927 actually allows
> the setting of the CU1 bit.  Have you seen a case where you need to set
> the CU1 bit for the emulation to kick-in?   I would think that the CU1
> bit should never be set to one for FPU-less CPUs.

There are subtle differences in how CUx bits for unimplemented coprocessors
are handled in the various processors.  MIPS32 and MIPS64 specifies the
behaviour as 0 on read, writes ignored; previous processors such as the
R4000 handled this differently and as a consequence a fp instruction on
a fpu-less r4000 class cpu may either throw a CU or a reserved instruction
exception.  To make things easier for everybody this is documented in the
R10000 user's manual ...

  Ralf
