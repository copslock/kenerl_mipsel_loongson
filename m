Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 18:14:14 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:53921 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225008AbVEERN7>;
	Thu, 5 May 2005 18:13:59 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j45HDi6t012005
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 19:13:44 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j45HDhxv012003;
	Thu, 5 May 2005 19:13:43 +0200
Date:	Thu, 5 May 2005 19:13:43 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Alex Gonzalez <linux-mips@packetvision.com>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	linux-mips@linux-mips.org, TheNop@gmx.net
Subject: Re:
Message-ID: <20050505171343.GA11754@lst.de>
References: <20050428191608Z8225923-1340+6320@linux-mips.org> <1115214949.13387.13.camel@euskadi.packetvision> <20050505145508.GJ17119@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505145508.GJ17119@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, May 05, 2005 at 03:55:09PM +0100, Ralf Baechle wrote:
> On Wed, May 04, 2005 at 02:55:49PM +0100, Alex Gonzalez wrote:
> 
> > Do you need AGP support? My kernel is configured without it.
> 
> I'm not aware of any AGP bridge for MIPS systems.

The SGI Onyx 4 and Tezro systems have AGP slots, but they a really
running as PCI-X with an odd form factor and there's no AGP GART
(which isn't needed as the systems have a real iommu)
