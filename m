Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 11:24:47 +0000 (GMT)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:16852
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8224920AbULVLYn>; Wed, 22 Dec 2004 11:24:43 +0000
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id iBMBOSM19525
	for <linux-mips@linux-mips.org>; Wed, 22 Dec 2004 12:24:28 +0100 (MET)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Wed, 22 Dec 2004 11:35:44 +0100 (MET)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id iBMAZhm08470
	for <linux-mips@linux-mips.org>; Wed, 22 Dec 2004 11:35:43 +0100 (MET)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Wed, 22 Dec 2004 11:35:43 +0100 (MET)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: port on exotic board.
In-Reply-To: <20041222095514.41874.qmail@web25101.mail.ukl.yahoo.com>
Message-ID: <Pine.GSO.4.10.10412221132240.8260-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> yes and anyway the default value for WIRED is zero
> after a reset.

PROMs *do* have interesting ideas sometimes.

> I can't believe that I'm the first one on mips 
> architecture who is trying to run kernel code located
> at a physicall address different from 0 !

Sure you aren't. If you have a 64-bit machine, it's relatively easy in
fact. If your code and data is above 512 MB, you are a little more
screwed, but it still can be done (as evidenced by me), and CPHYSADDR does
not, enter the discussion at all. All you have to do is create a correct
memory map at start.

I don't know about running mapped kernels in 32-bit mode, though. It is a
different thing whatsoever.

Stanislaw Skowronek
