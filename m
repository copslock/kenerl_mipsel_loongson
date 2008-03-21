Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 16:22:48 +0000 (GMT)
Received: from [85.37.17.112] ([85.37.17.112]:45835 "EHLO smtp-out112.alice.it")
	by ftp.linux-mips.org with ESMTP id S28577343AbYCUQWq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Mar 2008 16:22:46 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out112.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:22:31 +0100
Received: from FBCMCL01B06.fbc.local ([192.168.69.87]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:22:30 +0100
Received: from [192.168.1.200] ([82.48.161.252]) by FBCMCL01B06.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:22:29 +0100
Message-ID: <47E3E0C2.9070404@tin.it>
Date:	Fri, 21 Mar 2008 17:22:26 +0100
From:	LD <memorylost@tin.it>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: AU1100 2.4.21-pre4 flash disks problems
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2008 16:22:30.0105 (UTC) FILETIME=[C282EC90:01C88B6F]
Return-Path: <memorylost@tin.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: memorylost@tin.it
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I am working on an AU1100 system, using a 2.4.21-pre4 kernel. Filesystem
is jffs2, uclibc libraries.

I have a couple of problems with USB flash disk handling:

1) it seems that my system does not "see" disks larger than 512 MB. 1GB
disks or more cannot be mounted. This is becoming a problem because
512MB disks are going out of the market.

2) Given two flash disks of different sizes (for example: one 128 MB,
one 512 MB), if I mount/umount one of them -> I cannot then mount the
other and vice versa.
Example:

- - mount the 128 MB one, then umount. Try to mount the 512MB ->fail.
- - reset the device
- - mount the 512MB device, ok. Umount. Try to mount the 128MB -> fail.

Disks are vfat formatted ; did not try with other filesystem types.

Tried to use a 2.6.x kernel and no problem ; I am planning to switch all
to 2.6.x kernel, but in this moment for me is better (if possible)
fixing this problem, because I have a number of applications and drivers
running on 2.4.21 and the switching to 2.6.x means revising and
re-testing a lot of things.

Back to 2.4.21...
If I try to dmesg I see a "Partition check:" message missing when I put
in the second disk ; I am investigating on this (maybe some piece of
software is called checking for partitions on the first disk but is not
called again when I change disk type).

Any suggestions are welcome,

best regards

Lucio Dona'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH4+DCvxHCsvXy9okRApudAJwON54jwrtPtgKd2zImEjmYbPbpRwCgsnWr
4nWlOjZbQtNDzqFUcfRRltI=
=vh3N
-----END PGP SIGNATURE-----
