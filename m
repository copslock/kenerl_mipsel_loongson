Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA61j1w32651
	for linux-mips-outgoing; Mon, 5 Nov 2001 17:45:01 -0800
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA61iv032636
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 17:44:57 -0800
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id RAA01352;
	Mon, 5 Nov 2001 17:44:53 -0800 (PST)
	(envelope-from rh@matriplex.com)
Date: Mon, 5 Nov 2001 17:44:53 -0800 (PST)
From: Richard Hodges <rh@matriplex.com>
To: Pete Popov <ppopov@mvista.com>
cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Arguments for kernel_entry?
In-Reply-To: <1005009677.27128.300.camel@zeus>
Message-ID: <Pine.BSF.4.10.10111051736110.600-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 5 Nov 2001, Pete Popov wrote:

> On Mon, 2001-11-05 at 17:09, Richard Hodges wrote:
> > Would anyone be able to provide information on the arguments
> > to kernel_entry (in head.S)?
> > 
> > The first two look pretty straightforward, argument count and
> > string vectors.  I assume that argument zero is actually the
> > first argument, and not "vmlinux"?
> > 
> > What are the third (ulong) and fourth (int *) arguments?  I have
> > read head.S and searched for days trying to find this info :-(
> > 
> > I thought PMON would be a decent reference, but run_target() only
> > seems to set $4 and $5, before calling _go().
 
> That's boot code specific. MIPS Tech's yamon passes:
> 
> 0: number of arguments
> 1: pointer to first arg
> 2: pointer to environment variables
> 3: pointer to prom routines you can call

Okay, I think I have it now.  It looks like _only_ prom_init() is
interested in these arguments.

1.  kernel_entry() gives them to init_arch(),
2.  init_arch gives them to prom_init(),
3.  prom_init() does whatever it wants (eg, builds arcs_cmdline)
4.  init_arch ends with a call to start_kernel(), and the original
    arguments are effectively thrown away.

Or put more simply, the kernel_entry arguments are only used by
prom_init().  Is this right?

Thanks!

-Richard
