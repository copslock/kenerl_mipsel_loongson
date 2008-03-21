Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 16:35:40 +0000 (GMT)
Received: from smtp-out25.alice.it ([85.33.2.25]:40968 "EHLO
	smtp-out25.alice.it") by ftp.linux-mips.org with ESMTP
	id S28577355AbYCUQfi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 16:35:38 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:34:30 +0100
Received: from FBCMCL01B05.fbc.local ([192.168.69.86]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:34:30 +0100
Received: from [192.168.1.200] ([82.48.161.252]) by FBCMCL01B05.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:34:30 +0100
Message-ID: <47E3E393.2080909@tin.it>
Date:	Fri, 21 Mar 2008 17:34:27 +0100
From:	LD <memorylost@tin.it>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Fwd: AU1100 2.4.21-pre4 flash disks problems]
X-Enigmail-Version: 0.95.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2008 16:34:30.0645 (UTC) FILETIME=[6FFC9A50:01C88B71]
Return-Path: <memorylost@tin.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: memorylost@tin.it
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- ------------------------------
|Back to 2.4.21...
|If I try to dmesg I see a "Partition check:" message missing when I put
|in the second disk ; I am investigating on this (maybe some piece of
|software is called checking for partitions on the first disk but is not
|called again when I change disk type).
- ------------------------------

Just checked - only the printk is executed once, in fs/partitions/check.c.

Probably false road, continuing investigations.

Regards

Lucio Dona'
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH4+OTvxHCsvXy9okRAnJkAJ9f4S81P9RBw0TSuIs5C7Y0ElRCPgCeKv03
12gKL8W1uBfIW9Uwp25TM1s=
=At5R
-----END PGP SIGNATURE-----
