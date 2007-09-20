Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 20:36:24 +0100 (BST)
Received: from verein.lst.de ([213.95.11.210]:10164 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20023705AbXITTgQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2007 20:36:16 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8KJZsA5001252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Sep 2007 21:35:54 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id l8KJZqPc001240;
	Thu, 20 Sep 2007 21:35:52 +0200
Date:	Thu, 20 Sep 2007 21:35:49 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Message-ID: <20070920193547.GA911@lst.de>
References: <200709201728.10866.technoboy85@gmail.com> <20070920175204.GA26132@lst.de> <200709202034.21764.technoboy85@gmail.com> <200709202129.12261.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709202129.12261.technoboy85@gmail.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Sep 20, 2007 at 09:29:11PM +0200, Matteo Croce wrote:
> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> +#define LOADER_MAGIC1	0xfeedfa42
> +#define LOADER_MAGIC2	0xfeed1281
> +#else
> +#define LOADER_MAGIC1	0x42faedfe
> +#define LOADER_MAGIC2	0x8112edfe
> +#endif

Please keep only one defintion and use le/be32_to_cpu on it.

> +struct ar7_bin_rec {
> +	unsigned int checksum;
> +	unsigned int length;
> +	unsigned int address;
> +};

Wich means you'd need an endianess annotation here.  What about the
length and address fields, are they always native-endian unlike
the checksum field or will the need to be byte-swapped aswell?
