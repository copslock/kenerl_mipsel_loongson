Received:  by oss.sgi.com id <S553870AbRBTUwI>;
	Tue, 20 Feb 2001 12:52:08 -0800
Received: from u-12-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.12]:62958
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553853AbRBTUv4>; Tue, 20 Feb 2001 12:51:56 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1KKpI704304;
	Tue, 20 Feb 2001 21:51:18 +0100
Date:   Tue, 20 Feb 2001 21:51:18 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     ldavies@oz.agile.tv
Cc:     linux-mips <linux-mips@oss.sgi.com>
Subject: Re: pci io remapping and ide_ioreg_t
Message-ID: <20010220215118.D2086@bacchus.dhis.org>
References: <3A91F56F.9020603@agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A91F56F.9020603@agile.tv>; from ldavies@agile.tv on Tue, Feb 20, 2001 at 02:41:19PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 20, 2001 at 02:41:19PM +1000, Liam Davies wrote:

> I have an old (2.0.x) ide driver that used to hard code the 
> hwif->io_ports up to the 0x100001f0-0x100001f7 range. This is now broken 
> in the 2.4 kernel since ide_ioreg_t has changed from unsigned long to 
> unsigned short.
> 
> What is the mechanism for reaching these ports now?

Consider this size of ide_ioreg_t a glitch; most current MIPS designs
have their IDE ports in outer space.  It shouldn't break anything, so
until somebody is going to cry I'll change it to unsigned long.

  Ralf
