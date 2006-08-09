Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 13:02:17 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:37074 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20042192AbWHIMCN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Aug 2006 13:02:13 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 19201461C8; Wed,  9 Aug 2006 13:59:10 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1GAlzZ-0008Gc-U3; Wed, 09 Aug 2006 12:12:53 +0100
Date:	Wed, 9 Aug 2006 12:12:53 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck <vagabon.xyz@gmail.com>, franck.bui-huu@innova-card.com
Cc:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line parsing
Message-ID: <20060809111253.GA28128@networkno.de>
References: <1155041312273-git-send-email-vagabon.xyz@gmail.com> <1155041313139-git-send-email-vagabon.xyz@gmail.com> <20060808125604.GI29989@networkno.de> <44D898FE.7080006@innova-card.com> <20060808151409.GA1177@networkno.de> <44D9999E.60908@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D9999E.60908@innova-card.com>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
[snip]
> >>> It also is IMHO a bad idea to overload the
> >>> semantics of initrd= with both file names and memory locations.
> >> I wasn't aware of any file name usages. Can you give a pointer ?
> > 
> > Documentation/initrd.txt
> > Documentation/filesystems/ramfs-rootfs-initramfs.txt
> > 
> 
> I was asking for pointers on MIPS bootloaders which use
> initrd=/path/to/initrd...

AFAIR arcboot does.

> Anyways, you're talking about specific bootloader's parameters,
> aren't you ? I don't know any MIPS bootloaders, but I wouldn't 
> expect them to pass their own parameters to the kernel, that 
> would be surprising...
>
> What are you suggesting ? kernel_initrd ?
> 
> BTW, what do you think about rd_start/rd_size names ?

Is there a good reason to change it?


Thiemo
