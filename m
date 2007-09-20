Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 18:53:26 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:54186 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20023416AbXITRxR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 18:53:17 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8KHq8A5026539
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Sep 2007 19:52:08 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l8KHq6Vx026537;
	Thu, 20 Sep 2007 19:52:06 +0200
Date:	Thu, 20 Sep 2007 19:52:05 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070920175204.GA26132@lst.de>
References: <200709201728.10866.technoboy85@gmail.com> <200709201755.06712.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709201755.06712.technoboy85@gmail.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

> +#include <linux/squashfs_fs.h>

As Ralf mentioned this is not in mainline, so you can't include it.
Fortunately for you including it seems to be a rather dumb idea anyway,
see below for further comments.

> +static struct mtd_partition ar7_parts[5];

Can we please get a symbolic name for that 5?  Then again we only
seems to use 3 anyway, and create_mtd_partitions returns 4..

> +	unsigned int root_offset = 0xe0000;

Please provide a symbolic name for this one.

> +	printk(KERN_INFO "Parsing AR7 partition map...\n");

Do we really need this printk?

> +		if (header.checksum == 0xfeedfa42)
> +			break;
> +		if (header.checksum == 0xfeed1281)
> +			break;

These two want symbolic names, please:

enum {
	/* some comment */
	FOO_PART_MAGIC = 0xfeedfa42,	

	/* more comment */
	BAR_PART_MAGIC = 0xfeed1281,
};

> +	switch (header.checksum) {
> +	case 0xfeedfa42:
> +		while (header.length) {
> +			offset += sizeof(header) + header.length;
> +			master->read(master, offset, sizeof(header),
> +				     &len, (u_char *)&header);
> +		}
> +		root_offset = offset + sizeof(header) + 4;
> +		break;
> +	case 0xfeed1281:

Especially as you use them here again.

> +	default:
> +		printk(KERN_WARNING "Unknown magic: %08x\n", header.checksum);
> +		break;
> +	}
> +
> +	master->read(master, root_offset,
> +		sizeof(header), &len, (u_char *)&header);
> +	if (header.checksum != SQUASHFS_MAGIC) {
> +		root_offset += master->erasesize - 1;
> +		root_offset &= ~(master->erasesize - 1);
> +	}

And after this I'm pretty sure either of the two hex constants above
is SQUASHFS_MAGIC.  But not actually the magic in the squashfs
superblock, but someone decided to reuse it for the partitions magic.
So one of the comments for *_PART_MAGIC becomes:

	/* same as SQUASHFS_MAGIC for some odd reason.. */
