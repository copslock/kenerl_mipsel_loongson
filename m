Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2004 15:54:41 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:36585
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225563AbUEOOyi>; Sat, 15 May 2004 15:54:38 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4FEsWg17617;
	Sat, 15 May 2004 16:54:32 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 15 May 2004 16:54:32 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i4FEsVX29452;
	Sat, 15 May 2004 16:54:31 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Sat, 15 May 2004 16:54:31 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: XKPHYS_KERNEL patch - kernel in 64-bit space
In-Reply-To: <20040515145056.GC14219@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.10.10405151653550.29397-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> This flush_icache_range should start from CKSEG0, not (CKSEG0 + 80).

Ahh, yeah - not important as we can't get the first exception anyway. But
would be nice to fix.

Stanislaw Skowronek
