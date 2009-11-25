Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:00:04 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43386 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492901AbZKYO76 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2009 15:59:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAPF05E8009490;
        Wed, 25 Nov 2009 15:00:05 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAPF02cA009486;
        Wed, 25 Nov 2009 15:00:02 GMT
Date:   Wed, 25 Nov 2009 15:00:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org,
        Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: Re: Syncing CPU caches from userland on MIPS
Message-ID: <20091125150002.GA7977@linux-mips.org>
References: <20091124182841.GE17477@hall.aurel32.net> <20091125140105.GB13938@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091125140105.GB13938@paradigm.rfc822.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 25, 2009 at 03:01:05PM +0100, Florian Lohoff wrote:

> > | static inline void flush_icache_range(unsigned long start, unsigned long stop)
> > | {
> > |     cacheflush ((void *)start, stop-start, ICACHE);
> > | }
> 
> Would this only evict stuff from the ICACHE? When trying to execute
> a just written buffer and with a writeback DCACHE you would need to 
> explicitly writeback the DCACHE to memory and invalidate the ICACHE.

No; ICACHE really means the kernel will do whatever it takes to make the
I-cache coherent with the D-cache.  For most processors this requires
writing back the D-cache to S-cache or if no S-cache present, memory
then invalidating the I-cache.

> > It seems this is not enough, as sometimes, some executed code does not
> > correspond to the assembly dump of this memory region. This seems to be 
> > especially the case of memory regions that are written twice, due to
> > relocations:
> > 1) a branch instruction is written with an offset of 0
> > 2) the offset is patched
> > 3) cacheflush is called
> > 
> > Sometimes the executed code correspond to the code written in 1), which
> > means the branch is skipped.
> 
> Which proves my theory - as long as you have cache pressure you will happily
> writeback the contents to memory before trying to execute (you invalidate
> the ICACHE above) - In case you DCACHE does not suffer from pressure
> the contents will not been written back and you'll execute stale code.

You could - on a uni-processor system - do something like this to invalidate
the cache:

int array[32768 / sizeof(int)];	/* size of D-cache on SB1250  */

blow_away_d(void)
{
	memset(array, 0, sizeof(array) / sizeof(int) - 2);
	array[sizeof(int) - 2] = 0x03E00008;	/* jr $ra	*/
	array[sizeof(int) - 1] = 0x00000000;	/* nop		*/
}

blow_away_i(void)
{
	void (*fn)(void) = (void *) array;

	blow_away_d();
	fn();
}

blow_away_setup(void)
{
	blow_away_d();
	cacheflush(array, sizeof(array), BCACHE);
}

The memset and array assignment operations result in victim writebacks
that is basically an D-cache writeback.  Later on executing the code in
the array will result in the entire I-cache getting refilled so anything
of your qemu code array that might happen to live in the I-cache will be
discarded out of the cache.

  Ralf
