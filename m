Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 18:52:20 +0100 (BST)
Received: from p508B7024.dip.t-dialin.net ([IPv6:::ffff:80.139.112.36]:41063
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225210AbUIJRwQ>; Fri, 10 Sep 2004 18:52:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i8AHqF91009926;
	Fri, 10 Sep 2004 19:52:15 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i8AHqD0B009925;
	Fri, 10 Sep 2004 19:52:13 +0200
Date: Fri, 10 Sep 2004 19:52:13 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Peter Buckingham <peter@pantasys.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
Message-ID: <20040910175213.GA9910@linux-mips.org>
References: <4140C205.7020405@pantasys.com> <20040910075644.GA27574@lst.de> <4141DAD6.8000802@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4141DAD6.8000802@pantasys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 10, 2004 at 09:48:22AM -0700, Peter Buckingham wrote:

> >>/* These are symbols defined by the ramdisk linker script */
> >>+extern unsigned long initrd_start, initrd_end;
> >>extern unsigned char __rd_start;
> >>extern unsigned char __rd_end;
> >
> >
> >Please use the appropinquate header for these.
> 
> I'd love to use the appropriate header for these, but can't find one. 
> cscope doesn't seem to show that these are defined usefully in a header 
> file.

Winners use grep(1) ;-)

> Can you point me to where these are defined?

Include/linux/initrd.h.

  Ralf
