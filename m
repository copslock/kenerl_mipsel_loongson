Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JB56nC015209
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 04:05:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JB56mV015208
	for linux-mips-outgoing; Wed, 19 Jun 2002 04:05:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JB4unC015193;
	Wed, 19 Jun 2002 04:04:57 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id EAA20211;
	Wed, 19 Jun 2002 04:07:48 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA00374;
	Wed, 19 Jun 2002 04:07:47 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5JB7kb03497;
	Wed, 19 Jun 2002 13:07:46 +0200 (MEST)
Message-ID: <3D106601.2347EECC@mips.com>
Date: Wed, 19 Jun 2002 13:07:46 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Justin Carlson <justin@cs.cmu.edu>, linux-mips@oss.sgi.com
Subject: Re: 64-bit kernel
References: <3D0F28AE.7B0D822B@mips.com> <1024416198.1166.1.camel@xyzzy.rlson.org> <20020619113244.B22048@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm trying to compile glibc natively using my 64-bit kernel, but it fails with
the following message:

Out of Memory: Killed process 641 (qmgr).
Out of Memory: Killed process 642 (tlsmgr).
Out of Memory: Killed process 378 (portmap).
Out of Memory: Killed process 9363 (cc1).
Out of Memory: Killed process 9363 (cc1).

So there may be a memory leak problem in 64-bit kernel.
Has anyone seen this ?

/Carsten


Ralf Baechle wrote:

> On Tue, Jun 18, 2002 at 09:03:18AM -0700, Justin Carlson wrote:
>
> > On Tue, 2002-06-18 at 05:33, Carsten Langgaard wrote:
> > > I don't know if anymore has a interest in the 64-bit kernel, but I just
> > > found this bug (see patch below).
> > > It would be nice to know, how many are interested in the 64-bit kernel
> > > and who actually got something running.
> > > So please rise you voice.
> >
> > Been running 64-bit stuff here, but nothing even remotely fpu intensive.
> > It's quite possible we'd never run into this case.
>
> At this time probably most 64-bit kernels are running on a certain 64-bit
> CPU with it's hardware fp disabled so nobody ever saw this one.
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
