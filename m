Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BIOhX28557
	for linux-mips-outgoing; Fri, 11 Jan 2002 10:24:43 -0800
Received: from orion.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BIObg28554;
	Fri, 11 Jan 2002 10:24:37 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id JAA10178;
	Fri, 11 Jan 2002 09:23:46 -0800
Date: Fri, 11 Jan 2002 09:23:46 -0800
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] disable interrupt for non-LLSC atomic set
Message-ID: <20020111092346.C32345@mvista.com>
References: <3C3E458A.B2AEC3CA@mvista.com> <Pine.GSO.3.96.1020111115109.11015A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020111115109.11015A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 11, 2002 at 11:54:24AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 11, 2002 at 11:54:24AM +0100, Maciej W. Rozycki wrote:
> On Thu, 10 Jan 2002, Jun Sun wrote:
> 
> > The current MIPS_ATOMIC set code for no-LLSC case does a load and store with
> > interrupt open.  This is potentially dangerous as an interrupt could happen
> > in-between and cause the value changed inside the interrupt handler. 
> 
>  No need to -- no sane interrupt handler will ever access a user's atomic
> variable. 
>

OK, I have to reveal the secret desire :-).  I have a patch
that makes MIPS kernel preemptible, and that unprotected operation
becomes very volunerable with the preemptible patch.

Jun
