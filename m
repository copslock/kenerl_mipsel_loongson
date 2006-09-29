Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 12:52:52 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:3740 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038739AbWI2Lwu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 12:52:50 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id E7BB844F25; Fri, 29 Sep 2006 13:52:49 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GTGEb-00079y-Ui; Fri, 29 Sep 2006 12:08:49 +0100
Date:	Fri, 29 Sep 2006 12:08:49 +0100
To:	David Lee <receive4me@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: HELP: opcode not supported on this processor
Message-ID: <20060929110849.GD3868@networkno.de>
References: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee285ba0609290235v7b518495u2dccb1ef82b117d0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

David Lee wrote:
> Hi,
> 
> I am trying to port some code over to MIPSEL from i386. However, I got the
> following error:
> 
> gcc -I/usr/include -O6 -DMODULE -D__KERNEL__ -DEXPORT_SYMTAB
> -I/usr/src/linux/drivers/net -Wal
> l -I. -Wstrict-prototypes -fomit-frame-pointer
> -I/usr/src/linux/drivers/net/wan -I /usr/src/li
> nux/include -I/usr/src/linux/include/net -DMODVERSIONS -include
> /usr/src/linux-2.4/include/lin
> ux/modversions.h  zip.c

You need to use the exactly same compilation options as used for the
kernel. This will fix the problem you see, plus many others you haven't
seen yet.


Thiemo
