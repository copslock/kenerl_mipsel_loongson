Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 23:10:54 +0100 (BST)
Received: from mo32.po.2iij.net ([210.128.50.17]:3332 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20038655AbWJSWKx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2006 23:10:53 +0100
Received: by mo.po.2iij.net (mo32) id k9JMAk7g023729; Fri, 20 Oct 2006 07:10:46 +0900 (JST)
Received: from localhost.localdomain (34.26.30.125.dy.iij4u.or.jp [125.30.26.34])
	by mbox.po.2iij.net (mbox30) id k9JMAhbF057091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Oct 2006 07:10:44 +0900 (JST)
Date:	Fri, 20 Oct 2006 07:10:42 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, macro@linux-mips.org,
	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
Message-Id: <20061020071042.75b69eae.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061019174840.GA5195@linux-mips.org>
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
	<45364F82.8030308@innova-card.com>
	<20061018161551.GA15530@linux-mips.org>
	<20061019170709.54a8b9a6.yoichi_yuasa@tripeaks.co.jp>
	<Pine.LNX.4.64N.0610191753180.5982@blysk.ds.pg.gda.pl>
	<20061019174840.GA5195@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 18:48:41 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Thu, Oct 19, 2006 at 05:54:19PM +0100, Maciej W. Rozycki wrote:
> 
> > 
> > > > Or more radical, just getting rid of the printk entirely?  It doesn't
> > > > provide very useful information.
> > [...]
> > > I agree with you.
> > > I updated my patch.
> > 
> >  You might consider removing "Checking for..." in that case as well.

Oops.

> I acutally already have such a patch on the queue tree.

Thanks,

Yoichi
