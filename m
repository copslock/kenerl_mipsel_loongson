Received:  by oss.sgi.com id <S553821AbQJYRPw>;
	Wed, 25 Oct 2000 10:15:52 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:35082 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553818AbQJYRPZ>;
	Wed, 25 Oct 2000 10:15:25 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA12014;
	Wed, 25 Oct 2000 10:14:53 -0700
Date:   Wed, 25 Oct 2000 10:14:53 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: fdisk/kernel oddity
Message-ID: <20001025101453.A11789@chem.unr.edu>
References: <20001025190129.A28426@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001025190129.A28426@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Wed, Oct 25, 2000 at 07:01:29PM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 07:01:29PM +0200, Guido Guenther wrote:

> After some writing to it( cp -a /usr /mnt), I see the following:
> Oct 25 16:00:37 bert kernel: 08:11: rw=0, want=1088320776, limit=533919
> Oct 25 16:00:37 bert kernel: attempt to access beyond end of device
> [..snip..]   
> Oct 25 16:00:37 bert kernel: 08:11: rw=0, want=138373542, limit=533919
> Oct 25 16:01:27 bert kernel: [rm:9357] Illegal instruction at 004059a4 ra=004028d8

Not to sound defensive, but I'm fairly sure this isn't an
fdisk-related problem. The partitions that fdisk creates follow the
spec as far as I can see.

> 08:11 is /dev/sda11 which is the "SGI volume", according to fdisk -l:
>   Device  Info      Start       End   Sectors  Id  System
>   /dev/sda1  boot         6       937   3872540  83  Linux native
>   /dev/sda2  swap       938      1009    298850  83  Linux native
>   /dev/sda9               0         4     20770   0  SGI volhdr
>   /dev/sda11              0      1008   4191386   6  SGI volume
> 
> So the requsted block is *far* out of bounds.

These partitions look quite sane. I wonder, though, if there's
something about your specific partitioning that is confusing the
kernel's SGI disklabel support.

> What puzzles me even more is that I get illegal instructions for almost 
> all commands I execute afterwards. Any comments on this one?

I rather suspect that this is the same problem that causes the request
for the out-of-bounds block in the first place: kernel memory
corruption. Unfortunately I have few ideas as to what the specific
problem is. I would start bug-hunting in the sgi disklabel kernel
parts. Make sure that it's compatible with what fdisk is doing.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
