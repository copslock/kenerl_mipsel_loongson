Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IIKVY10870
	for linux-mips-outgoing; Wed, 18 Apr 2001 11:20:31 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IIKTM10864
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 11:20:29 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1FD557F9; Wed, 18 Apr 2001 20:20:27 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2AE2BF383; Wed, 18 Apr 2001 20:19:56 +0200 (CEST)
Date: Wed, 18 Apr 2001 20:19:56 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Indy and the multiple disk problem
Message-ID: <20010418201956.C8545@paradigm.rfc822.org>
References: <200104181621.SAA06516@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200104181621.SAA06516@sparta.research.kpn.com>; from K.H.C.vanHouten@research.kpn.com on Wed, Apr 18, 2001 at 06:21:27PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 18, 2001 at 06:21:27PM +0200, Karel van Houten wrote:
> I stopped the copy, synced, and fsck-ed (-n) the local partitions.
> No problems on the /local partition, but the root was badly corrupted.
> Hey! That's strange, I didn't do anything on that partition!
> Could it be that there is some bug in the buffer layer, that is
> corrupting the buffers belonging to another FS?
> 
> Any hints?
> 
> I hope that I get the system up again tomorrow when I get to the office :(

The problem is read not write from my investigations. I posted a patch
to this list a coupld of days ago which gives a printk if we stop
the dma although it is still running. This is the normal behaviour
on the Amiga as the DMA engine will not stop running until we stop
it. On the Indy/Indigo2 with the HPC the DMA stops when no data is
coming so this is definitly a BUG() case. I have no clue why
this only happens on I/O load.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
