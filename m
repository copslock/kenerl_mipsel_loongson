Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 06:08:24 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:10406 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225195AbVE1FII>; Sat, 28 May 2005 06:08:08 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4S582e01337;
	Sat, 28 May 2005 07:08:02 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 28 May 2005 07:08:00 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4S57vW22240;
	Sat, 28 May 2005 07:07:58 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sat, 28 May 2005 07:07:57 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
cc:	Cameron Cooper <developer@phatlinux.com>, linux-mips@linux-mips.org
Subject: Re: Porting To New System
In-Reply-To: <1117235565.5730.255.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.10.10505280700460.21819-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> You seem remarkably confident for someone who has never taken one apart.

Unless it would be very heavily restricted (rather a mmap-style thing than
a real, direct MMU interface) it would be a serious security breach.

OTOH if the assumption is that PSP is always running trusted code, it is
possible that the game can influence the MMU and there are no security
checks at all. I forgot that the whole ability of running untrusted code
on 1.0 was a bug, and not something planned, so interfaces would not need
be so tight.

By the way, all PSPs you can buy now, except early Japanese version, are
1.5 or higher so the whole point of having a MMU interface is moot
because, as of now, you can't run anything on it at all. Not even a hello
world.

Anyway, I'm going to take one apart :)

Stanislaw
