Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jul 2004 19:59:37 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:24806
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224986AbUGYS7c>; Sun, 25 Jul 2004 19:59:32 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i6PIxUF21097
	for <linux-mips@linux-mips.org>; Sun, 25 Jul 2004 20:59:30 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sun, 25 Jul 2004 20:59:30 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i6PIxTb27964
	for <linux-mips@linux-mips.org>; Sun, 25 Jul 2004 20:59:30 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sun, 25 Jul 2004 20:59:29 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Octane news
Message-ID: <Pine.GSO.4.10.10407252053250.27616-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

Hello all.

After a long delay I can finally announce something important about Octane
Linux. We are a little nearer to having accelerated graphics support on
IP30.

I managed to set the card into 24-bit RGB pixel format.
I can draw accelerated lines.
I can draw arbitrary accelerated Gouraud-shaded (or not) triangles.
I can draw accelerated characters and bitmaps.

I can't read anything from the frame buffer.
I can't effectively draw pixmaps.
I can't change video mode (however, I'm working on it).
I can't take advantage of the GE11 Geometry Engines, so all triangle
setups and transforms are performed in software.

If anyone has *any* information that might be helpful in achieving the
mentioned goals (especially the GE11 support), please help me.

Thanks for your attention,

Stanislaw Skowronek

--<=>--
  "You're not as old as the trees, not as young as the leaves.
   Not as free as the breeze, not as open as the seas."
