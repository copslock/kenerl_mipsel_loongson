Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2004 19:54:57 +0100 (BST)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:64944
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226045AbUD0Sy4>; Tue, 27 Apr 2004 19:54:56 +0100
Received: from athena (athena [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3RIsQu08681;
	Tue, 27 Apr 2004 20:54:26 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena (MailMonitor for SMTP v1.2.2 ) ;
	Tue, 27 Apr 2004 20:54:25 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id i3RIsP617186;
	Tue, 27 Apr 2004 20:54:25 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date: Tue, 27 Apr 2004 20:54:25 +0200 (MET DST)
From: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: TLB on R10k
In-Reply-To: <20040427183309.GR16797@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.10.10404272053350.17125-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Sloppiness, I guess. They resolve to function pointers anyway. But the
> flush_icache_range should be fixed to cover all memcpy'ed memory.

Yes, I've done it, too. Still gets hung. I wonder why, I have looked at
all exception code and it is 64-bit-clean (except for some bit that is
only compiled on SMP, so I don't really care).

/s
