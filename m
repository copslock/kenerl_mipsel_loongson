Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 08:20:49 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:42193
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226526AbVGLHUX>; Tue, 12 Jul 2005 08:20:23 +0100
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6C7LMT00076;
	Tue, 12 Jul 2005 09:21:22 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 12 Jul 2005 09:21:21 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j6C7LLI28287;
	Tue, 12 Jul 2005 09:21:21 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Tue, 12 Jul 2005 09:21:21 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Current SGI Octane status
In-Reply-To: <20050711222755.GA2952@linux-mips.org>
Message-ID: <Pine.GSO.4.10.10507120920560.27888-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> I suspect it may be related to the RRB allocation.  The driver used to be
> even slower until I made it use a second RRB by using the BRIDGE virtual
> device feature.

I can work on this.

> Obviously all the funky RRB stuff of the BRIDGE has no public documentation.
> However the SN1 / SN2 bits in the kernel tree should be rather close.

If you believe that public documentation is important, think again :))

Stanislaw
