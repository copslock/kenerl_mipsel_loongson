Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FKBjnC009442
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 13:11:45 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FKBjl7009441
	for linux-mips-outgoing; Sat, 15 Jun 2002 13:11:45 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from crack.them.org (mail@crack.them.org [65.125.64.184])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FKBgnC009433
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 13:11:42 -0700
Received: from drow by crack.them.org with local (Exim 3.12 #1 (Debian))
	id 17JJw6-0004yp-00; Sat, 15 Jun 2002 15:14:14 -0500
Date: Sat, 15 Jun 2002 15:14:13 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Justin Wojdacki <justin.wojdacki@analog.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Debugging using GDB and gdbserver
Message-ID: <20020615151413.A19123@crack.them.org>
References: <3D0B9D14.BFE27F7E@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D0B9D14.BFE27F7E@analog.com>; from justin.wojdacki@analog.com on Sat, Jun 15, 2002 at 01:01:24PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 15, 2002 at 01:01:24PM -0700, Justin Wojdacki wrote:
> 
> How does GDB work under MIPS Linux? I'm trying to do a bring-up of an
> embedded device, and it looks like the kernel is missing the code
> needed to handle software breakpoints. Are there patches that need to
> be applied to the kernel? 

No.  If you use a current GDB (I recommend 5.2 or CVS) it should work
just fine, if you are using a recent kernel (you didn't mention what
version you were looking at).

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
