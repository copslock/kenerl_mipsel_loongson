Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Apr 2004 21:29:16 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:56714 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225528AbUDVU3Q>;
	Thu, 22 Apr 2004 21:29:16 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i3MKT7Qc013283
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Apr 2004 22:29:08 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i3MKT7MJ013281;
	Thu, 22 Apr 2004 22:29:07 +0200
Date: Thu, 22 Apr 2004 22:29:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: Alex Deucher <agd5f@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: few questions about linux on sgi machines
Message-ID: <20040422202907.GA13266@lst.de>
References: <20040422174916.42579.qmail@web11309.mail.yahoo.com> <Pine.GSO.4.10.10404222022560.27253-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404222022560.27253-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 22, 2004 at 08:28:46PM +0200, Stanislaw Skowronek wrote:
> > Also, out of curiosity, is there a list somewhere of all the asics in
> > the Octane?  e.g., sound chip(s), ethernet, parallel/serial, etc.
> 
> Yes! (It depends what do you call an ASIC. I use it for a SGI-specific
> chip with no docs at all.)
> 
> -- Base I/O --
> BRIDGE	Xtalk-PCI bridge?

Yes.  The same as used in the IP27 btw.

> -- Frontplane --
> XBOW	Xtalk router

Also shared witg IP27.
