Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 04:39:56 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:653 "EHLO
	athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225226AbUDUDjz>; Wed, 21 Apr 2004 04:39:55 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3L3dru25710
	for <linux-mips@linux-mips.org>; Wed, 21 Apr 2004 05:39:53 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Wed, 21 Apr 2004 05:39:53 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3L3dqH19640
	for <linux-mips@linux-mips.org>; Wed, 21 Apr 2004 05:39:52 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Wed, 21 Apr 2004 05:39:52 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: [RFC] Separate time support for using cpu timer
In-Reply-To: <20040420162500.H22846@mvista.com>
Message-ID: <Pine.GSO.4.10.10404210537180.19332-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

I must admit I would prefer a separate timer module. For instance, on the
IP30 there is a very convenient HEART timer available, and I don't see a
case for wasting a core-synchronized CPU timer (which proved indispensable
during my reverse engineering of the ARCS PROM, as you can't
breakpoint-debug a PROM) for the purpose of not-necessariliy-synchronized
timing.

Stanislaw Skowronek

--<=>--
  Paranoid: one who is truly in touch with reality.
