Received:  by oss.sgi.com id <S553840AbRBWAHM>;
	Thu, 22 Feb 2001 16:07:12 -0800
Received: from u-186-19.karlsruhe.ipdial.viaginterkom.de ([62.180.19.186]:39153
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553802AbRBWAHD>; Thu, 22 Feb 2001 16:07:03 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1N04NX02182;
	Fri, 23 Feb 2001 01:04:23 +0100
Date:   Fri, 23 Feb 2001 01:04:23 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Soren S. Jorvang" <soren@wheel.dk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: R10000 SGI O2
Message-ID: <20010223010423.A1212@bacchus.dhis.org>
References: <3A895FF4.B627089E@geo.umnw.ethz.ch> <20010213190716.A29070@chem.unr.edu> <20010216175902.C2233@bacchus.dhis.org> <20010222042358.H22997@gnyf.wheel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010222042358.H22997@gnyf.wheel.dk>; from soren@wheel.dk on Thu, Feb 22, 2001 at 04:23:58AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 22, 2001 at 04:23:58AM +0100, Soren S. Jorvang wrote:

> > > for r5k-based IP32 (O2) systems.  r10k O2 suffers from the same
> > > cache-noncoherency problem as r10k I2 does, and to the best of my
> > > knowledge nobody has ever really tried to even boot one.
> > > 
> > > Not to discourage you at all...there's just a lot of work to do.
> > 
> > It's really hard work to do.  R12000 O2s however should be much easier to
> > do; the processor feature which causes so much grief in the O2 can be
> > disabled there.
> 
> Unfortunately, noone I have talked to seems to know how
> specifically to turn off speculative writes..

> 
> Does anyone on this list happen to know?

RTFM ;-)

B.2 DSD (Delay Speculative Dirty)

  The Boot Mode bit 24 corresponds to the Config register[24] bit and this
  controls DSD during kernel and supervisor modes. However, the DSD mode can
  also be enabled in the user mode by setting the Status register[24]
  bit. Config register[24] is read-only and can be set only at boot time. If
  the DSD mode is set -

  a) R12000 will not set the Dirty bit for a secondary cache block until the
     store instruction is the oldest in the Active List and is about to be
     executed. (An interrupt could cause a case where the dirty bit is set
     (store is no longer speculative), but the store does not immediately
     graduate. We believe this case should not cause any problem. This mode
     does prevent speculative stores from setting the dirty bit.

  b) This mode will have slightly lower performance due to the delay in the
     setting of the Dirty bit. This delay will occur just once per block
     refill from main memory, when it is necessary to set the dirty
     bit. Setting the bit requires about ten cycles; but usually the
     processor will continue to overlap execution of other instructions.
     Once a block becomes dirty in secondary cache, this mode has no
     performance effect.

  c) In this mode, a miss in secondary cache, due to a store instruction
     which is not already the oldest in the pipeline, will cause a refill to
     the clean exclusive state. A hit to a shared line will immediately
     cause an upgrade to clean exclusive . Thus, bus operations (which are
     relatively slow) will still begin speculatively. Independent of the DSD
     mode, R12000 will delay a cached, non-coherent load until it is the
     oldest instruction. This change is implemented because a speculative
     load accessing an unmapped xkphys address as cached, non-coherent might
     bring data into the secondary cache without the proper coherency
     checks. R12000 is doing no changes to prevent it from speculatively
     refilling cache lines in shared or clean states except the xkphys case
     described above.

So as you see the details are actually a bit more complicated than just
disabling speculative stores; the actual problem are dirty lines which might
be written back to memory on an O2 or Indigo 2 R10000.  DSD doesn't help
with speculative loads but these are easier to handle.

  Ralf
