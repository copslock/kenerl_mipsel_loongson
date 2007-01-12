Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2007 02:46:30 +0000 (GMT)
Received: from mo30.po.2iij.net ([210.128.50.53]:39713 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20047294AbXALCqY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 12 Jan 2007 02:46:24 +0000
Received: by mo.po.2iij.net (mo30) id l0C2kL4v054102; Fri, 12 Jan 2007 11:46:21 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id l0C2kImH092260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Jan 2007 11:46:19 +0900 (JST)
Date:	Fri, 12 Jan 2007 11:46:18 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fixed PCI resource fixup
Message-Id: <20070112114618.78d10a3d.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20070112.004531.132304408.anemo@mba.ocn.ne.jp>
References: <200701110555.l0B5twHe006668@mbox33.po.2iij.net>
	<20070111143116.GA4451@linux-mips.org>
	<20070111234747.7eed9028.yoichi_yuasa@tripeaks.co.jp>
	<20070112.004531.132304408.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Jan 2007 00:45:31 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Thu, 11 Jan 2007 23:47:47 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > <Ralf> I think he should have io_offset = 0.
> > 
> > When I tried io_offset = 0, tulip net driver didn't work.
> > 
> > > Which is what other GT-64120 platforms are using, so I wonder why that is
> > > different on Cobalt.
> > 
> > I don't know, but io_offset is needed for Cobalt.
> 
> If io_offset = 0, GT-64120 must be programmed to remap physicall
> address GT_DEF_PCI0_IO_BASE to PCI IO address 0.  Maybe other GT-64120
> users have such configuraion?

GT-64111(used for Cobalt) has no remap register.
It cannot be programmed to address remap.

Yoichi
