Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 16:33:52 +0000 (GMT)
Received: from dhcp-1285-65.blizz.at ([IPv6:::ffff:213.143.126.4]:404 "EHLO
	cervus.intra") by linux-mips.org with ESMTP id <S8225203AbVAFQdr>;
	Thu, 6 Jan 2005 16:33:47 +0000
Received: from xterm.intra ([10.49.1.10])
	by cervus.intra with esmtp (Exim 4.34)
	id 1Cmaa1-0004An-Cf; Thu, 06 Jan 2005 17:33:45 +0100
Subject: Re: [PATCH] I/O helpers rework
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
Content-Type: text/plain
Organization: Research Group for Industrial Software @ Vienna University of
	Technology
Date: Thu, 06 Jan 2005 17:33:44 +0100
Message-Id: <1105029224.4361.21.camel@xterm.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips

On Wed, 2004-12-15 at 21:13 +0000, Maciej W. Rozycki wrote:
[..]
>  The changes have been verified with a Malta board for port I/O and with a 
> SWARM one for memory-mapped I/O (with an updated driver; to be sent 
> separately).  Broadcom SiByte systems are the only ones utilizing current 
> __raw_*() and ____raw_*() calls.  I have a patch to convert them to 
> bus_*() and __bus_*() ones as appropriate ready as well.
> 
>  OK to apply?
 
jfyi, this change broke mtd and au1xxx-usb on big endian au1xxx systems,
as the _raw calls do suddenly byteswapping :-(

was this intended?

regards,
-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Research Group for Industrial Software @ Vienna University of Technology
