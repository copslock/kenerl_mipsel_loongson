Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 18:11:35 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:40714 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225534AbVAJSLa>;
	Mon, 10 Jan 2005 18:11:30 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Co46m-0005Fz-00; Mon, 10 Jan 2005 18:17:40 +0000
Received: from [192.168.192.200] (helo=perivale.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Co40Y-0008JK-00; Mon, 10 Jan 2005 18:11:14 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Co40Y-0004ob-00; Mon, 10 Jan 2005 18:11:14 +0000
Date: Mon, 10 Jan 2005 18:11:14 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <20050111.022138.25909508.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.61.0501101750420.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
 <20050107.004521.74752947.anemo@mba.ocn.ne.jp> <Pine.LNX.4.61.0501101503020.18023@perivale.mips.com>
 <20050111.022138.25909508.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.722,
	required 4, AWL, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Tue, 11 Jan 2005, Atsushi Nemoto wrote:

> Well, maybe the 'volatile' have no sense, but some archs (including
> i386, of course :-)) and some drivers use it.  Adding the 'volatile'
> will remove some compiler warnings.

 As will removing "volatile" from broken ports.

> Yes, virt-to-phys conversion might be needed, but if we only use KSEG1
> for I/O port/memory, it does not matter.

 ioremap() is free to return a KSEG2 address on a 32-bit system.  With 
64-bit systems there is no problem.

> And I have some custom boards which really needs different swapping
> properties (PCI regions need SWAP_IO_SPACE, but ISA region does not,
> for example).  I agree that those boards were misdesigned but I want
> to run Linux on it without modifying existing drivers.

 Hmm, that's strange -- does the system glue ISA otherwise than behind a 
PCI-ISA bridge?  So far I've only spotted a single PCI/ISA system wiring 
the buses as "peers", namely the ancient Intel's i82420EX for 486-class 
processors.

  Maciej
