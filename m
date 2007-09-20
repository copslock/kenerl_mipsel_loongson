Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 19:34:57 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.251]:47811 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023541AbXITSes (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 19:34:48 +0100
Received: by an-out-0708.google.com with SMTP id d26so92335and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 11:34:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IfheUKiB9DJ1tLG/6KjMHy2oG9HLcpPqz8zIkGPhTZw=;
        b=mlhAYTR8+LIbX74/tXQARdBwCuOqVM7i95qsGQbXH9FAhZxsh88Al5v5BEIIbelwWqav8ZcA788Q2GDfOwLg4UuZBVgxf9BmjjjCl1PqWt+Bip5PIthOkho12Qb413m3EUo+YNDO+2iNVah052DpE28ifAc6EOcyaPQQMPGyd4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G2ObAyDDddOwfp1uqy7KMo/WXuDX3ZHUkAKWwL2BGHfZfzZ017nbTptxtARr8BoUvJa6I/STfI480ZokIQA75dc9VJ4Q/wP3W7Bp/Cpt8rDdb0gm5V9wgErOZoBI+8+T+0xAVK+vOXHO9QhieEH/XdwQ5DHQKWbBN/7Qs6sQv7U=
Received: by 10.100.109.13 with SMTP id h13mr4327539anc.1190313270405;
        Thu, 20 Sep 2007 11:34:30 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id 30sm1542228hso.2007.09.20.11.34.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 11:34:26 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Date:	Thu, 20 Sep 2007 20:34:21 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org, Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200709201728.10866.technoboy85@gmail.com> <200709201755.06712.technoboy85@gmail.com> <20070920175204.GA26132@lst.de>
In-Reply-To: <20070920175204.GA26132@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709202034.21764.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Thursday 20 September 2007 19:52:05 hai scritto:
> > +#include <linux/squashfs_fs.h>
> 
> As Ralf mentioned this is not in mainline, so you can't include it.
> Fortunately for you including it seems to be a rather dumb idea anyway,
> see below for further comments.

You're right, i'll move the magic into linux/magic.h

> > +static struct mtd_partition ar7_parts[5];
> 
> Can we please get a symbolic name for that 5?  Then again we only
> seems to use 3 anyway, and create_mtd_partitions returns 4..

we use 4, and bootloader  is right, it returns 4
The fourth partition is empty, the kernel formats it as jffs2
when mounting

> > +	unsigned int root_offset = 0xe0000;
> 
> Please provide a symbolic name for this one.

Ok

> > +	printk(KERN_INFO "Parsing AR7 partition map...\n");
> 
> Do we really need this printk?

No?

> > +		if (header.checksum == 0xfeedfa42)
> > +			break;
> > +		if (header.checksum == 0xfeed1281)
> > +			break;
> 
> These two want symbolic names, please:
> 
> enum {
> 	/* some comment */
> 	FOO_PART_MAGIC = 0xfeedfa42,	
> 
> 	/* more comment */
> 	BAR_PART_MAGIC = 0xfeed1281,
> };
> 
> > +	switch (header.checksum) {
> > +	case 0xfeedfa42:
> > +		while (header.length) {
> > +			offset += sizeof(header) + header.length;
> > +			master->read(master, offset, sizeof(header),
> > +				     &len, (u_char *)&header);
> > +		}
> > +		root_offset = offset + sizeof(header) + 4;
> > +		break;
> > +	case 0xfeed1281:
> 
> Especially as you use them here again.

Right, will do


> > +	default:
> > +		printk(KERN_WARNING "Unknown magic: %08x\n", header.checksum);
> > +		break;
> > +	}
> > +
> > +	master->read(master, root_offset,
> > +		sizeof(header), &len, (u_char *)&header);
> > +	if (header.checksum != SQUASHFS_MAGIC) {
> > +		root_offset += master->erasesize - 1;
> > +		root_offset &= ~(master->erasesize - 1);
> > +	}
> 
> And after this I'm pretty sure either of the two hex constants above
> is SQUASHFS_MAGIC.  But not actually the magic in the squashfs
> superblock, but someone decided to reuse it for the partitions magic.
> So one of the comments for *_PART_MAGIC becomes:
> 
> 	/* same as SQUASHFS_MAGIC for some odd reason.. */

No. There are MIPS instructions. We look for the loader
start offset since it is in the first partition
