Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 09:09:49 +0100 (BST)
Received: from p508B7CAD.dip.t-dialin.net ([IPv6:::ffff:80.139.124.173]:56801
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225392AbTJIIJm>; Thu, 9 Oct 2003 09:09:42 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9989fNK007257;
	Thu, 9 Oct 2003 10:09:41 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9989evi007256;
	Thu, 9 Oct 2003 10:09:40 +0200
Date: Thu, 9 Oct 2003 10:09:40 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
Cc: linux-mips@linux-mips.org
Subject: Re: kmalloc question
Message-ID: <20031009080940.GC19372@linux-mips.org>
References: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB76D@iris.adtech-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB76D@iris.adtech-inc.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 08, 2003 at 03:06:50PM -1000, Finney, Steve wrote:

> Is kmalloc (GFP_KERNEL) on a 32 bit HIGHMEM enabled MIPS kernel (BCM/Sibyte processor) guaranteed to allocate memory from the low, KSEG0/1 addressible region? I'm having trouble sorting through the slab.c code. On this processor, only 256 MB of DRAM is directly addressible; with more than 256 MB of RAM, there is 256 MB in zone 0, and the remainder in zone 2. Zone 1 is empty.

Yes.

  Ralf
