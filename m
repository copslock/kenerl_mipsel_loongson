Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g656QxRw000890
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 4 Jul 2002 23:26:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g656Qx4O000889
	for linux-mips-outgoing; Thu, 4 Jul 2002 23:26:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g656QnRw000880;
	Thu, 4 Jul 2002 23:26:49 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.5/8.12.5) with ESMTP id g656Um8j008525;
	Thu, 4 Jul 2002 23:30:48 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA04088;
	Thu, 4 Jul 2002 23:30:48 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g656Umb20658;
	Fri, 5 Jul 2002 08:30:48 +0200 (MEST)
Message-ID: <3D253D18.3BE59AED@mips.com>
Date: Fri, 05 Jul 2002 08:30:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Jul 04, 2002 at 08:18:41PM +0200, Carsten Langgaard wrote:
>
> > > any power of 2 > PAGE_SIZE.
> >
> > Ok, I see, but is there any reason for us to be different than the
> > rest of the world ?
>
> Imho the your question already wrong :-)  Any assumption about the
> constant's value in a piece of code is wrong.
>
> The reason why the constant's value was choosen are virtually indexed
> caches.  The value allows attaching of shared memory segment without
> any cache flushes.
>
> Other architectures also use different values from PAGE_SIZE like IA64 1MB,
> SH 16kB and Sparc not even a constant value accross all architectures
> variants, so unlike what your posting implicates we're not that unusual.

Using PAGE_SIZE is ok, even though it may differ from different architecture,
because SHMLBA is defined as the following in /usr/include/sys/shm.h:
#define SHMLBA          (__getpagesize ())

So I would expect the user application and the kernel should have the same
idea of what the size is.

>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
