Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA627ZV00953
	for linux-mips-outgoing; Mon, 5 Nov 2001 18:07:35 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA627V000950
	for <linux-mips@oss.sgi.com>; Mon, 5 Nov 2001 18:07:31 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fA628XB30954;
	Mon, 5 Nov 2001 18:08:33 -0800
Subject: Re: Arguments for kernel_entry?
From: Pete Popov <ppopov@mvista.com>
To: Richard Hodges <rh@matriplex.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <Pine.BSF.4.10.10111051736110.600-100000@mail.matriplex.com>
References: <Pine.BSF.4.10.10111051736110.600-100000@mail.matriplex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.01.15.16 (Preview Release)
Date: 05 Nov 2001 18:07:54 -0800
Message-Id: <1005012474.27128.306.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2001-11-05 at 17:44, Richard Hodges wrote:
> On 5 Nov 2001, Pete Popov wrote:
> 
> > On Mon, 2001-11-05 at 17:09, Richard Hodges wrote:
> > > Would anyone be able to provide information on the arguments
> > > to kernel_entry (in head.S)?
> > > 
> > > The first two look pretty straightforward, argument count and
> > > string vectors.  I assume that argument zero is actually the
> > > first argument, and not "vmlinux"?
> > > 
> > > What are the third (ulong) and fourth (int *) arguments?  I have
> > > read head.S and searched for days trying to find this info :-(
> > > 
> > > I thought PMON would be a decent reference, but run_target() only
> > > seems to set $4 and $5, before calling _go().
>  
> > That's boot code specific. MIPS Tech's yamon passes:
> > 
> > 0: number of arguments
> > 1: pointer to first arg
> > 2: pointer to environment variables
> > 3: pointer to prom routines you can call
> 
> Okay, I think I have it now.  It looks like _only_ prom_init() is
> interested in these arguments.
> 
> 1.  kernel_entry() gives them to init_arch(),
> 2.  init_arch gives them to prom_init(),
> 3.  prom_init() does whatever it wants (eg, builds arcs_cmdline)
> 4.  init_arch ends with a call to start_kernel(), and the original
>     arguments are effectively thrown away.
> 
> Or put more simply, the kernel_entry arguments are only used by
> prom_init().  Is this right?

I believe that's correct. arch/mips/kernel/setup.c saves arcs_cmdline in
command_line and that's the end of arcs_cmdline. 

Pete
