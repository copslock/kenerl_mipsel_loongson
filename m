Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g117ie425133
	for linux-mips-outgoing; Thu, 31 Jan 2002 23:44:40 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g117iXd25130
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 23:44:33 -0800
Received: (qmail 12530 invoked from network); 1 Feb 2002 06:44:30 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <macro@ds2.pg.gda.pl>; 1 Feb 2002 06:44:30 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16WXR0-0003o3-00; Thu, 31 Jan 2002 23:44:30 -0700
Date: Thu, 31 Jan 2002 23:44:30 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.GSO.3.96.1020131215446.579H-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1020131180511.14195A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Thu, 31 Jan 2002, Maciej W. Rozycki wrote:

>  Hmm, wmb() is pretty clearly defined.  The current implementation does
> not enforce strict ordering and is thus incorrect.  Note that the R4400
> manual explicitly states a cached write can bypass an uncached one, hence
> the CPU may exploit weak ordering under certain circumstances.  The "sync" 
> instruction was specifically defined to avoid such a risk.

Yes, you are correct. I suppose *mb() must also work correctly with the
cache flush macros - didn't think about that one! 

I'm afraid I don't have any manuals for any of the MIPS chips just 3rd
party ones SB1, RM7K and SR71000 - which is why I have some many
odd questions. :>

> > No, a sync will still empty the write buffer. It may halt the pipeline for
> > many (~80 perhaps) cycles while posted write data is dumped to the system
> > controller.
> 
>  Then it's an implementation bug.  For a CPU in the UP mode "sync" is only
> defined to prevent write and read reordering -- there is nothing about
> flushing.

Did some more research + phoning.. RM7K is definately documented to dump
the write buffer on 'sync'. The RM7K guide even has an example (7.8.5)
where it implies that sync also forces a write back of any dirty cache
lines - gah! (Hard to belive though..)

Sandcraft tells me that sync only waits for outstanding reads on their
chips - so it is very cheap. Writebacks from cached and uncached writes
are never put out of program order. 

Sorry my viewpoint is skewed by this small sampling of processors :<

> You need an "mb()", since you are changing the access type, so you need to
> synchronize both kinds.

OK.

>  I don't understand what the purpose of the above code is, except that it
> wastes a cycle.  Please elaborate. 

There was a miscommunication on my part, please ignore it.

I hope Ralf accepts your patch, I think it will be good to have.

Jason
