Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 11:16:28 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:50308 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20037767AbWHGKQ0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2006 11:16:26 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id D37F644872; Mon,  7 Aug 2006 12:15:48 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.62)
	(envelope-from <ths@networkno.de>)
	id 1GA23E-0001HO-NE; Mon, 07 Aug 2006 11:09:36 +0100
Date:	Mon, 7 Aug 2006 11:09:36 +0100
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Problem booting malta with 2.4.33-rc1
Message-ID: <20060807100936.GD4383@networkno.de>
References: <f07e6e0608062331p4ef621afn67764067f5b822c2@mail.gmail.com> <20060807181020.37d94241.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807181020.37d94241.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.12-2006-07-14
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Yoichi Yuasa wrote:
> Hi,
> 
> On Mon, 7 Aug 2006 12:01:43 +0530
> "Kishore K" <hellokishore@gmail.com> wrote:
> 
> > Hi,
> > When trying to bring up Malta (4KC) board with 2.4.33-rc1 from linux-mips,
> > the kernel crashes. Boot log is enclosed along with this mail. I am using
> > the tool chain based on gcc 3.3.6, uClibc-0.9.27, binutils 2.14.90.0.8.
> > When the same tool chain is used for 2.4.31 kernel, the board comes up
> > without any issues.
> > 
> > Observed the same issue with tool chain based on gcc 3.4.4, uClibc-0.9.28,
> > binutils 2.15.94. Same result is observed even with  Malta 24KEC and
> > 2.4.33-rc1 kernel.
> > 
> > Does any one observe the same behaviour ? Am I missing something obvious
> > here ?
> 
> I have seen the same problem with gcc 3.4.4 mipssde-6.03.01-20051114 and
>  binutils 2.15.94 mipssde-6.03.01-20051114 with 2.6.6 kernel.
> gcc 3.3.2 and binutils 2.14.90.0.8 20040114 has no problem with same kernel.

Linux 2.4 has known issues with gcc 3.4 and higher, gcc 3.3 is the last
recommended version. The Malta configuration was fixed at some point to
work with 3.4, other configurations weren't.

The usual recommendation is an upgrade to a reasonably recent Linux 2.6. :-)


Thiemo
