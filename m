Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 05:37:57 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:2036 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225207AbVE0Ehk>; Fri, 27 May 2005 05:37:40 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4R4bae20548;
	Fri, 27 May 2005 06:37:37 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Fri, 27 May 2005 06:37:35 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4R4bYP21333;
	Fri, 27 May 2005 06:37:34 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Fri, 27 May 2005 06:37:34 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	developer <developer@phatlinux.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Porting To New System
In-Reply-To: <20050527031123.1327.qmail@server256.com>
Message-ID: <Pine.GSO.4.10.10505270556110.19477-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

First, does the PSP's processor have a MMU? If not, then there is not much
point in porting Linux (or for that matter, anything else). A machine
without a MMU is pretty worthless under Linux except as a fixed-function
embedded system; to wit, mmap(2) will not work.

Next, see http://www.linux-mips.org/wiki/index.php/Porting - it's
excellent. I don't know if a PSP has an accessible serial port - if not,
then you are somewhat screwed (OK, so not that bad; I've done a port that
used graphical display from the beginning for all debugging purposes).

You've got to do three things:
 1) use lines no longer than 80 chars in your mails ;)
 2) get all docs on the PSP you can get - reverse engineering is fun but
    only if you enjoy hacking for 14 hours a day,
 3) take a look at some directory in arch/mips.

Of course, the hardest of them is (2) in my experience, unless Sony felt
generous at the time and released all PSP docs. My port was completely
reverse-engineered but I wouldn't advise to do that unless you are sure
you can spare the time and effort.

Oh, and one more thing: USE THE CVS LINUX-MIPS.ORG TREE! The kernel.org
tree is so out of sync that it's virtually worthless.

Cheers,

Stanislaw Skowronek
