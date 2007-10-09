Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:27:34 +0100 (BST)
Received: from mail.onstor.com ([66.201.51.107]:45713 "EHLO mail.onstor.com")
	by ftp.linux-mips.org with ESMTP id S20022131AbXJIU1Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 Oct 2007 21:27:25 +0100
Received: from onstor-exch02.onstor.net ([66.201.51.106]) by mail.onstor.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 Oct 2007 13:26:57 -0700
Received: from ripper.onstor.net ([10.0.0.42]) by onstor-exch02.onstor.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 9 Oct 2007 13:26:57 -0700
Date:	Tue, 9 Oct 2007 13:26:57 -0700
From:	Andrew Sharp <andy.sharp@onstor.com>
To:	linux-mips@linux-mips.org
Subject: paging problem with ide-cs driver
Message-ID: <20071009132657.64ec9158@ripper.onstor.net>
Organization: Onstor
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2007 20:26:57.0426 (UTC) FILETIME=[BD2B7F20:01C80AB2]
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.sharp@onstor.com
Precedence: bulk
X-list: linux-mips


I'm having a problem with paging through the ide-cs driver.  As best
I can tell right now, the kernel thinks the data is present and valid
when it actually isn't.  This is lmo 2.6.22.3, on a sibyte 1125H, but
I had the same problem with 2.6.20.something on an R9k based machine.

I can make a filesystem (ext3) on the CF card, mount it, read and write
to it.  But I can't chroot to it, can't set LD_LIBRARY_PATH to it,
can't use it as the root filesystem.

The chroot failure is the most telling.  When I try to chroot to it, I
get various segfault, bus error, illegal instruction, etc.  But if I
continue to try it, after 10-12 tries, it succeeds.  This tells me
that the data eventually arrives, it's just that the kernel tries to
use a page before the data is valid.

Before I dive into this, does any of this ring a bell for anyone?
I'm using the ide-cs driver, TI yenta cardbus adapter driver, and sibyte
everything else.

I can provide kernel output if anyone is interested in that.  But there
isn't any kernel output when the failure occurs, the thread just dies
with one of the various mentioned errors.

coolcat:~# cat /etc/fstab
proc /proc proc defaults 0 0
10.0.0.42:/var/nfsroot/cougar / nfs defaults 0 0
tmpfs /tmp tmpfs defaults,size=12m 0 0
coolcat:~# chroot /mnt
Illegal instruction
coolcat:~# chroot /mnt
Illegal instruction
coolcat:~# chroot /mnt
Segmentation fault
coolcat:~# chroot /mnt
Segmentation fault
coolcat:~# chroot /mnt
Illegal instruction
coolcat:~# chroot /mnt
Illegal instruction
coolcat:~# chroot /mnt
Illegal instruction
coolcat:~# chroot /mnt
Segmentation fault
coolcat:~# chroot /mnt
Segmentation fault
coolcat:~# chroot /mnt
coolcat:/# 
coolcat:/# cat /etc/fstab
Segmentation fault
coolcat:/# cat /etc/fstab
proc /proc proc defaults 0 0
/dev/hda2 / ext3 defaults 0 0
tmpfs /tmp tmpfs defaults,size=12m 0 0
coolcat:/# exit
