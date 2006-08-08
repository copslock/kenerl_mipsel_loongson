Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2006 16:18:16 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:45285 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20041235AbWHHPPb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2006 16:15:31 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 55CA844CFB; Tue,  8 Aug 2006 17:15:23 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1GATHV-0000ae-RW; Tue, 08 Aug 2006 16:14:09 +0100
Date:	Tue, 8 Aug 2006 16:14:09 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line parsing
Message-ID: <20060808151409.GA1177@networkno.de>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com> <1155041313139-git-send-email-vagabon.xyz@gmail.com> <20060808125604.GI29989@networkno.de> <44D898FE.7080006@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D898FE.7080006@innova-card.com>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
> > Franck Bui-Huu wrote:
> >> There's no point to rewrite some logic to parse command line
> >> to pass initrd parameters or to declare a user memory area.
> >> We could use instead parse_early_param() that does the same
> >> thing.
> >>
> >> NOTE ! This patch also changes the initrd semantic. Old code
> >> was expecting "rd_start=xxx rd_size=xxx" which uses two
> >> parameters. Now the code expects "initrd=xxx@yyy" which is
> >> really simpler to parse and to use. No default config files
> >> use these parameters anyways but not sure for bootloader's
> >> users...
> > 
> > This code is there precisely because most mips bootloaders use
> > rd_start/rd_size.
> 
> OK, I guess we have to stick with this weird semantic...
> 
> > It also is IMHO a bad idea to overload the
> > semantics of initrd= with both file names and memory locations.
> 
> I wasn't aware of any file name usages. Can you give a pointer ?

Documentation/initrd.txt
Documentation/filesystems/ramfs-rootfs-initramfs.txt


Thiemo
