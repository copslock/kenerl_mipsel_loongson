Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJKuhR01002
	for linux-mips-outgoing; Wed, 19 Dec 2001 12:56:43 -0800
Received: from idiom.com (root@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJKucX00999
	for <linux-mips@oss.sgi.com>; Wed, 19 Dec 2001 12:56:38 -0800
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id LAA42356;
	Wed, 19 Dec 2001 11:53:18 -0800 (PST)
Date: Wed, 19 Dec 2001 11:53:18 -0800
From: Geoffrey Espin <espin@idiom.com>
To: Pete Popov <ppopov@mvista.com>
Cc: James Simmons <jsimmons@transvirtual.com>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: kmalloc/pci_alloc and skbuff's
Message-ID: <20011219115318.A12344@idiom.com>
References: <3C205853.EE642541@niisi.msk.ru> <Pine.LNX.4.10.10112190903520.3562-100000@www.transvirtual.com> <20011219105633.B54722@idiom.com> <1008789145.31066.140.camel@zeus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <1008789145.31066.140.camel@zeus>; from Pete Popov on Wed, Dec 19, 2001 at 11:12:25AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > Currently, my private pci_alloc/free_consistent() routines manage

> FYI, this is not an isolated issue. We deal with a number of
> architectures and we've seen this problem with other arches and system
> controllers as well. A 'generic' solution would be nice and probably
> necessary at some point. 2.5 would be a good place to do it, if only
> someone would volunteer ;-)   [Pete]

Thanks for the reassurance.

Can one include one's own arch/mips/korva/skbuff.c?
But with network.o being a monolithic blob .o instead of a .a,
seems like patching the one file is not feasible.
I tried tweaking $(HEAD) but then stumbled onto this.

How does one package such a work-around?  Include a patch file in
the LSP, which gets automatically run to munge on kernel sources?

Or will linux-mips.sf.net accept a patch for net/core/skbuff.c?

Geoff
-- 
Geoffrey Espin espin@idiom.com
