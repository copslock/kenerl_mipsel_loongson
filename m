Received:  by oss.sgi.com id <S42226AbQHGVtk>;
	Mon, 7 Aug 2000 14:49:40 -0700
Received: from jarre.otscorp.com ([203.44.145.48]:55561 "EHLO shorts.cx")
	by oss.sgi.com with ESMTP id <S42190AbQHGVtU>;
	Mon, 7 Aug 2000 14:49:20 -0700
Received: from pikachu.house (ndf@pikachu.house [192.168.10.30])
	by shorts.cx (8.11.0/8.11.0) with ESMTP id e77Lp2G09428;
	Tue, 8 Aug 2000 07:51:02 +1000
Date:   Tue, 8 Aug 2000 07:51:00 +1000 (EST)
From:   Nathan Fraser <ndf@shorts.cx>
X-Sender: ndf@pikachu.house
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com
Subject: Re: [Install trouble] : mount failed: bad address
In-Reply-To: <20000807083002.A32048@chem.unr.edu>
Message-ID: <Pine.LNX.4.21.0008080746310.9414-100000@pikachu.house>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


well if there is a way to get kernel, base system, vi and gcc going
without using redhat I'd be VERY interested to hear :)

On Mon, 7 Aug 2000, Keith M Wesolowski wrote:

> On Mon, Aug 07, 2000 at 10:27:03PM +1000, Nathan Fraser wrote:
> 
> > I just tried installing with vmlinux-000804-IP22-4400 and
> > hardhat-sgi-5.1.tar.gz - i get the same error as soon as the drive is
> > formatted and is mounted (ie: mount failed: bad address)
> 
> I wonder if the DeadRat installer is using peecee style partition
> tables. If so, then this is probably the source of the trouble. The
> kernels I build, as you can see from the .config, don't support those,
> only SGI style disklabels. If the fdisk in the installer doesn't
> support that, then it won't work. It does seem odd though that you
> couldn't mount an existing EFS filesystem.
> 
> There are also several problems with older fdisks; indeed, I think you
> still need one of my patches for the current one to work properly.
> 
> The dated kernels I'm posting there are CVS from the 2.3/2.4 tree,
> built with a CVS compiler and binutils. I wouldn't go using those on a
> lark. For something as old as Hard Hat, maybe try the 2.2 kernel
> instead.
> 
> I must admit to being the one person on this list who has never even
> attempted to install Hard Hat, though, so maybe I don't know what I'm
> talking about. :)
> 
> -- 
> Keith M Wesolowski			wesolows@chem.unr.edu
> University of Nevada			http://www.chem.unr.edu
> Chemistry Department Systems and Network Administrator
> 
