Received:  by oss.sgi.com id <S42190AbQHGPbL>;
	Mon, 7 Aug 2000 08:31:11 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:22027 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42183AbQHGPa5>;
	Mon, 7 Aug 2000 08:30:57 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id IAA32547;
	Mon, 7 Aug 2000 08:30:02 -0700
Date:   Mon, 7 Aug 2000 08:30:02 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Nathan Fraser <ndf@shorts.cx>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [Install trouble] : mount failed: bad address
Message-ID: <20000807083002.A32048@chem.unr.edu>
References: <Pine.LNX.4.20.0008072030210.4379-100000@jarre.house>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.20.0008072030210.4379-100000@jarre.house>; from ndf@shorts.cx on Mon, Aug 07, 2000 at 10:27:03PM +1000
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Aug 07, 2000 at 10:27:03PM +1000, Nathan Fraser wrote:

> I just tried installing with vmlinux-000804-IP22-4400 and
> hardhat-sgi-5.1.tar.gz - i get the same error as soon as the drive is
> formatted and is mounted (ie: mount failed: bad address)

I wonder if the DeadRat installer is using peecee style partition
tables. If so, then this is probably the source of the trouble. The
kernels I build, as you can see from the .config, don't support those,
only SGI style disklabels. If the fdisk in the installer doesn't
support that, then it won't work. It does seem odd though that you
couldn't mount an existing EFS filesystem.

There are also several problems with older fdisks; indeed, I think you
still need one of my patches for the current one to work properly.

The dated kernels I'm posting there are CVS from the 2.3/2.4 tree,
built with a CVS compiler and binutils. I wouldn't go using those on a
lark. For something as old as Hard Hat, maybe try the 2.2 kernel
instead.

I must admit to being the one person on this list who has never even
attempted to install Hard Hat, though, so maybe I don't know what I'm
talking about. :)

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
