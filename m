Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 16:09:16 +0100 (BST)
Received: from europa.et.put.poznan.pl ([IPv6:::ffff:150.254.29.138]:30625
	"EHLO europa.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225326AbUFAPJM>; Tue, 1 Jun 2004 16:09:12 +0100
Received: from europa (europa.et.put.poznan.pl [150.254.29.138])
	by europa.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i51F9Ab29986
	for <linux-mips@linux-mips.org>; Tue, 1 Jun 2004 17:09:10 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by europa.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 1 Jun 2004 17:09:09 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i51F99a27604
	for <linux-mips@linux-mips.org>; Tue, 1 Jun 2004 17:09:09 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Tue, 1 Jun 2004 17:09:09 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: linux-mips@linux-mips.org
Subject: Re: Indigo2 Power up for donation
Message-ID: <Pine.GSO.4.10.10406011708210.27255-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

To support the R8000, you would have to search for all references to
CKSEG0 and KSEG0. I would recommend my 64-bit patch to begin with, as it
provides support for kernel placed in XKPHYS 64-bit segment. Normal MIPS
kernels will not (AFAIK) run on the R8000. If anyone does this, I would be
interested in the results.

Stanislaw
