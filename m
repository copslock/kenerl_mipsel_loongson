Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 16:41:42 +0100 (BST)
Received: from canuck.infradead.org ([209.217.80.40]:54739 "EHLO
	canuck.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20021377AbXIFPld (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 16:41:33 +0100
Received: from [217.206.93.210] (helo=[10.0.0.80])
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1ITJTp-0007zF-9I; Thu, 06 Sep 2007 11:41:20 -0400
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd
From:	David Woodhouse <dwmw2@infradead.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, linux-mtd@lists.infradead.org
In-Reply-To: <200709061723.21091.technoboy85@gmail.com>
References: <200708201704.11529.technoboy85@gmail.com>
	 <200709061723.21091.technoboy85@gmail.com>
Content-Type: text/plain
Date:	Thu, 06 Sep 2007 16:41:22 +0100
Message-Id: <1189093282.2745.147.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 (2.10.3-3.fc7.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+9057b7c66b6c19d08d07+1474+infradead.org+dwmw2@canuck.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Thu, 2007-09-06 at 17:23 +0200, Matteo Croce wrote:
> +	unsigned int pre_size = master->erasesize, post_size = 0,
> +		root_offset = 0xe0000;

Separate lines for those, please.

> +	int retries = 10;
> +
> +	printk("Parsing AR7 partition map...\n");

Needs priority. (As do one or two other printks).

> +	do {
> +		offset = pre_size;
> +		master->read(master, offset, sizeof(header), &len, (u_char
> *)&header);
> +		if (!strncmp((char *)&header, "TIENV0.8", 8))
> +			ar7_parts[1].offset = pre_size;
> +		if (header.checksum == 0xfeedfa42)
> +			break;
> +		if (header.checksum == 0xfeed1281)
> +			break;
> +		pre_size += master->erasesize;
> +	} while (retries--);

Needs some comments. What are the magic numbers? What is this retry
thing all about?

Endianness?

> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Felix Fietkau, Eugene Konev");

Normally I prefer to see email addresses in MODULE_AUTHOR(). You missed
them from the comments at the top of the file too.

-- 
dwmw2
