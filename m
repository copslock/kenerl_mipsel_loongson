Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Aug 2006 04:48:19 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:29188 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20037645AbWHaDsR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 31 Aug 2006 04:48:17 +0100
Received: by mo.po.2iij.net (mo30) id k7V3mBAX052653; Thu, 31 Aug 2006 12:48:11 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k7V3m9KU097405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 31 Aug 2006 12:48:09 +0900 (JST)
Date:	Thu, 31 Aug 2006 12:48:09 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, imipak@yahoo.com, ths@networkno.de,
	treestem@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] 64K page size
Message-Id: <20060831124809.7118ab45.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20060829140700.GD29289@linux-mips.org>
References: <20060823160011.GE20395@networkno.de>
	<20060823162324.43027.qmail@web31507.mail.mud.yahoo.com>
	<20060829140700.GD29289@linux-mips.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Tue, 29 Aug 2006 15:07:00 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Aug 23, 2006 at 09:23:24AM -0700, Jonathan Day wrote:
> 
> > I am extremely interested in big pages (64K, etc), and
> > the sooner the better. If there is anything not
> > considered OK for immediate inclusion in the Linux
> > MIPS git tree, I would love to have a copy anyway.
> > Large pages will be necessary for some high-priority
> > work I'm doing, although stability at this point seems
> > to be an optional extra. (Hence why the patches are
> > much more important than whether they're actually
> > finished yet.)
> 
> We're getting very close to a 2.6.18 release and 64kB pages are still
> quite experimental, so I'm putting all the 64kB pagesize related fixes
> into the queue branch.  16kB by now has a few users, so I give it
> higher priority.

Which is your queue branch?
I want to test 64k page size on vr41xx.

Yoichi
