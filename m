Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1E25Nq12384
	for linux-mips-outgoing; Wed, 13 Feb 2002 18:05:23 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1E25I912378
	for <linux-mips@oss.sgi.com>; Wed, 13 Feb 2002 18:05:18 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id g1E157D03578;
	Wed, 13 Feb 2002 20:05:07 -0500
Date: Wed, 13 Feb 2002 20:05:07 -0500
From: Jim Paris <jim@jtan.com>
To: ellis@spinics.net
Cc: linux-mips@oss.sgi.com
Subject: Re: NFS ROOT Problem - boot (newbie)
Message-ID: <20020213200507.A3446@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <200202140017.g1E0HqT11565@spinics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202140017.g1E0HqT11565@spinics.net>; from ellis@spinics.net on Wed, Feb 13, 2002 at 04:17:52PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> >It seems that it initially finds the root on the nfs box but it
> >never get to do an init. It just stops and waits... Do I need
> >to modify any setting manually on my NFS image in order for the
> >kernel to boot?
> 
> I had something like that happen to me. It'd start mounting the
> NFS root but would stop sending packets after a while. I thought
> it was the ethernet driver but I never did find the problem
> before I had to move to other projects.

I also saw a similar problem when booting the kernel with a ramdisk
and attempting to NFS mount from there via a wireless card.  I don't
even remember which kernel it was now, but I eventually concluded that
the issue was with fragmented UDP packets.  Linux has
NFS_DEF_FILE_IO_BUFFER_SIZE set to 4096, which is of course larger
than an Ethernet frame (1536) and must fragment.  I'm not sure if it
that was the fault with the kernel or the wireless access point I was
using, but my host would send all fragments, and the MIPS box would
eventually send back a reassembly timeout.  Anyway, my solution was:

mount -o rsize=1024,wsize=1024 ...

I presume you could also set those from the boot command line if you
need to use nfsroot.

(The symptoms were that I could mount, and a very small number of
operations would occasionally work.  Of course, the ones that worked
were just whatever ones happened to fit in an unfragmented UDP packet)

-jim
