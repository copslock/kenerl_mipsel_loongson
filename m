Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IGLW705370
	for linux-mips-outgoing; Wed, 18 Apr 2001 09:21:32 -0700
Received: from hermes.research.kpn.com (hermes.research.kpn.com [139.63.192.8])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IGLUM05365
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 09:21:31 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
 by research.kpn.com (PMDF V5.2-31 #42699)
 with ESMTP id <01K2JZ71VA1E000VDV@research.kpn.com> for
 linux-mips@oss.sgi.com; Wed, 18 Apr 2001 18:21:28 +0200
Received: (from karel@localhost)	by sparta.research.kpn.com (8.8.8+Sun/8.8.8)
 id SAA06516; Wed, 18 Apr 2001 18:21:27 +0200 (MET DST)
X-URL: http://www-lsdm.research.kpn.com/~karel
Date: Wed, 18 Apr 2001 18:21:27 +0200 (MET DST)
From: Karel van Houten <K.H.C.vanHouten@research.kpn.com>
Subject: Indy and the multiple disk problem
To: linux-mips@oss.sgi.com
Cc: K.H.C.vanHouten@research.kpn.com (Houten K.H.C. van (Karel))
Message-id: <200104181621.SAA06516@sparta.research.kpn.com>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL2]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All

I've made some observations concerning the indy multiple disk problem:

The setup:
Root FS on /dev/sda1, /local on /dev/sdb3, and some NFS mounted systems.
Kernel 2.4.2 (March 30 CVS).

Doing this:
I mke2fs-ed the sdb3 partition, mounted it at /local, and copied
a tree from an NFS filesystem to /local. No other activity on the system.
I used tar | (cd;tar) for the copy.

What happened:
I tried to 'su' in another window on the machine, and it responded
with a segfault. Several other programs reacted with segfaults or
bus errors. 

I stopped the copy, synced, and fsck-ed (-n) the local partitions.
No problems on the /local partition, but the root was badly corrupted.
Hey! That's strange, I didn't do anything on that partition!
Could it be that there is some bug in the buffer layer, that is
corrupting the buffers belonging to another FS?

Any hints?

I hope that I get the system up again tomorrow when I get to the office :(

-- 
Karel van Houten

----------------------------------------------------------
The box said "Requires Windows 95 or better."
I can't understand why it won't work on my Linux computer. 
----------------------------------------------------------
