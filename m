Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H79nRw030642
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 00:09:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H79npa030641
	for linux-mips-outgoing; Wed, 17 Jul 2002 00:09:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H79ZRw030503;
	Wed, 17 Jul 2002 00:09:35 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6H7EMXb001476;
	Wed, 17 Jul 2002 00:14:22 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA08642;
	Wed, 17 Jul 2002 00:14:22 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6H7ELb29725;
	Wed, 17 Jul 2002 09:14:22 +0200 (MEST)
Message-ID: <3D35194D.E880DDDA@mips.com>
Date: Wed, 17 Jul 2002 09:14:21 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com,
   linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Add sys/personality (Re: Personality)
References: <3D33DAB2.353A4399@mips.com> <20020716123632.B17038@dea.linux-mips.net> <20020716090728.A22128@lucon.org> <3D347120.B9CAFF75@mips.com> <20020716190814.A31309@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H. J. Lu" wrote:

> On Tue, Jul 16, 2002 at 09:16:48PM +0200, Carsten Langgaard wrote:
> > Thanks.
> > Now that we are at it, what should personality return in case it's called with a
> > value, which isn't defined in the personality.h file.
> > Should it return -EINVAL ?
> > I don't think, that is the case at the moment, I believe you can set personality
> > to anything.
> >
>
> Like this?
>

No, I don't think the patch is correct.
I don't know how this actually should work, maybe someone who do know can help out
here.
But it look like the idea is, that we have a default execution domain (linux), which
have pers_low = 0 (PER_LINUX) and pers_high = 0.
If one want other execution domains, one much call the register_exec_domain to
register the execution domain and personality.
So if personality is call with a value that isn't register, it then accept the
personality and sets the execution domain to the default settings (which is linux).
So the question is should personality, return -EINVAL, if it got a personality value
which hasn't been registered or should it accept the personality, but set the
execution domain to the default setting ?
If the later is true, should it also accept values outside the values defined in the
personality.h file ?

So what should the following user calls return, if not registered in the kernel?

personality(PER_BSD):
personality(0x47):

Could someone with a better understand than I, please comment this.

>
> H.J.
> ---
> --- kernel/exec_domain.c.per    Mon Jun 10 10:05:27 2002
> +++ kernel/exec_domain.c        Tue Jul 16 19:06:13 2002
> @@ -223,7 +223,8 @@ sys_personality(u_long personality)
>
>         if (personality != 0xffffffff) {
>                 set_personality(personality);
> -               if (current->personality != personality)
> +               if (personality < current->exec_domain->pers_low
> +                   || personality > current->exec_domain->pers_high)
>                         return -EINVAL;
>         }
>

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
