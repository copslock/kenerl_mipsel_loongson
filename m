Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f357kQo09287
	for linux-mips-outgoing; Thu, 5 Apr 2001 00:46:26 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f357kPM09284
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 00:46:25 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 791CA109DD; Thu,  5 Apr 2001 00:46:19 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 873E21F429; Thu,  5 Apr 2001 00:46:18 -0700 (PDT)
Date: Thu, 5 Apr 2001 00:46:18 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
Message-ID: <20010405004618.A30899@foobazco.org>
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com> <20010403203055.A17365@foobazco.org> <3ACB5FD8.6B166BA6@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACB5FD8.6B166BA6@mvista.com>; from jsun@mvista.com on Wed, Apr 04, 2001 at 10:54:32AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 04, 2001 at 10:54:32AM -0700, Jun Sun wrote:

> On a minor note, pretty much all existing r4k and above CPUs (I
> believe) can share the same cache code if 1) number of ways and 2)
> way selection offset are introduced.  All the diverging in cache
> code comes from the difference in how the way in a cache set is
> specified in indexed operations.

So we introduce the waybit member into struct cache (where it belongs
anyway).  That was easy.

> I am not sure if load_cache() can handle that by itself.
> 
> Load_cache() is affiniated with cpu.  The external cache info is associated
> with machine.

So we basically have an Indy-style boardcache then.  I think we must
make a distinction very cleanly between caches which are under CPU
control and those which are not.  The ones under CPU control use the
stuff in load_cache and the cache descriptors in mips_cpu.  The
boardcaches use something like bc_ops.  The generic cacheflushing
operations can then simply have hooks to call the appropriate bcop.
This wastes time on sane hardware, so any machine that has this must
set CONFIG_STUPID_CACHE.  Without that the call is ifdef'd out.  Yes,
I hate ifdefs but there's no reason that everyone should suffer just
because some hardware is braindead.

There is another way.  I hate to suggest it because it's pure
evil...look at the sparc btfixup code some time.  We could actually
use something similar for all our caches if we wanted to.

> figure out that on the other board.  Obviously you will need some sort of
> #ifdef to do that.  Then you need to consider what if both machines are
> configured in.

If both machines are configured in, what gets done depends on which is
detected at boot time.

> For that and some other purposes, I am convinced we need to *know* exactly
> what machine we are on.  I understand some machine cannot detect itself.  Too
> bad!  That just means that machine CANNOT be configured into a multi-machine
> kernel.  It should be trivial to detect that (possibly through the return
> value of <board>_detect() routine).

This is exactly what the documentation says.  I am pretty sure that
any machine can be detected uniquely.  The important thing is that it
can be detected without the detection routine crashing other systems.
If for some reason it's not possible for a given machine (*cough* ip27
*cough*) to live with the others - ifdefs in head.S let's say - then
that config option is exclusive.  Simple.

All of this is details anyway.  The big problems we have aren't in the
code - structs filled with function pointers are child's play to
implement and use.  Our problem is that it seems like about 80% of
linux is implemented as inline functions in header files.  Some of
these have lots of nasty ifdefs around them.  Then there are lovely
things like the address space macros which are cpu dependent.  Or
SERIAL_PORT_DFNS, which seems specifically intended to thwart efforts
to support multiple machines.  And, finally, we have things like pref
which must not be used if *any* cpu configured in does not support it
(or, it must be overwritten by bootup code with nop if it's not
supported *shudder*).

There's the plain and simple fact that more dynamic detection is going
to slow the kernel down.  That's not going to sit well with the origin
folks for example.  So care needs to be taken to make sure that the
performance penalties are small and more than offset by ease of
maintenance.  And from what I've heard about the irix code, people
working on it probably aren't likely to be impressed by things like
maintainability.

For people building new machines targeting linux - this is important -
you can arrange for the prom to pass arguments; these will be passed
to the detection routine (in fact, they will get whatever is in a0,
a1, and a2).  Someone who wanted to make his or her life easy would
arrange to pass "mips_machine=fuxinator2000" in argv somewhere and
just test that.  Or, read from some address in the PROM (ARC[S] does
this) to find the name of your machine where the firmware designers
thoughtfully placed it.  Since the whole point of this exercise is
easier support and maintenance for new hardware, this seems like the
most obvious possible way to solve the problem.  If some oddball
system made 8 years ago can't be detected cleanly, so what.

> /* invoked at the very beginning of init_arch() */
> void mips_machine_detection()
...

That's pretty much what the code does.  There is an array of probing
functions.  They are tried in succession in known but undefined order.
Any which succeeds (indicated by returning 1) is expected to have set
up the machine-specific functions.  These probes must return 0 if
support for the given system is not compiled in.

> If we do it right, I think this pretty much the *ONLY* source file one needs
> to modify when one adds support for a new machine/board.  (hmm, am I dreaming
> again?)

Pretty much.  In my implementation there are actually two places - the
probe function itself and adding it to the list.  See the
documentation.  I am also making an effort to document exactly what
other functions are mandatory and what are optional.  In the end a
poorly-trained but literate monkey with a mild psychiatric disorder
should be able to handle a port of mips/linux to a new piece of
hardware.

Now if only the linux requirements for implementing pci on a new
machine were documented somewhere...

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
