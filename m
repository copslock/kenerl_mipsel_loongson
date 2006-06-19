Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2006 14:52:09 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:33437 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133545AbWFSNwA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Jun 2006 14:52:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5JDpxv5009994;
	Mon, 19 Jun 2006 14:51:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5JDpuYq009959;
	Mon, 19 Jun 2006 14:51:56 +0100
Date:	Mon, 19 Jun 2006 14:51:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Message-ID: <20060619135156.GA9701@linux-mips.org>
References: <000601c6937f$0bed5270$9d0ba8c0@mrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c6937f$0bed5270$9d0ba8c0@mrv>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 19, 2006 at 06:02:08PM +0900, Roman Mashak wrote:

> I was observing this strange problem today while verifying performance of 
> Sequoia board.
> 
> Initial conditions:
> 1) 2.6.12-rc3_L002 kernel from PMCS ftp, compiled for 32bit mode
> 2) bridge code is compiled into kernel
> 3) four 100Mbps ethernet devices and one onboard Gigabit link are joined 
> into bridge using bridge-utils-1.1
> 4) I connected board gigabit link to SmartBit Gb interface and four 100mbps 
> links to SmartBit FastEthernet interfaces
> 
> But 'brctl showmacs br0' shows only fast ethernet links being learned, but 
> never gigabit. We have suspicion that Titan driver affects this somehow.

The Titan driver (the version on linux-mips.org and any other version I've
seen) are pretty broken and remarkably ugly pieces of code.  The authors
of the Basler eXcite platform have contributed their driver and I hope it
will show up upstream soon.  Afaik it has not been tested with any of
PMC's eval boards but the necessary changes should not be hard.

  Ralf
