Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4VIf8nC011414
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 11:41:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4VIf8oq011413
	for linux-mips-outgoing; Fri, 31 May 2002 11:41:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from potter.sfbay.redhat.com (IDENT:root@potter.sfbay.redhat.com [205.180.83.107])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4VIevnC011376
	for <linux-mips@oss.sgi.com>; Fri, 31 May 2002 11:40:57 -0700
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g4VIeHv03645;
	Fri, 31 May 2002 11:40:19 -0700
Subject: Re: [Fwd: Current state of MIPS16 support?]
From: Eric Christopher <echristo@redhat.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Johannes Stezenbach <js@convergence.de>, gcc@gcc.gnu.org,
   linux-mips@oss.sgi.com, sde@algor.co.uk
In-Reply-To: <15566.28397.770794.272735@gladsmuir.algor.co.uk>
References: <3CBFEAA9.9070707@algor.co.uk> 
	<15566.28397.770794.272735@gladsmuir.algor.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 31 May 2002 11:40:29 -0700
Message-Id: <1022870431.3668.19.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

<I'm not sure if I ever sent this, so I apologize if you received it
twice>

Dominic, 

> > I have not looked at the Algorithmics code because I don't have
> > copyright on it...
> 
> We do publish our sources on our web server.  Not only are they GPL
> but we have a copyright assignment to the FSF in place (which I know
> was sent to Jim Wilson of Cygnus, albeit in 1993...)
> 
It's great that your changes do get out in one form or another. I'm
personally uncertain as to the nature of copyright and how it would
affect if I looked at your code and put it into the mainline sources -
so I haven't :) 

> We're operating from a baseline which was a Cygnus/RedHat "2.96"
> release made to MIPS Technologies in late 2000.  A snapshot from a
> contract which had run into some kind of dissension, it had some new
> MIPS16 support but it was very buggy (the regular 32-bit MIPS code
> generator, too).  It has some nice features, though, like the "Haifa"
> scheduler and the DFA extensions to machine descriptions for
> superscalar CPUs.
> 
I don't remember any new mips16 support, however, I do remember that the
work was quite old (more than 2 years now). MIPS32 support is quite a
bit better now, and with the acceptance of Vlad's DFA scheduler into
mainline the scheduling descriptions will be following shortly. 

> It's true we have not contributed patches lately.  We don't really
> have the resouces; our success rate used to be very low, and since
> we're not working around the developing 3.x sources the prospects seem
> even dimmer.
> 
The backend has changed a bit in the time, however, it hasn't changed so
much that the patches would be that difficult for you to bring forward.
I encourage you to reconsider contributing them. 

> We're working (with funding from MIPS Technologies) on building a
> toolchain which:
> 
> o Can build Linux kernel, libraries and applications alike;
> 
> o Is substantially more efficient than other GCC versions when
>   producing MIPS application ("MIPS/ABI", PIC) code;
> 
> o Will produce ugly-but-correct PIC code for MIPS16 functions, so
>   MIPS16 can be tested in a standard Linux environment;
> 
> o Operates to a known and documented ABI (even the forgotten details,
>   like gprof...)
> 
> (The modesty of those ambitions should be measured against the reality
> of today's Linux/MIPS...)
I'm not certain what you are actually fixing here as I've not seen any
descriptions of problems here. I'd love to fix any problems that you've
had reported in the mainline sources so that everyone can get the
benefit of the work you are doing. 


> It would be even more valuable if we could ensure that MIPS becomes a
> "first-class" architecture for the evolving GCC - but the latter
> surely is a big commitment for the core GCC group.
> 
I'm putting in a lot of effort to cleaning up the MIPS port and am
committed to the architecture. 

> It's a pity that the different priorities of various funders and
> developers mean that there is no baseline toolkit for Linux/MIPS, so
> that such resources as are available are frequently used to re-invent
> the wheel.
> 
> Anyone got any ideas how to make it better?
> 
The problem as I see it is that no one wants/cares to contribute their
changes back that they make, or at least file bug reports against the
problems that they have. Almost 90% of the bug reports I see are against
IRIX. People have to "re-invent the wheel" because the changes never
make it back into the official sources - everyone has their own one
offs. If we fix this then the work that all of the disparate groups are
doing will at least go toward a common goal. 

-eric 

-- 
A fire drill does not demand
a fire.
