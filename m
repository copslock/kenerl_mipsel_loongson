Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34HxKL26351
	for linux-mips-outgoing; Wed, 4 Apr 2001 10:59:20 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34HxJM26348
	for <linux-mips@oss.sgi.com>; Wed, 4 Apr 2001 10:59:19 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f34HtT019009;
	Wed, 4 Apr 2001 10:55:29 -0700
Message-ID: <3ACB5FD8.6B166BA6@mvista.com>
Date: Wed, 04 Apr 2001 10:54:32 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith M Wesolowski <wesolows@foobazco.org>
CC: linux-mips@oss.sgi.com
Subject: Re: RFC: Cleanup/detection patch
References: <20010401235212.B9737@foobazco.org> <3ACA8A3B.8BBABB11@mvista.com> <20010403203055.A17365@foobazco.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Keith M Wesolowski wrote:
> 
> On Tue, Apr 03, 2001 at 07:43:07PM -0700, Jun Sun wrote:
> 
> > 1. Right now, our tree (at least 32-bit) does not even support multiple CPUs
> > (with the same machine/board).  Take a look of
> > arch/mips/mm/loadmmu.c:loadmmu(), and you will see what I mean.  The CPU
> > specific ld_mmu_xxx is #ifdef'ed.  So if you enable multiple CPU, the last
> > ld_mmu_xxx will win!
> >
> > So a modest step forward would be fixing that first.
> 
> In the patch, the mips_cpu structure has a load_cache and load_tlb
> function associated with it which are assigned during cpu_probe.  It
> is now possible - I believe - to compile both andes.c and r4k* into
> the kernel and have the right routines run at boot time.  No reason
> this can't work for other CPUs also.
> 
> > 2. Currently all CPU specific ld_mmu_xxx stuff lump cache and TLB together.
> > That is not very good.  I have seen CPUs that can share cache but not TLB.
> > Vice versa.  Personally I like to see their separation first before a more
> > dramatic scheme is in place.
> 
> The patch addresses this; look at the removal of r4xx0.c and its
> replacements.  It's been split into four pieces - this may become
> three later.  One for cache, one for tlb, one for copy/clear page and
> miscellaneous outlined assembly (yes, in real assembly), and one for
> initialization functions.  There's no reason it couldn't be further
> split; for example, to do r4600/r5k style caches in a separate module.
> 

Cool - this seems to be in the line I was thinking of.

On a minor note, pretty much all existing r4k and above CPUs (I believe) can
share the same cache code if 1) number of ways and 2) way selection offset are
introduced.  All the diverging in cache code comes from the difference in how
the way in a cache set is specified in indexed operations.

I think current mips_cpu struct already logs number of ways.  We just need to
introduce the constant offset for way selection.


> > 3. Unfortunally not all CPUs can be fully probed at the run-time,
> > specifically the external cache size and geometry.  I was thinking
> > perhaps a board detection routine should be placed at the beginning
> > which will supply external
> 
> The CPU-specific load_cache is responsible for this.  I'm open to the
> idea of having separate cache detection for cache problems that are
> *not* cpu-specific.  For example, if r10k indy with boardcache existed
> that might be applicable.  But I think the load_cache should be able
> to handle this.
>

I am not sure if load_cache() can handle that by itself.

Load_cache() is affiniated with cpu.  The external cache info is associated
with machine.

For example, on the ocelot board I am working on you need to read a
board-specific register to get 3rd level cache config.  Presummably if the the
same Rm7k cpu is used another board, the load_cache_rm7k() has to know how to
figure out that on the other board.  Obviously you will need some sort of
#ifdef to do that.  Then you need to consider what if both machines are
configured in.

Does not look very clean to me.

For that and some other purposes, I am convinced we need to *know* exactly
what machine we are on.  I understand some machine cannot detect itself.  Too
bad!  That just means that machine CANNOT be configured into a multi-machine
kernel.  It should be trivial to detect that (possibly through the return
value of <board>_detect() routine).

Anyhow, I am thinking about something like below:

/* invoked at the very beginning of init_arch() */
void mips_machine_detection()
{
#if defined(CONFIG_DDB5476)
   retval = ddb5476_detect();
   /* check retval - 0: negative; 1: possitive; 2: cannot detect, possitive by
config only */
#endif
#if defined(CONFIG_SNI)
   retval = sni_detect();
   /* check for ret val conflict */
#endif
....

   /* check if we at least detect one valid machine */
   return;
}

If we do it right, I think this pretty much the *ONLY* source file one needs
to modify when one adds support for a new machine/board.  (hmm, am I dreaming
again?)

Jun
