Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA40686 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 09:57:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA75227
	for linux-list;
	Wed, 17 Jun 1998 09:56:59 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA86353;
	Wed, 17 Jun 1998 09:56:55 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id JAA07314; Wed, 17 Jun 1998 09:56:49 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id SAA17282;
	Wed, 17 Jun 1998 18:56:27 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id SAA15281;
	Wed, 17 Jun 1998 18:56:25 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id SAA22811;
	Wed, 17 Jun 1998 18:56:25 +0200 (MET DST)
Message-Id: <199806171656.SAA22811@aisa.fi.muni.cz>
Subject: Re: (fwd) linux SEGV details
In-Reply-To: <199806171543.IAA95711@oz.engr.sgi.com> from Ariel Faigon at "Jun 17, 98 08:43:11 am"
To: ariel@cthulhu.engr.sgi.com
Date: Wed, 17 Jun 1998 18:56:24 +0200 (MET DST)
Cc: linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> > output tomorrow.
> 
> Honza is not yet here, so there is the output:
> 
> #mkswap /dev/sdb2
> Segmentation fault
> #
> 
> and on console (there is no syslogd :( ) is:
> 
> #dmesg
> [...skipped...]
> VFS: brelse: Trying to free free buffer
> Unable to handle kernel paging request at virtual address 00050040,
> epc == 88041e7c, ra == 880464e0
> Oops: 0000
> $0 : 00000000 88140000 00000028 00000009
> $4 : 00050028 00000001 bf0f0000 00000000
> $8 : 00000720 00000000 00000000 00000000
> $12: 00000008 000003e2 8836e59c 7ffffcf0
> $16: 00050028 894c7c88 894c7d80 00000001
> $20: 00000000 00000000 894c7c80 00000000
> $24: 00000001 7ffffcf1
> $28: 894c6000 894c7c58 00000000 880464e0
> epc   : 88041e7c
> Status: 3000fc03
> Cause : 00000008

OK, I once ( ;-) ) got to run the mkswap /dev/sdb2 OK. Before that
I tried dd if=/deb/sdb2 of=/dev/null bs=1024 count=1 and mkswap
/dev/sdb2 1024. These are two steps that lead to mkswap /dev/sdb2
without fail, creating 40 MB (correct) swap partition. I do not know
who caused it, whether that dd or that mkswap.

Now it seems that mkswap /dev/sdb2 35000 (eg with some size argument)
works fine. But I never got to make it work without the size parameter
again. David says that mkswap might have problems determining the size
of the partition. Also dd, when let to run over the whole device fails
with the same message about freeing free. But David says he was
successful running mkfs on that partition.

Weird, but I'm now happy it runs with something smaller (I do not know
(am lazy to find out) the exact size of the partition) swap.

In the meantime I played with swap into file and found some other
bugs. First, there are two swapon -a commands in rc.sysinit. When
I had that swapfile specified in /etc/fstab, it got swaponed twice.
Brrr. I had to do one swapoff to make it look normal.

Even if I had it only once (added manually) the machine was very
unhappy with the swapfile. Kswapd was taking a lot of CPU, the load
was growing and occassionally the machine was unusable -- too slow
that I had to resume to hard reset.

But as I say, with swap into the partition, it looks fine.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
