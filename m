Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 10:20:15 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:43897 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S28573939AbZD1JUH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 10:20:07 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n3S9K5IF002524
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Apr 2009 11:20:05 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id n3S9K5kZ002522;
	Tue, 28 Apr 2009 11:20:05 +0200
Date:	Tue, 28 Apr 2009 11:20:05 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Shane McDonald <mcdonald.shane@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Message-ID: <20090428092005.GA2408@lst.de>
References: <E1LyQQX-00047N-6E@localhost> <20090427130952.GA30817@linux-mips.org> <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f740e80904270622u730ba067g660257847dc526de@mail.gmail.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Apr 27, 2009 at 03:22:33PM +0200, Geert Uytterhoeven wrote:
> He needs the definition of struct squashfs_super_block to access the .bytes_used
> field. Alternatively, the offset of that field must be hardcoded.

No, that whole crap needs to go.  FS code has no business poking into fs
internal structures.  BTW, this whole setup is really, really gross,
it's mtd map driver calling arch code to get base + size for mapping,
poking into fs internal structures.  I really wonder what people have
been smoking to come up with crap like that.

We should just leave it uncompilable as a sign for future generations
not to such stupid stuff.
