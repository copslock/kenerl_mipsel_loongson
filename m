Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 18:55:21 +0100 (BST)
Received: from pasmtp.tele.dk ([IPv6:::ffff:193.162.159.95]:37133 "EHLO
	pasmtp.tele.dk") by linux-mips.org with ESMTP id <S8225199AbTDKRzS>;
	Fri, 11 Apr 2003 18:55:18 +0100
Received: from ekner.info (0x83a4a968.virnxx10.adsl-dhcp.tele.dk [131.164.169.104])
	by pasmtp.tele.dk (Postfix) with ESMTP id F38B1B4DB
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2003 19:55:05 +0200 (CEST)
Message-ID: <3E97018B.3435D14C@ekner.info>
Date: Fri, 11 Apr 2003 19:55:23 +0200
From: Hartvig Ekner <hartvig@ekner.info>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-19.7.x i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: ext3 problem solved
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvig@ekner.info>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvig@ekner.info
Precedence: bulk
X-list: linux-mips

I found out (sort of) what the problem was and found a fix.

Apparantly there is something wrong with e2fsprogs 1.27, since it was unable to repair
the problem I had in the filesystem (just kept repairing the same thing again and again).

I took the disk and attached it to a x86 PC, and ran fsck.ext3 there (an older version, 1.26).
It found exactly the same errors as the MIPS system, but actually fixed them so that
subsequent runs with "-f" reported no errors. I then put the disk back on the MIPS
system - voila, no more filesystem problems. Then did another unclean shutdown,
and the same problem reappeared, and once again fsck (on MIPS) was unable to fix
it.

Then I downloaded e2fsprogs-1.32-6.mipsel.rpm from redhat 9, and installed that on my
MIPS system. And that removed the problem for good.

So the conclusion must be: The e2fsprogs-1.27 package which is part of the MIPS 7.3
RedHat distribution (CDROM and FTP) is broken. Don't leave home without a newer
e2fsprogs RPM just in case!

Thanks to everybody who replied!

/Hartvig
