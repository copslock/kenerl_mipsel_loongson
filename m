Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 21:08:30 +0100 (BST)
Received: from lazybastard.de ([212.112.238.170]:18915 "EHLO
	longford.lazybastard.org") by ftp.linux-mips.org with ESMTP
	id S20023738AbXITUIW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 21:08:22 +0100
Received: from joern by longford.lazybastard.org with local (Exim 4.50)
	id 1IYSCs-0000WY-1N; Thu, 20 Sep 2007 22:01:02 +0200
Date:	Thu, 20 Sep 2007 22:00:59 +0200
From:	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070920200058.GB1692@lazybastard.org>
References: <200709201728.10866.technoboy85@gmail.com> <20070920175204.GA26132@lst.de> <200709202034.21764.technoboy85@gmail.com> <200709202129.12261.technoboy85@gmail.com> <20070920193547.GA911@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070920193547.GA911@lst.de>
User-Agent: Mutt/1.5.9i
Return-Path: <joern@lazybastard.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joern@logfs.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 September 2007 21:35:49 +0200, Christoph Hellwig wrote:
> On Thu, Sep 20, 2007 at 09:29:11PM +0200, Matteo Croce wrote:
> > +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> > +#define LOADER_MAGIC1	0xfeedfa42
> > +#define LOADER_MAGIC2	0xfeed1281
> > +#else
> > +#define LOADER_MAGIC1	0x42faedfe
> > +#define LOADER_MAGIC2	0x8112edfe
> > +#endif
> 
> Please keep only one defintion and use le/be32_to_cpu on it.
> 
> > +struct ar7_bin_rec {
> > +	unsigned int checksum;
> > +	unsigned int length;
> > +	unsigned int address;
> > +};
> 
> Wich means you'd need an endianess annotation here.  What about the
> length and address fields, are they always native-endian unlike
> the checksum field or will the need to be byte-swapped aswell?

<slightly off-topic, feel free to skip>
If this is indeed the squashfs magic, le/be32_to_cpu won't help.
Squashfs can have either endianness, tries to detect the one actually
used by checking either magic and sets a flag in the superblock.
Afterwards every single access checks the flag and conditionally swaps
fields around or not.

If squashfs had a fixed endianness, quite a lot of this logic could get
removed and both source and object size would shrink.  Some two years
after requesting this for the first time, I'm thinking about just doing
it myself.  If I find a sponsor who pays me for it, I might even do it
soon.
</offtopic>


I don't really understand why the squashfs magic number should be used
in this code at all.  It may have set a bad example, though.  In general
you should decide on a fixed endianness (1) and use the beXX_to_cpu
macros when accessing data unless you have a very good reason to do
otherwise.

1) Big endian is my preferred choice because it is easy to read in a
hexdump and the opposite of my notebook.  Being forced to do endian
conversions during development/testing helps to find problems early.

Jörn

-- 
Joern's library part 13:
http://www.chip-architect.com/
