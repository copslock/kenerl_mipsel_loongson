Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2002 13:32:02 +0100 (MET)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:34751 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S869807AbSLIMbu>;
	Mon, 9 Dec 2002 13:31:50 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB9CRkNf017282;
	Mon, 9 Dec 2002 04:27:46 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA06325;
	Mon, 9 Dec 2002 04:27:43 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB9CRfb12938;
	Mon, 9 Dec 2002 13:27:41 +0100 (MET)
Message-ID: <3DF48C3D.62E7B615@mips.com>
Date: Mon, 09 Dec 2002 13:27:41 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
References: <3DEF7087.B6DEA7EC@mips.com>
		<20021209051845.A31939@linux-mips.org>
		<3DF4629B.F377F711@mips.com> <15860.33900.117478.251574@gladsmuir.algor.co.uk>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:

> > > > The __access_ok macro in include/asm-mips64/uaccess.h and the
> > > > check_axs macro in arch/mips64/kernel/unaligned.c ... is a copy
> > > > from the 32-bit kernel...
> > > >
> > > > The area between USEG (XUSEG) and KSEG0 will in 64-bit
> > > > addressing mode generate an address error, if accessed.
>
> I'd like to be clear about the consequences of this.  Presumably the
> 'access_ok()' macro is used to check addresses which were (originally)
> provided by a user program's system call.
>
> Carsten, are you saying that if such an address is set to say 2**41 in
> a CPU supporting 40-bit user virtual addresses, that the kernel will
> crash?

Yes, that's the case.
It's been a while since I fixed it locally, but if I ran something like
crashme, I could end up, in a situation where the kernel tries (on the
behalf of the user) to access an address like 2**41 in a CPU supporting
40-bit user virtual addresses, which generate an address error and
because we are in kernel mode we die.


>
> If so, that seems to require a fix, even if we don't know a very
> efficient one.  But perhaps any problem is a bit more subtle than
> that?
>
> --
> Dominic Sweetman
> MIPS Technologies
> The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
> phone +44 1223 706205/fax +44 1223 706250/swbrd +44 1223 706200
> http://www.algor.co.uk

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
