Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3JMnXM29087
	for linux-mips-outgoing; Thu, 19 Apr 2001 15:49:33 -0700
Received: from rhenium (rhenium.btinternet.com [194.73.73.93])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3JMnSM29083
	for <linux-mips@oss.sgi.com>; Thu, 19 Apr 2001 15:49:32 -0700
Received: from [213.122.145.111] (helo=tardis)
	by rhenium with esmtp (Exim 3.03 #83)
	id 14qNEr-00032J-00; Thu, 19 Apr 2001 23:49:26 +0100
Date: Thu, 19 Apr 2001 23:45:08 +0100 (BST)
From: Dave Gilbert <gilbertd@treblig.org>
X-Sender: gilbertd@tardis.home.dave
To: Guido Guenther <guido.guenther@gmx.net>
cc: linux-mips@oss.sgi.com
Subject: Re: Passing kernel args
In-Reply-To: <20010419224030.A19856@bilbo.physik.uni-konstanz.de>
Message-ID: <Pine.LNX.4.10.10104192336540.894-100000@tardis.home.dave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 19 Apr 2001, Guido Guenther wrote:

> OSLoadOptions
> See 
> http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-howto.html
> (at the bottom) for an example.

Ah thanks - that would have helped a lot if I'd seen that before :-)
However there are a couple of points which don't seem to have matched my
experience:

  1) Disk partitioning.  I had a disk that had Irix on, however my first
problem was that the volume header wasn't big enough for a Linux kernel.
You state that you can use x and then g in fdisk to create a new partition
table, however that only works if the disc is clean and doesn't already
have an Irix partition on it.  In my case since it already did have, x
just gave 'sorry there is no expert mode for SG partitions' (or something
similar).   Having wiped the disc clean with:

dd if=/dev/zero of=/dev/sda

for a few moments I could then do the x and g (thanks to someone on the
IRC channel for pointing the x, g thing out prior to you giving me that
document).

  2) OSLoadPartition - it seems to look at this a little late; i.e. if you
have an NFS Root kernel it ignores OSLoadPartition and still NFS roots -
so I needed to pass a root= option.

  2) OSLoadOptions - the kernel I have (a 2.4.0) gets a string which is:

      OSLoadOptions=whatEverYouSet

    So if you:

       setenv OSLoadOptions "root=/dev/sda1 ro"

    The kernel actually sees:
       OSLoadOptions=root=/dev/sda1 ro

    So I had to do:

       setenv OSLoadOptions " root=/dev/sda1 ro"

    Which works like a dream. (Note the trailing space after the first " )

It is also useful to point out that it is the partition(8) in the options
that corresponds to the /dev/sda9 in the fdisk output.

Thanks again,

Dave (Whose Indy, dino, now boots off its disc)

-- 
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert      | Running GNU/Linux on Alpha, | Happy  \ 
\   gro.gilbert @ treblig.org | 68K,MIPS,x86,ARM and SPARC  | In Hex /
 \ ___________________________|___ http://www.treblig.org   |_______/
