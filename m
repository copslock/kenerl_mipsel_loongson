Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9UEHWG23053
	for linux-mips-outgoing; Tue, 30 Oct 2001 06:17:32 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9UEHR023046;
	Tue, 30 Oct 2001 06:17:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA22586;
	Tue, 30 Oct 2001 06:17:20 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA06825;
	Tue, 30 Oct 2001 06:17:18 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f9UEHIa22110;
	Tue, 30 Oct 2001 15:17:18 +0100 (MET)
Message-ID: <3BDEB66E.AFD71BBA@mips.com>
Date: Tue, 30 Oct 2001 15:17:18 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Alice Hennessy <ahennessy@mvista.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com> <20011030013223.B6614@dea.linux-mips.net> <3BDE0FAF.1E3556A9@mvista.com> <3BDE6671.7776CB4B@mips.com> <20011030151308.B10165@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Tue, Oct 30, 2001 at 09:36:01AM +0100, Carsten Langgaard wrote:
>
> > > So,  we should not set CU1 generically for FPU-less CPUs especially since a
> > > known problem exists
> > > for the tx3927?  Ie, qualify all setting of CU1 as follows:
> > >
> > > if (mips_cpu.options & MIPS_CPU_FPU)
> > >                    set_cp0_status(ST0_CU1);
> >
> > And while we are at it, could we handle the CP0 hazard of 4 nops, between
> > setting the CU1 bit in the status register and executing
> > the first floating point instruction, on CPU which got a FPU.
>
> Which CPUs actually need four nops?
>
> Just working on a patch; I found a bunch more place where we were playing
> with the CU1 bit.

The MIPS32 spec specify 4 nops.

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
