Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9U9HVJ14283
	for linux-mips-outgoing; Tue, 30 Oct 2001 01:17:31 -0800
Received: from dea.linux-mips.net (a1as08-p129.stg.tli.de [195.252.188.129])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9U9HQ014280
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 01:17:27 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9U9H9E09362;
	Tue, 30 Oct 2001 10:17:09 +0100
Date: Tue, 30 Oct 2001 10:17:09 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: tommy.christensen@eicon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Fixup in unaligned.c
Message-ID: <20011030101709.A3816@dea.linux-mips.net>
References: <3BDD5B31.E12DE812@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDD5B31.E12DE812@eicon.com>; from tommy.christensen@eicon.com on Mon, Oct 29, 2001 at 02:35:45PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 29, 2001 at 02:35:45PM +0100, tommy.christensen@eicon.com wrote:

> It seems we don't always handle bad user-mode pointers correctly.
> If put_user is called with an unmapped AND unaligned address it
> kills the current process instead of returning EFAULT.
> 
> The reason for this is that we do compute_return_epc() in do_ade()
> before the exception table is searched, so we never get a match.

The missplaced branch emulation is a known problem in basically all of our
execption handers that have to emulate branches in software.  It also
effects ptrace; it is possible that a debugger already observes the new epc
after the branch has been executed but the instruction in the delay slow
wasn't due to some problem like a page fault.

> Below is a simple patch to fix it (attached as well).
> The second part is not related, but it makes sense to only consult
> the MF_FIXADE flag on exceptions originating from user-mode, right?

That's actually an evil one from which local DoS attacks can be constructed.

  Ralf
