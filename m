Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G7j6c16723
	for linux-mips-outgoing; Thu, 16 Aug 2001 00:45:06 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G7j4j16719
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 00:45:04 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA28991;
	Thu, 16 Aug 2001 00:44:52 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA14177;
	Thu, 16 Aug 2001 00:44:53 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f7G7hOa07187;
	Thu, 16 Aug 2001 09:43:32 +0200 (MEST)
Message-ID: <3B7B799B.BCFD1B5E@mips.com>
Date: Thu, 16 Aug 2001 09:43:23 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
References: <20010809215522.A1958@lucon.org>
		<20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:

> >>>>> On Mon, 13 Aug 2001 10:34:46 -0700 (PDT), Wayne Gowcher <wgowcher@yahoo.com> said:
> wgowcher> a 23 % reduction in the Floating Point Index benchmark
>
> Current CVS kernel uses FPU emulator unconditionally.  If one floating
> point intruction causes a 'Unimplemented' exception (denormalized
> result, etc.) following floating point instructions are also handle by
> FPU emulator (not only the instruction which raise the exception).

You got a point here, no need to emulate following floating point instructions, if one got
a real FPU.
But I think the check in the FP emulator should be a check if we got a real FPU, instead of
a counter.
We already has a flag for that in mips_cpu.options.
The check could be something like:

    if (mips_cpu.options & MIPS_CPU_FPU)
        break;



>
> I do not know this is really desired behavior, but here is a patch to
> change this.  If Unimplemented exception had been occured during the
> benchmark, aplying this patch may result better performance.
>
> ---
> Atsushi Nemoto
>
>   ------------------------------------------------------------------------
>                     Name: fpu_emu.patch
>    fpu_emu.patch    Type: Plain Text (Text/Plain)
>                 Encoding: 7bit

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
