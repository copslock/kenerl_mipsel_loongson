Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5RDpCQ14025
	for linux-mips-outgoing; Wed, 27 Jun 2001 06:51:12 -0700
Received: from dea.waldorf-gmbh.de (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id f5RDpAV14022
	for <linux-mips@oss.sgi.com>; Wed, 27 Jun 2001 06:51:10 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5RDnhK02604;
	Wed, 27 Jun 2001 15:49:43 +0200
Date: Wed, 27 Jun 2001 15:49:42 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4.5 and earlier: Mysterious lock-ups resolved
Message-ID: <20010627154941.A2592@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010625125007.20469D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010625125007.20469D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 25, 2001 at 01:36:15PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 25, 2001 at 01:36:15PM +0200, Maciej W. Rozycki wrote:

>  After extensive debugging I managed to track down the bug that was
> preventing me from building binutils since the beginning of February.
> Once again the culprit turned out to the the explicit nature of MIPS'
> caches.
> 
>  The problem lies in r3k_flush_cache_sigtramp().  It flushes three
> consecutive word-wide locations starting from the address passed as an
> argument.  The argument is normally a sigreturn trampoline that is set up
> by setup_frame() or setup_rt_frame().  But these functions set up two
> opcodes only -- the third word is left untouched.  In my case the address
> was something like 0x7???bff8.  So the area to be flushed spanned a page
> boundary and since the third word was unreferenced, a TLB entry for the
> page the word was located in was absent.  As a result, a TLB refill
> exception happened with caches isolated, which is not necessarily a win.
> The symptom was a solid crash. 
> 
>  I don't see any reason to flush the third word location, so I removed the
> code doing it.  This fixed the crashes I was observing, but since we are
> using mapped (KUSEG) addresses in r3k_flush_cache_sigtramp(), I believe we
> need more protection against unwanted TLB exceptions.  The point is we are
> running with interrupts enabled and a reschedule may happen between
> touching the trampoline in setup*_frame() and flushing the cache.  Hence
> the TLB entries for the trampoline area, even once present, may get
> removed meanwhile.  So I added some code to explicitly load the entries,
> if needed, with interrupts disabled just before isolating caches. 
> Following is a resulting patch. 
> 
>  Ralf, this is a showstopper bug -- please apply the fix ASAP. 

Applied.

  Ralf
