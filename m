Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 11:30:14 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:212.34.189.10]:41662 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225962AbUDXKaN>;
	Sat, 24 Apr 2004 11:30:13 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i3OAU4Qc015359
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Apr 2004 12:30:05 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i3OAU4YC015357;
	Sat, 24 Apr 2004 12:30:04 +0200
Date: Sat, 24 Apr 2004 12:30:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: linux-mips@linux-mips.org
Subject: Re: pci-ip27 memory ranges
Message-ID: <20040424103004.GA15322@lst.de>
References: <Pine.GSO.4.10.10404241059030.18252-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404241059030.18252-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 11:00:44AM +0200, Stanislaw Skowronek wrote:
> Why does the pci-ip27 driver register all memory resources (0UL - ~0UL)?

The current PCI support for IP27 is more or less a huge hack.  I plan to
hack it up to do the right thing based on the IRIX code for it released
by SGI, but it'll take a bit because that code isn't exactly readable
and my time is rather limited.
