Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 22:48:59 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:25923 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20040591AbWHGVrS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2006 22:47:18 +0100
Received: by mo.po.2iij.net (mo30) id k77Ll4it082879; Tue, 8 Aug 2006 06:47:04 +0900 (JST)
Received: from localhost.localdomain (191.28.30.125.dy.iij4u.or.jp [125.30.28.191])
	by mbox.po.2iij.net (mbox33) id k77Ll11Y001946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 8 Aug 2006 06:47:02 +0900 (JST)
Date:	Tue, 8 Aug 2006 06:47:01 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	anemo@mba.ocn.ne.jp, ralf@linux-mips.org
Subject: Re: [PATCH] Cleanup bootmem_init()
Message-Id: <20060808064701.592ccaf0.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <cda58cb80608070835o37b83a5bwd4d931c9d2746a15@mail.gmail.com>
References: <44D34C84.9090902@innova-card.com>
	<20060807230346.2a578ba9.yoichi_yuasa@tripeaks.co.jp>
	<cda58cb80608070835o37b83a5bwd4d931c9d2746a15@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Mon, 7 Aug 2006 17:35:25 +0200
"Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:

> 2006/8/7, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>:
> > Hi
> >
> > On Fri, 04 Aug 2006 15:32:52 +0200
> > Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >
> > > This function although doing simple things is hard to follow. It's
> > > mainly due to:
> > >
> > >     - a lot of #ifdef
> > >     - bad local names
> > >     - redundant tests
> > >
> > > So this patch try to address these issues. It also do not use
> > > max_pfn global which is marked as an unused exported symbol.
> > >
> > > As a bonus side, it's now really easy to see what part of the
> > > code is for no-numa system.
> > >
> > > There's also no point to make this function inline.
> >
> > I seem to be able to bring together two #idef CONFIG_BLK_DEV_INITRD/#endif.
> >
> 
> Before doing that can you wait until tomorrow ?

Yes I can.

> I'm going to send a
> patchset that going futher in the cleanup than this single patch but I
> can't send it until tomorrow...

OK

Thanks,

Yoichi
