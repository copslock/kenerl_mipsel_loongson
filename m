Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Apr 2008 04:00:57 +0100 (BST)
Received: from mo31.po.2iij.net ([210.128.50.54]:8505 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S29054762AbYDYDAy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Apr 2008 04:00:54 +0100
Received: by mo.po.2iij.net (mo31) id m3P30orX094317; Fri, 25 Apr 2008 12:00:50 +0900 (JST)
Received: from delta (61.25.30.125.dy.iij4u.or.jp [125.30.25.61])
	by mbox.po.2iij.net (po-mbox305) id m3P30khc009977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Apr 2008 12:00:47 +0900
Date:	Fri, 25 Apr 2008 12:00:46 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/2] [MIPS] add DS1287 clockevent
Message-Id: <20080425120046.71911a2a.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20080424.230413.108119529.anemo@mba.ocn.ne.jp>
References: <200804240057.m3O0vPcP017636@po-mbox300.hop.2iij.net>
	<20080424.230413.108119529.anemo@mba.ocn.ne.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 24 Apr 2008 23:04:13 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Thu, 24 Apr 2008 09:56:51 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > --- linux-orig/arch/mips/kernel/cevt-ds1287.c	1970-01-01 09:00:00.000000000 +0900
> > +++ linux/arch/mips/kernel/cevt-ds1287.c	2008-04-24 09:12:31.330105290 +0900
> ...
> > +#include <irq.h>
> 
> Is this needed?

I had forgotten to remove it.
I'll update this patch.

Thanks,

Yoichi
