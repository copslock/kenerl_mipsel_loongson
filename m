Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OBjWnC026213
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 04:45:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OBjWQG026212
	for linux-mips-outgoing; Mon, 24 Jun 2002 04:45:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-145.ka.dial.de.ignite.net [62.180.196.145])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OBjQnC026209
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 04:45:27 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5OBjnU27930;
	Mon, 24 Jun 2002 13:45:49 +0200
Date: Mon, 24 Jun 2002 13:45:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: sys_syscall patch.
Message-ID: <20020624134549.B27807@dea.linux-mips.net>
References: <3D16F891.78A333BA@mips.com> <Pine.GSO.3.96.1020624133501.22509K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020624133501.22509K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 24, 2002 at 01:38:27PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 01:38:27PM +0200, Maciej W. Rozycki wrote:

> > > What programs btw are using syscall()?  To be honest I don't recall one ...
> > 
> > /sbin/rpc.lockd.
> > It use syscall() to indirectly call the 'sys_nfsservctl' syscall, why it
> > doesn't do the syscall directly is beyond me.
> 
>  Hmm, shouldn't syscall() be a library wrapper?  I think we should kill
> sys_syscall(). 

It's in the kernel for no better reason than Risc/OS and IRIX having this
syscall.  Also the glibc syscall implementation was historically broken
wrt. syscall restarting and a few other subtilities.

  Ralf
