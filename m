Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 09:18:31 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:5605 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20024241AbXIUISV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 09:18:21 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 4D838230104;
	Fri, 21 Sep 2007 10:18:21 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 649532300FB;
	Fri, 21 Sep 2007 10:18:15 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l8L8IFLF030401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2007 10:18:15 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l8L8I5V9030396;
	Fri, 21 Sep 2007 10:18:06 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 21 Sep 2007 10:18:05 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>, dwmw2@infradead.org,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
In-Reply-To: <200709202129.12261.technoboy85@gmail.com>
Message-ID: <Pine.LNX.4.64.0709211017120.5097@anakin>
References: <200709201728.10866.technoboy85@gmail.com> <20070920175204.GA26132@lst.de>
 <200709202034.21764.technoboy85@gmail.com> <200709202129.12261.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 20 Sep 2007, Matteo Croce wrote:
> +static int create_mtd_partitions(struct mtd_info *master,
> +				 struct mtd_partition **pparts,
> +				 unsigned long origin)
> +{

    [...]

> +		master->read(master, offset,
> +			sizeof(header), &len, (u_char *)&header);
                                              ^^^^^^^^^^^
Probably we should teach mtd to use `void *' for read and write buffers,
so all these ugly casts can go away...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
