Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJML4V06346
	for linux-mips-outgoing; Wed, 19 Dec 2001 14:21:04 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJMKvX06329
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 14:20:57 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBJLJ8B13293;
	Wed, 19 Dec 2001 13:19:08 -0800
Subject: Re: kmalloc/pci_alloc and skbuff's
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
   "Gleb O. Raiko"
	 <raiko@niisi.msk.ru>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20011219115318.A12344@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru>
	<Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com>
	<20011219105633.B54722@idiom.com> <1008789145.31066.140.camel@zeus> 
	<20011219115318.A12344@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 13:23:08 -0800
Message-Id: <1008796988.31046.150.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 2001-12-19 at 11:53, Geoffrey Espin wrote:
> 
> > > Currently, my private pci_alloc/free_consistent() routines manage
> 
> > FYI, this is not an isolated issue. We deal with a number of
> > architectures and we've seen this problem with other arches and system
> > controllers as well. A 'generic' solution would be nice and probably
> > necessary at some point. 2.5 would be a good place to do it, if only
> > someone would volunteer ;-)   [Pete]
> 
> Thanks for the reassurance.
> 
> Can one include one's own arch/mips/korva/skbuff.c?
> But with network.o being a monolithic blob .o instead of a .a,
> seems like patching the one file is not feasible.
> I tried tweaking $(HEAD) but then stumbled onto this.
 
> How does one package such a work-around?  Include a patch file in
> the LSP, which gets automatically run to munge on kernel sources?

If you mean MontaVista's LSP, they are built from an internal source
tree, so in some sense we can do whatever we want -- at least until we
implement the right solution. It's not something you want to do though
because carrying patches with you does not scale well.   The best
approach in the long run is to do it right and push it out to the
community tree asap.  The problem, of course, is that if you yourself
wanted to do it right, but it was going to take a while, the company
you're consulting for might not want to pay for such general linux work.
 
> Or will linux-mips.sf.net accept a patch for net/core/skbuff.c?

Up the the maintainer, but it's really not the right fix so I think it's
best for you or your customer to keep that patch locally.

Another approach would be for you to preallocate your network buffers in
your driver, attach them permanently to the rx/tx descriptors, and then
copy the data from the buffer to a newly allocated skbuff, when you
receive, and the other way when you transmit.  There's a performance
penalty there, especially for large packets, but you can encapsulate
everything within your driver and you won't have to maintain a patch.

Pete
