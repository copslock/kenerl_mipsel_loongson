Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3LMEgY18585
	for linux-mips-outgoing; Sat, 21 Apr 2001 15:14:42 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3LMEfM18580
	for <linux-mips@oss.sgi.com>; Sat, 21 Apr 2001 15:14:41 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14r5eK-00034Q-00; Sun, 22 Apr 2001 00:14:40 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14r5eK-0000Ju-00; Sun, 22 Apr 2001 00:14:40 +0200
Date: Sun, 22 Apr 2001 00:14:40 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: Dave Gilbert <gilbertd@treblig.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Passing kernel args
Message-ID: <20010422001440.A1191@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: Dave Gilbert <gilbertd@treblig.org>,
	linux-mips@oss.sgi.com
References: <20010419224030.A19856@bilbo.physik.uni-konstanz.de> <Pine.LNX.4.10.10104192336540.894-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104192336540.894-100000@tardis.home.dave>; from gilbertd@treblig.org on Thu, Apr 19, 2001 at 11:45:08PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 19, 2001 at 11:45:08PM +0100, Dave Gilbert wrote:
[..snip..] 
>   1) Disk partitioning.  I had a disk that had Irix on, however my first
> problem was that the volume header wasn't big enough for a Linux kernel.
> You state that you can use x and then g in fdisk to create a new partition
> table, however that only works if the disc is clean and doesn't already
> have an Irix partition on it.  In my case since it already did have, x
> just gave 'sorry there is no expert mode for SG partitions' (or something
> similar).   Having wiped the disc clean with:
> 
> dd if=/dev/zero of=/dev/sda
Thanks. I'll add this to the howto.
[..snip..] 
> 
>   2) OSLoadPartition - it seems to look at this a little late; i.e. if you
> have an NFS Root kernel it ignores OSLoadPartition and still NFS roots -
> so I needed to pass a root= option.
This only happens when fetching a kernel via bootp. I suspect that the
prom variables do not get passed to the kernel in that case, only the
arguments after the "bootp(): "call . Not sure if we can do anything about
this.

> 
>   2) OSLoadOptions - the kernel I have (a 2.4.0) gets a string which is:
> 
>       OSLoadOptions=whatEverYouSet
> 
>     So if you:
> 
>        setenv OSLoadOptions "root=/dev/sda1 ro"
> 
>     The kernel actually sees:
>        OSLoadOptions=root=/dev/sda1 ro
> 
>     So I had to do:
> 
>        setenv OSLoadOptions " root=/dev/sda1 ro"
> 
>     Which works like a dream. (Note the trailing space after the first " )
Hmm...I'm not seeing this here on 2 Indy's and an I2. As Flo already
pointed out this might be a firmware bug.

> 
> It is also useful to point out that it is the partition(8) in the options
> that corresponds to the /dev/sda9 in the fdisk output.
Will add that one too.
Regards,
 -- Guido
