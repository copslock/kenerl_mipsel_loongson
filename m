Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBRBrHF10213
	for linux-mips-outgoing; Thu, 27 Dec 2001 03:53:17 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBRBrAX10208;
	Thu, 27 Dec 2001 03:53:11 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA16016;
	Thu, 27 Dec 2001 02:53:01 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA16345;
	Thu, 27 Dec 2001 02:53:00 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fBRAqmA22869;
	Thu, 27 Dec 2001 11:52:48 +0100 (MET)
Message-ID: <3C2AFD8C.6BAA7F1@mips.com>
Date: Thu, 27 Dec 2001 11:53:00 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: an old FPU context corruption problem when signal happens
References: <3C21390A.FA23978D@mvista.com> <3C219A3B.6DA93A75@mips.com> <20011225044125.A16759@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Thu, Dec 20, 2001 at 08:58:51AM +0100, Carsten Langgaard wrote:
>
> > Are you sure this hasn't been fix in the latest sources (2.4.16) ?
> > I have send a patch to Ralf, which I believe solves a similar problem as
> > you describe below.
> >
> > Ralf have you applied the patch ?
>
> Well, I applied it but it's really broken as something can be.  Just an
> example:
>
> +       /*
> +        * FPU emulator may have it's own trampoline active just
> +        * above the user stack, 16-bytes before the next lowest
> +        * 16 byte boundary.  Try to avoid trashing it.
> +        */
> +       sp -= 32;
>
> So the whole thing needs some overhaul.
>

You are welcome to find a better way of handling a non-fpu instruction in the
delay slot of the fpu-branch instruction.
But until someone find a better solution (that works, in all situation), I
think we need this patch.


>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
