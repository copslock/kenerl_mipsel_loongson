Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2005 17:17:04 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:1263 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225305AbVHKQQl>; Thu, 11 Aug 2005 17:16:41 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j7BGKnn09765;
	Thu, 11 Aug 2005 18:20:50 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Thu, 11 Aug 2005 18:20:44 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j7BGKgS11110;
	Thu, 11 Aug 2005 18:20:42 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Thu, 11 Aug 2005 18:20:42 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Aaron Walker <ka0ttic@gentoo.org>
cc:	linux-mips@linux-mips.org
Subject: Re: IP30 hang on warm boot
In-Reply-To: <42FB71D4.9040408@gentoo.org>
Message-ID: <Pine.GSO.4.10.10508111814210.10659-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello,

Try the current (R25) Octane patches at
http://www.linux-mips.org/~skylark/.

The IOC3 support code has been in for a massive overhaul since the gentoo
sources have been done by `K. Also, the PCI code is completely new. And
ALSA supports many more features of the RAD1.

I hope you will be pleasantly surprised,

Stanislaw Skowronek

--<=>--
  "I wish for that night-time
   To last for a lifetime.
   The darkness around me
   Shores of a solar sea."
