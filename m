Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g786udRw000870
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 7 Aug 2002 23:56:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g786ucwg000869
	for linux-mips-outgoing; Wed, 7 Aug 2002 23:56:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g786uMRw000858;
	Wed, 7 Aug 2002 23:56:22 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g786veXb019491;
	Wed, 7 Aug 2002 23:57:40 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA07942;
	Wed, 7 Aug 2002 23:57:43 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g786vhb02622;
	Thu, 8 Aug 2002 08:57:43 +0200 (MEST)
Message-ID: <3D521667.AE4FA491@mips.com>
Date: Thu, 08 Aug 2002 08:57:43 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: IPC syscall fixup (o32 conversion layer)
References: <Pine.GSO.3.96.1020807165108.18037F-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" wrote:

> On Wed, 7 Aug 2002, Carsten Langgaard wrote:
>
> > Here is a patch that fixes the ipc syscalls in the o32
> > wrapper/conversion routines.
> > Needed when running a 64-bit kernel on an o32 userland.
>
>  Hmm, this looks dubious:
>
> +#define AA(__x) ((unsigned long)((int)__x))
>
> You probably want either:
>
> ((unsigned long)((unsigned int)__x))
>
> or
>
> ((long)((int)__x)).
>
> Since you are using pointers, likely the latter.
>

A(__x) is returning a unsigned long, so I try to stick to that.
I need the (int) typecast to make sure things got sign extended.
So if you want to change it, please go for the latter ((long)(int)).
What about the rest of the patch ?


>
>  Sending patches within a mail's body would ease commenting them, BTW.  I
> had to copy and paste the line above manually -- with gpm it's not a big
> problem for a single line, but it gets tedious for larger chunks and gpm
> is not everywhere.

Ralf has asked me to send the patches as attachment, because I use Netscape
as my mailer.


>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
