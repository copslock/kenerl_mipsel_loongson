Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jul 2004 14:05:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:3852 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225246AbUG0NFF>; Tue, 27 Jul 2004 14:05:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 511ECE1CC4; Tue, 27 Jul 2004 15:04:59 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12977-07; Tue, 27 Jul 2004 15:04:59 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3266DE1CBE; Tue, 27 Jul 2004 15:04:59 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.12.11/8.11.4) with ESMTP id i6RD585x012577;
	Tue, 27 Jul 2004 15:05:09 +0200
Date: Tue, 27 Jul 2004 15:05:02 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ABI question
In-Reply-To: <200407271057.53237.thomas.koeller@baslerweb.com>
Message-ID: <Pine.LNX.4.58L.0407271500160.12915@blysk.ds.pg.gda.pl>
References: <200407271057.53237.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 27 Jul 2004, Thomas Koeller wrote:

> for 2.6 kernels, arch/mips/Makefile contains the following lines:
> 
> ifdef CONFIG_MIPS64
> gcc-abi			= 64
> gas-abi			= 32
> tool-prefix		= $(64bit-tool-prefix)
> UTS_MACHINE		:= mips64
> endif
> 
> Is it intentional that gcc-abi and gas-abi are different? This

 It is -- some people want to use 32-bit pointers within Linux, to 
conserve memory.  It seems to work with older tools, but I've never tried 
that.

> results in '-Wa,-32' appearing on gcc's command line, causing
> the asembler to complain:
> 
> Error: -mgp64 used with a 32-bit ABI
> 
> If I change gas-abi to 64, this error goes away.

 You may run `make "gas-abi=64" <whatever>' as a workaround.  I'm going to 
make it selectable in the configuration one day.

  Maciej
