Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IHfX808669
	for linux-mips-outgoing; Wed, 18 Apr 2001 10:41:33 -0700
Received: from post.webmailer.de (natmail2.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IHfWM08665
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 10:41:32 -0700
Received: from scotty.mgnet.de (p3E9B90B8.dip.t-dialin.net [62.155.144.184])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id TAA23545
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 19:41:29 +0200 (MET DST)
Received: (qmail 12946 invoked from network); 18 Apr 2001 17:41:28 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 18 Apr 2001 17:41:28 -0000
Date: Wed, 18 Apr 2001 19:41:28 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Indy and the multiple disk problem
In-Reply-To: <200104181621.SAA06516@sparta.research.kpn.com>
Message-ID: <Pine.LNX.4.21.0104181939560.4657-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 18 Apr 2001, Karel van Houten wrote:

> The setup:
> Root FS on /dev/sda1, /local on /dev/sdb3, and some NFS mounted systems.
> Kernel 2.4.2 (March 30 CVS).
> 
> Doing this:
> I mke2fs-ed the sdb3 partition, mounted it at /local, and copied
> a tree from an NFS filesystem to /local. No other activity on the system.
> I used tar | (cd;tar) for the copy.
> 
> What happened:
> I tried to 'su' in another window on the machine, and it responded
> with a segfault. Several other programs reacted with segfaults or
> bus errors. 
> 
> I stopped the copy, synced, and fsck-ed (-n) the local partitions.
> No problems on the /local partition, but the root was badly corrupted.
> Hey! That's strange, I didn't do anything on that partition!

You did. At the time when you opened your other terminal and
typed su you were reading and writing to the partition.
I have observed this behaviour too.
So in fact you're still hitting the same problem - but
it's very aggressive on your side.

		Bye, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
