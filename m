Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OAhcnC024335
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 03:43:38 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OAhc2E024333
	for linux-mips-outgoing; Mon, 24 Jun 2002 03:43:38 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OAhVnC024303;
	Mon, 24 Jun 2002 03:43:31 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA11194;
	Mon, 24 Jun 2002 03:46:44 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA00068;
	Mon, 24 Jun 2002 03:46:43 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g5OAkgb21113;
	Mon, 24 Jun 2002 12:46:42 +0200 (MEST)
Message-ID: <3D16F891.78A333BA@mips.com>
Date: Mon, 24 Jun 2002 12:46:41 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
References: <3D16E14C.5C8D2FAD@mips.com> <20020624115452.A25138@dea.linux-mips.net> <3D16EF3C.BCCB020@mips.com> <20020624122450.A25659@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Jun 24, 2002 at 12:06:52PM +0200, Carsten Langgaard wrote:
>
> >
> > At least it makes my system work as well as for the 32-bit kernel.
>
> What programs btw are using syscall()?  To be honest I don't recall one ...

/sbin/rpc.lockd.
It use syscall() to indirectly call the 'sys_nfsservctl' syscall, why it
doesn't do the syscall directly is beyond me.


>
> Looking more into it I found a nice showstopper - a few functions like
> _sys_sigsuspend() expect a struct pt_regs on the stack.  That's only
> working if we call those functions directly from the exception handler.
> It won't work if we have another function's stackframe - in this case
> sys_syscall()'s there also ...
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
