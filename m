Received:  by oss.sgi.com id <S553819AbQJYRBl>;
	Wed, 25 Oct 2000 10:01:41 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:4616 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553815AbQJYRBd>; Wed, 25 Oct 2000 10:01:33 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13oTve-0008P2-00; Wed, 25 Oct 2000 19:01:30 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13oTve-0007Pd-00; Wed, 25 Oct 2000 19:01:30 +0200
Date:   Wed, 25 Oct 2000 19:01:29 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: fdisk/kernel oddity
Message-ID: <20001025190129.A28426@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
I recently partitioned a second HD on an Indy with Keith's fdisk patch.
After some writing to it( cp -a /usr /mnt), I see the following:
Oct 25 16:00:37 bert kernel: 08:11: rw=0, want=1088320776, limit=533919
Oct 25 16:00:37 bert kernel: attempt to access beyond end of device
[..snip..]   
Oct 25 16:00:37 bert kernel: 08:11: rw=0, want=138373542, limit=533919
Oct 25 16:01:27 bert kernel: [rm:9357] Illegal instruction at 004059a4 ra=004028d8

08:11 is /dev/sda11 which is the "SGI volume", according to fdisk -l:
  Device  Info      Start       End   Sectors  Id  System
  /dev/sda1  boot         6       937   3872540  83  Linux native
  /dev/sda2  swap       938      1009    298850  83  Linux native
  /dev/sda9               0         4     20770   0  SGI volhdr
  /dev/sda11              0      1008   4191386   6  SGI volume

So the requsted block is *far* out of bounds.

What puzzles me even more is that I get illegal instructions for almost 
all commands I execute afterwards. Any comments on this one?
Regards,
 -- Guido

-- 
GPG-Public Key: finger agx@debian.org
