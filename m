Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 18:56:52 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:15355
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225214AbUEKR4v>; Tue, 11 May 2004 18:56:51 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4BHufg23154
	for <linux-mips@linux-mips.org>; Tue, 11 May 2004 19:56:41 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 11 May 2004 19:56:40 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4BHue408450
	for <linux-mips@linux-mips.org>; Tue, 11 May 2004 19:56:40 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Tue, 11 May 2004 19:56:40 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: IOC3 interrupt management
Message-ID: <Pine.GSO.4.10.10405111949550.8069-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Well, there is a problem _again_. This time it's a purely conceptual one.

The IOC3 on Octanes (maybe on Onyx2es, too) controls the Ethernet, 
keyboard, mouse, serial and parallel ports and SGI alone knows what else.

It is also tied to (at least) two bridge interrupts. One is used solely
for Ethernet, and the other one is used for all the SuperIO stuff.

Well, I'm an educated man (when it comes to Octane internals, that is)
and I know that the first interrupt is 2 and the other is 4, and that they
map to IRQ10 and IRQ12, respectively. But how should the poor kernel know
about such arcanes? There is not a word in the IOC3 registers about this
weird connection so the PCI drivers don't know about it at all.

Now this is not a problem - I could simply assume that all IOC3s will have
another IRQ at irq_num+2. But, MENET of course is build of four IOC3s and
is definitely arranged in some other way. And what about the single IOC3
cards? Do they have the other IRQ at all, or don't they allow using
SuperIO?

This will all end in a kludge.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
