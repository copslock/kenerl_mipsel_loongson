Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5O9sZnC023430
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 02:54:35 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5O9sZHO023429
	for linux-mips-outgoing; Mon, 24 Jun 2002 02:54:35 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-49.ka.dial.de.ignite.net [62.180.196.49])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5O9sUnC023423
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 02:54:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5O9sqj25187;
	Mon, 24 Jun 2002 11:54:52 +0200
Date: Mon, 24 Jun 2002 11:54:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
Message-ID: <20020624115452.A25138@dea.linux-mips.net>
References: <3D16E14C.5C8D2FAD@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D16E14C.5C8D2FAD@mips.com>; from carstenl@mips.com on Mon, Jun 24, 2002 at 11:07:24AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 11:07:24AM +0200, Carsten Langgaard wrote:

> The 'sys_syscall' syscall isn't properly implemented in the 64-bit
> kernel (for o32 as well as n64).
> Below is a patch, it seems to work for in the o32 case, but I haven't
> tested the n64 version (obviously).

> +/*
> + * Do the indirect syscall syscall.
> + * Don't care about kernel locking; the actual syscall will do it.
> + *
> + * XXX This is broken.
> + */

As the comment says - it's broken.  This implementation just like it's
32-bit predecessor don't handle the error return value correctly.  Worse,
there's unprotected accesses to userspace which allow any user crashing
the system ...

  Ralf
