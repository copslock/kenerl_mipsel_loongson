Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 03:47:38 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:7460 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038923AbWIYCrf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 25 Sep 2006 03:47:35 +0100
Received: by mo.po.2iij.net (mo30) id k8P2lUmS012642; Mon, 25 Sep 2006 11:47:30 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k8P2lSR9020289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Sep 2006 11:47:28 +0900 (JST)
Date:	Mon, 25 Sep 2006 11:47:28 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	linux-fbdev-devel@lists.sourceforge.net
Cc:	linux-mips@linux-mips.org,
	"Ricardo Mendoza" <mendoza.ricardo@gmail.com>
Subject: Re: [PATCH] remove tx3912fb
Message-Id: <20060925114728.3c82b654.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <816d36d30609240821x31035d3cw8170ace7de43abe5@mail.gmail.com>
References: <20060922020202.31b2b537.yoichi_yuasa@tripeaks.co.jp>
	<816d36d30609221012j452e6b03raa1ef1c72bb494d@mail.gmail.com>
	<20060924214306.40133dee.yoichi_yuasa@tripeaks.co.jp>
	<816d36d30609240819q59edce51p91a7aa66dbc8dc43@mail.gmail.com>
	<816d36d30609240821x31035d3cw8170ace7de43abe5@mail.gmail.com>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

Ricardo will add support of Nino and others again.
Please ignore this patch.

Yoichi

On Sun, 24 Sep 2006 11:21:37 -0400
"Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:

> On 9/24/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > Hello,
> >
> > On Fri, 22 Sep 2006 13:12:44 -0400
> > "Ricardo Mendoza" <mendoza.ricardo@gmail.com> wrote:
> >
> > > On 9/21/06, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > > Hi,
> > > >
> > > > NINO support has already dropped.
> > > > Nothing is using tx3912fb.
> > > >
> > > > Yoichi
> > > >
> > > > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> > > >
> > > > ...
> > >
> > > Hello Yoichi!
> > >
> > > If you don't mind I would ask to keep this driver up, I will soon add
> > > tx3912 support back up because I have a couple PDAs that use it, and
> > > there are still a few boards that run on it.
> >
> > Do you add the support of which PDA?
> 
> Philips Nino and Velo series and the old Sharp Mobilon series; both
> run on PR31700/TX3912 SoCs. Steven Hill had a port for the Nino board
> on early 2.4, but it was dropped as of 2.4.17 if I recall correctly,
> it never made it to 2.6.
> 
>      Ricardo
> 
