Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OAOOnC024031
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 03:24:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OAOO0L024030
	for linux-mips-outgoing; Mon, 24 Jun 2002 03:24:24 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-49.ka.dial.de.ignite.net [62.180.196.49])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OAOJnC024027
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 03:24:20 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5OAOoW25677;
	Mon, 24 Jun 2002 12:24:50 +0200
Date: Mon, 24 Jun 2002 12:24:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
Message-ID: <20020624122450.A25659@dea.linux-mips.net>
References: <3D16E14C.5C8D2FAD@mips.com> <20020624115452.A25138@dea.linux-mips.net> <3D16EF3C.BCCB020@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D16EF3C.BCCB020@mips.com>; from carstenl@mips.com on Mon, Jun 24, 2002 at 12:06:52PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 12:06:52PM +0200, Carsten Langgaard wrote:

> 
> At least it makes my system work as well as for the 32-bit kernel.

What programs btw are using syscall()?  To be honest I don't recall one ...

Looking more into it I found a nice showstopper - a few functions like
_sys_sigsuspend() expect a struct pt_regs on the stack.  That's only
working if we call those functions directly from the exception handler.
It won't work if we have another function's stackframe - in this case
sys_syscall()'s there also ...

  Ralf
