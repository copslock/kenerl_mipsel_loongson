Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35KY2T05890
	for linux-mips-outgoing; Thu, 5 Apr 2001 13:34:02 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35KY2M05887
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 13:34:02 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f35KUC010152;
	Thu, 5 Apr 2001 13:30:12 -0700
Message-ID: <3ACCD599.1765FCB2@mvista.com>
Date: Thu, 05 Apr 2001 13:29:13 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com> <20010403203055.A17365@foobazco.org> <3ACB5FD8.6B166BA6@mvista.com> <20010405004618.A30899@foobazco.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith M Wesolowski wrote:
> 
> So we basically have an Indy-style boardcache then.  I think we must
> make a distinction very cleanly between caches which are under CPU
> control and those which are not.  The ones under CPU control use the
> stuff in load_cache and the cache descriptors in mips_cpu.  The
> boardcaches use something like bc_ops. 

I don't like bc_ops idea.  Usually the external cache capability is still
integral part of the CPU.

I favor the idea where the cache takes care of external cache dynamically,
based on some parameters set up by board detection routine.

> 
> Now if only the linux requirements for implementing pci on a new
> machine were documented somewhere...
> 

That should come soon ...

Jun
