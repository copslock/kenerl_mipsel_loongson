Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jun 2003 03:22:30 +0100 (BST)
Received: from p508B6123.dip.t-dialin.net ([IPv6:::ffff:80.139.97.35]:27043
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224821AbTFVCW2>; Sun, 22 Jun 2003 03:22:28 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5M2MLbv024355;
	Sun, 22 Jun 2003 04:22:22 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5M2MKRS024295;
	Sun, 22 Jun 2003 04:22:20 +0200
Date: Sun, 22 Jun 2003 04:22:19 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brm@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.5] lasat updates
Message-ID: <20030622022219.GA23358@linux-mips.org>
References: <E19TT3b-00074n-00@brian.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19TT3b-00074n-00@brian.localnet>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 20, 2003 at 11:04:27PM +0200, Brian Murphy wrote:

> This patch fixes up the Lasat code so it works as well as 
> before the latest chain of updates (which is not quite).
> The patch to the PCI code is necessary because I stupidly
> copied the code from the mips-boards code which also has the
> same problem (writes of full 32 bit words are ignored). 
> The people who made pci-sb1250.c seem to have 
> made the same error too...

Yep, too much code copying.  Guess why I'm doing this no-prisoners taken
cleanup of the PCI code ...

  Ralf
