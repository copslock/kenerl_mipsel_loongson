Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7HBow032138
	for linux-mips-outgoing; Fri, 17 Aug 2001 04:50:58 -0700
Received: from dea.waldorf-gmbh.de (u-214-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.214])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7HBosj32133
	for <linux-mips@oss.sgi.com>; Fri, 17 Aug 2001 04:50:55 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7HBmt805382;
	Fri, 17 Aug 2001 13:48:55 +0200
Date: Fri, 17 Aug 2001 13:48:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: patch for ide_init_hwif_ports
Message-ID: <20010817134855.A5318@bacchus.dhis.org>
References: <20010817.121334.41627251.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010817.121334.41627251.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Fri, Aug 17, 2001 at 12:13:34PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 17, 2001 at 12:13:34PM +0900, Atsushi Nemoto wrote:

> There is 'ide_init_hwif_ports' member in ide_ops structure but
> currently never used.  This is a patch to use this (again).

Looks good, applied.

  Ralf
