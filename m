Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 05:18:38 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:56763
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbTE0ESf>; Tue, 27 May 2003 05:18:35 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4R4IVbY014043;
	Mon, 26 May 2003 21:18:31 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4R4IVMg014042;
	Tue, 27 May 2003 06:18:31 +0200
Date: Tue, 27 May 2003 06:18:30 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] pci_alloc_consistent() crash
Message-ID: <20030527041830.GA14012@linux-mips.org>
References: <Pine.GSO.4.21.0305231549510.26586-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0305231549510.26586-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 23, 2003 at 03:51:00PM +0200, Geert Uytterhoeven wrote:

> Avoid a NULL-pointer dereference when using pci_alloc_consistent() for
> PCI-like buses (i.e. hwdev = NULL).

Thanks, applied.

  Ralf
