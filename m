Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5I7fRnC009476
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 18 Jun 2002 00:41:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5I7fR6Z009475
	for linux-mips-outgoing; Tue, 18 Jun 2002 00:41:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5I7fMnC009472
	for <linux-mips@oss.sgi.com>; Tue, 18 Jun 2002 00:41:22 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id AAA10991;
	Tue, 18 Jun 2002 00:44:03 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA00107;
	Tue, 18 Jun 2002 00:44:05 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5I7i5b05666;
	Tue, 18 Jun 2002 09:44:05 +0200 (MEST)
Message-ID: <3D0EE4C5.99F67A43@mips.com>
Date: Tue, 18 Jun 2002 09:44:05 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Carlson <justin@cs.cmu.edu>
CC: linux-mips@oss.sgi.com
Subject: Re: __access_ok
References: <3D0DCDCB.252F5565@mips.com> <1024331098.1463.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Note, that this is in the 64-bit kernel, a size there the high bit is set,
will be astronomical and not a true value.

/Carsten

Justin Carlson wrote:

> On Mon, 2002-06-17 at 04:53, Carsten Langgaard wrote:
>
> >   * Address valid if:
> > - *  - "addr" doesn't have any high-bits set
> > - *  - AND "size" doesn't have any high-bits set
> > - *  - AND "addr+size" doesn't have any high-bits set
> > - *  - OR we are in kernel mode.
> > + *  - In user mode and "addr" and "addr+size" in USEG (or XUSEG).
> > + *  - OR we are in kernel mode and "addr" and "addr+size" isn't in the
> > + *    area between USEG (XUSEG) and KSEG0.
>
> You also need to test for high bit set in size.  Otherwise, for example,
> if a process was ok to access range 0x40000000-0x40003fff,
> access_ok(0x40001000, 0xfffff100) would return 1.  The addition will
> wrap around, leading to all sorts of fun havoc.
>
> -Justin

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
