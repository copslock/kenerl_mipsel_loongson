Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Feb 2005 19:58:23 +0000 (GMT)
Received: from athena.et.put.poznan.pl ([IPv6:::ffff:150.254.29.137]:36745
	"EHLO athena.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8225244AbVBET6H>; Sat, 5 Feb 2005 19:58:07 +0000
Received: from athena (athena.et.put.poznan.pl [150.254.29.137])
	by athena.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j15Jw6u18810
	for <linux-mips@linux-mips.org>; Sat, 5 Feb 2005 20:58:06 +0100 (MET)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by athena.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Sat, 5 Feb 2005 20:58:05 +0100 (MET)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j15JQ6601701
	for <linux-mips@linux-mips.org>; Sat, 5 Feb 2005 20:26:06 +0100 (MET)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Sat, 5 Feb 2005 20:26:04 +0100 (MET)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	linux-mips@linux-mips.org
Subject: Re: patch like kexec for MIPS possible?
In-Reply-To: <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.10.10502052025001.1535-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

> Frankly, I don't see what kexec is good for. Who else besides
> kernel developers would need to reboot a machine continuously?

Yeah. And, speaking from experience, it is often caused by the hardware
entering such an invalid state that requires a hard reset anyway.

Stanislaw Skowronek
