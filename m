Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GB95m24065
	for linux-mips-outgoing; Thu, 16 Aug 2001 04:09:05 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GB91j24056;
	Thu, 16 Aug 2001 04:09:01 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA29968;
	Thu, 16 Aug 2001 04:08:51 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA15988;
	Thu, 16 Aug 2001 04:08:53 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7GB7Ta17695;
	Thu, 16 Aug 2001 13:07:30 +0200 (MEST)
Message-ID: <3B7BA970.56192BB8@mips.com>
Date: Thu, 16 Aug 2001 13:07:28 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, wgowcher@yahoo.com,
   linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
References: <20010809215522.A1958@lucon.org> <20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp> <20010816111803.A17469@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Aug 16, 2001 at 12:56:52PM +0900, Atsushi Nemoto wrote:
>
> > >>>>> On Mon, 13 Aug 2001 10:34:46 -0700 (PDT), Wayne Gowcher <wgowcher@yahoo.com> said:
> > wgowcher> a 23 % reduction in the Floating Point Index benchmark
> >
> > Current CVS kernel uses FPU emulator unconditionally.  If one floating
> > point intruction causes a 'Unimplemented' exception (denormalized
> > result, etc.) following floating point instructions are also handle by
> > FPU emulator (not only the instruction which raise the exception).
> >
> > I do not know this is really desired behavior, but here is a patch to
> > change this.  If Unimplemented exception had been occured during the
> > benchmark, aplying this patch may result better performance.
>
> This is a know problem with the emulator.  It may be used to keep the
> emulator in kernel for a long time or even maliciously to keep the
> CPU in the kernel for an unbounded time.
>
> Here's my suggested fix:
>
> Index: arch/mips/math-emu/cp1emu.c
> ===================================================================
> RCS file: /home/pub/cvs/linux/arch/mips/math-emu/cp1emu.c,v
> retrieving revision 1.7
> diff -u -r1.7 cp1emu.c
> --- arch/mips/math-emu/cp1emu.c 2001/08/02 21:55:26     1.7
> +++ arch/mips/math-emu/cp1emu.c 2001/08/16 09:06:55
> @@ -1672,6 +1672,9 @@
>
>         oldepc = xcp->cp0_epc;
>         do {
> +               if (current->need_resched)
> +                       break;
> +
>                 prevepc = xcp->cp0_epc;
>                 insn = mips_get_word(xcp, REG_TO_VA(xcp->cp0_epc), &err);
>                 if (err) {
>
>   Ralf

What is probably needed too, but I still think we need the check for real FPU, so we only
emulate one instruction at a time, if we got a real FPU.


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
