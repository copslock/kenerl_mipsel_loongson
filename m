Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 13:06:36 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:16653 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225305AbVAJNGa>;
	Mon, 10 Jan 2005 13:06:30 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CnzLV-0006ly-00; Mon, 10 Jan 2005 13:12:33 +0000
Received: from [192.168.192.200] (helo=perivale.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CnzF1-0003Pd-00; Mon, 10 Jan 2005 13:05:51 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CnzF1-0004iw-00; Mon, 10 Jan 2005 13:05:51 +0000
Date: Mon, 10 Jan 2005 13:05:51 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I/O helpers rework
In-Reply-To: <1105029224.4361.21.camel@xterm.intra>
Message-ID: <Pine.LNX.4.61.0501101249280.18023@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
 <1105029224.4361.21.camel@xterm.intra>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.719,
	required 4, AWL, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Thu, 6 Jan 2005, Herbert Valerio Riedel wrote:

> jfyi, this change broke mtd and au1xxx-usb on big endian au1xxx systems,
> as the _raw calls do suddenly byteswapping :-(
> 
> was this intended?

 It was.  Generic code elsewhere expects it and the MIPS implementation 
used to be broken because of that.  Note these functions are intended for 
PCI/EISA/ISA accesses only and these buses are little-endian by 
definition.  More specifically __raw_ calls are mainly for PIO copying 
to/from memory over these buses when you want to keep byte ordering the 
same as it would be for a DMA transfer.

 If you have a driver that handles a non-PCI/EISA/ISA device you may and 
probably should use bus_ calls to get a non-swapped access.

  Maciej
