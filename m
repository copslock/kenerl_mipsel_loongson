Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Feb 2005 16:01:55 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:16068 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224921AbVBFQBi>; Sun, 6 Feb 2005 16:01:38 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j16Fun1c016069;
	Sun, 6 Feb 2005 15:56:50 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j16FunD8016068;
	Sun, 6 Feb 2005 15:56:49 GMT
Date:	Sun, 6 Feb 2005 15:56:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	linux-mips@linux-mips.org
Subject: Re: patch like kexec for MIPS possible?
Message-ID: <20050206155649.GA11452@linux-mips.org>
References: <20050205174150.GU28252@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.10.10502052025001.1535-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10502052025001.1535-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 05, 2005 at 08:26:04PM +0100, Stanislaw Skowronek wrote:

> > Frankly, I don't see what kexec is good for. Who else besides
> > kernel developers would need to reboot a machine continuously?
> 
> Yeah. And, speaking from experience, it is often caused by the hardware
> entering such an invalid state that requires a hard reset anyway.

I guess only the big iron fraction among us will really be missing
something like kexec - firmware reinitialization may take minutes on that
calibre of system so being able to get around that would be a good thing.

  Ralf
