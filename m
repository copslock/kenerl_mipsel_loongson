Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 May 2004 21:14:48 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:39625
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226011AbUENUOr>; Fri, 14 May 2004 21:14:47 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4EKEjg10991
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 22:14:45 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Fri, 14 May 2004 22:14:45 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4EKEic15520
	for <linux-mips@linux-mips.org>; Fri, 14 May 2004 22:14:44 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Fri, 14 May 2004 22:14:44 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Octane: the saga continues...
Message-ID: <Pine.GSO.4.10.10405142211190.15354-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

After moving to the CVS kernel tree and tracking down (with Ralf) an
interesting bug in IRQ handling we have reached a next release:

  http://www.et.put.poznan.pl/~sskowron/ip30/

The patch applied cleanly to yesterday CVS and I would like some people to
try using it. This will help us debug the XKPHYS kernel support which will
be spun off in a separate patch soon.

The command line is currently fixed in arch/mips/kernel/setup.c - feel
free to comment out this line and use ARCS variables or just change it.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
