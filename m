Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2006 14:56:13 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:26437 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133732AbWFTN4E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2006 14:56:04 +0100
Received: by mo.po.2iij.net (mo32) id k5KDu1qD097602; Tue, 20 Jun 2006 22:56:01 +0900 (JST)
Received: from localhost.localdomain (225.29.30.125.dy.iij4u.or.jp [125.30.29.225])
	by mbox.po.2iij.net (mbox33) id k5KDtvw0000417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 20 Jun 2006 22:55:57 +0900 (JST)
Date:	Tue, 20 Jun 2006 22:55:55 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: Merge window ...
Message-Id: <20060620225555.42f0246f.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060619155001.GA12123@linux-mips.org>
References: <20060619103653.GA4257@linux-mips.org>
	<20060620000346.2b704b9b.yoichi_yuasa@tripeaks.co.jp>
	<20060619155001.GA12123@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hello Ralf,

On Mon, 19 Jun 2006 16:50:01 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Jun 20, 2006 at 12:03:46AM +0900, Yoichi Yuasa wrote:
> 
> > 
> > 4G Systems MTX-1
> > AMD Alchemy Bosporus
> > AMD Alchemy Mirage
> > Jazz family
> > Toshiba TBTX49[23]7
> > 
> > These boards are candidate for removal.
> > If there are none objection, we can add to feature-removal-schedule.txt.
> 
> A little too much.  Malta for example works and I'm running top of tree.
> Jazz is happy, SNI was doing ok and received a major upgrade just on
> the weekend  and the Broadcom stuff - aside of slight bitrot is crucially
> important for many projects as the provider of horsepower for native
> builds.

Thank you for your comment.

> My candidates for nuking are marked with a big red box in the wiki in
> the hope somebody will fix the code:
> 
>   http://www.linux-mips.org/wiki/Category:Deprecated
>
> Many eval boards tend to have a short livespan unlike vintage workstation
> and server hardware, so I tend to be trigger happier for eval board
> type of stuff.

How about EV64120 and Momentum Ocelot-G ?

Yoichi
