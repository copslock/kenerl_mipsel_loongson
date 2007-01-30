Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 03:53:05 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:10508 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037681AbXA3DxA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2007 03:53:00 +0000
Received: by mo.po.2iij.net (mo30) id l0U3peOW015520; Tue, 30 Jan 2007 12:51:40 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id l0U3pZC1000839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Jan 2007 12:51:35 +0900 (JST)
Date:	Tue, 30 Jan 2007 12:51:35 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	juergen.sell@gmail.com
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
Subject: Re: Support for Vadem/Clio with NEC VR4121 anyone?
Message-Id: <20070130125135.069d58b8.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <816d36d30701291400i7a0e8f4u7f57a5a453f55ae3@mail.gmail.com>
References: <c2c892590606120819m3cf64540n7cfcc8cd0e7fa394@mail.gmail.com>
	<816d36d30606121303u4e6529aat24bf60cd6ae8c37c@mail.gmail.com>
	<c2c892590701291050qe2e6c98q51f4f42d96734e1d@mail.gmail.com>
	<816d36d30701291400i7a0e8f4u7f57a5a453f55ae3@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 29 Jan 2007 18:00:00 -0400
"Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:

> On 1/29/07, Juergen Sell <juergen.sell@gmail.com> wrote:
> > Hi,
> > never got a response from you since my reply.
> > So how far did you get?
> > Please share some info.
> > Juergen
> 
> Hi Jurgen,
> 
> Truth is the thing is here in my table, didn't find the time to get
> pcmcia working, maybe one day I will. I am looking into other boards
> right now, not to mention most of my time is used up with other
> things.
> 
> But what I said in my previous mail remains true, there is plenty of
> support in the kernel, just minor issues that shouldn't need massive
> amounts of work; Yoichi has it done pretty nicely on what VR stuff
> relates to.

I have no information about Clio.

If it's same as IBM WorkPad z50 hardware, please use workpad_defconfig.
It can be boot from CF with hpcboot or pbsdboot(boot loader for NetBSD).
You should connect to PC with serial cable.
Because we have no graphic driver for Clio now.

Yoichi
