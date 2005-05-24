Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2005 07:58:59 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:10207 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224970AbVEXG6o>; Tue, 24 May 2005 07:58:44 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4O6wee20160;
	Tue, 24 May 2005 08:58:41 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 24 May 2005 08:58:39 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4O6wbm13747;
	Tue, 24 May 2005 08:58:38 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 24 May 2005 08:58:37 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Richard Sandiford <rsandifo@redhat.com>
cc:	linux-mips@linux-mips.org
Subject: Re: Unmatched R_MIPS_HI16/R_MIPS_LO16 on gcc 3.5
In-Reply-To: <87acml863g.fsf@firetop.home>
Message-ID: <Pine.GSO.4.10.10505240857260.13676-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Sorry if this is a dumb question, but why do you need to generate
> _relocatable_ ECOFF?

It allows me to boot all Indys and O2s off the same binary. Nice for boot
CDs. Especially that Octanes and Origins should be bootable from another
one... just like IRIX.

> If you really need to do that, I think you'll just have to force gcc
> to use assembler macros, ala:
> 
>    gcc -mno-explicit-relocs -mno-split-addresses

Thanks!

Stanislaw
