Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 21:54:10 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:11725
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225745AbUEJUyG>; Mon, 10 May 2004 21:54:06 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AKs4b14442
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 22:54:05 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Mon, 10 May 2004 22:54:04 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4AKs3N10134
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 22:54:03 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Mon, 10 May 2004 22:54:03 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Octane - first light!
Message-ID: <Pine.GSO.4.10.10405102250120.9926-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Well, we've got usermode now. There is no keyboard driver so I can't
comment on interactive work (and I am too lazy to set up a complete telnet
server :), but all interesting scripts I gave it worked. Network is OK,
the QLogic SCSI driver does not work for some reason or another (it can't
communicate with hardware - why?), the console driver is nice and seems to
work rock-solid, high IRQ load (ping -f) does not break anything.

I found another 32-bit infelicity in kernel/scall64-o32.S in stackargs:
using subu instead of dsubu for jump address calculation... Any more of
these and I will have an overflow exception on anger.

Tomorrow, or somewhere in the next week I'm doing keyboard support.

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
