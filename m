Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQAMtT14543
	for linux-mips-outgoing; Mon, 26 Nov 2001 02:22:55 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAQAMoo14537
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 02:22:50 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA07867;
	Mon, 26 Nov 2001 01:22:43 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA01000;
	Mon, 26 Nov 2001 01:22:39 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fAQ9McA14893;
	Mon, 26 Nov 2001 10:22:39 +0100 (MET)
Message-ID: <3C0209E0.43747D9E@mips.com>
Date: Mon, 26 Nov 2001 10:22:40 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: FPU test on RedHat7.1
References: <3BFD1BA7.C4490465@mips.com> <20011122103930.A2007@lucon.org> <3BFE6327.986D490C@mips.com> <20011124112547.A22621@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Fri, Nov 23, 2001 at 03:54:31PM +0100, Carsten Langgaard wrote:
> > The file sysdeps/ieee754/dbl-64/e_remainder.c seems to have changed since
> > glibc-2.2.2.
> > I have attached the glibc-2.2.2 remainder file, which seems to work
> > better.
> >
>
> I believe it is a MIPS FPU related issue. glibc tries to do
>
> 1.7976931348623157e+308 - 8.5720688574901386e+301 * 2097152
>
> and expects -1.9958403095e+292. However, on mips, I got -inf. Could you
> please look into it?

I believe this is ok, 8.5720688574901386e+301 * 2097152 is greater than
1.7976931348623157e+308 (which is the highest floating point number you can
represent).
So 1.7976931348623157e+308 - 8.5720688574901386e+301 * 2097152 do give -Inf on
(I guess) all other architectures than i386, which have a double extended (80
bit / 64 bit mantisse) precision.

I have tried the same calculation on a Sun (Sparc) and it also gives -Inf.
So I guess the problem is in the e_remainder function.


>
> Thanks.
>
> H.J.
>
>   ------------------------------------------------------------------------
>
>    ieee.cName: ieee.c
>          Type: Plain Text (text/plain)

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
