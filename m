Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jun 2004 17:05:45 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:49911 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225479AbUFVQFk>;
	Tue, 22 Jun 2004 17:05:40 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id BAA21222;
	Wed, 23 Jun 2004 01:05:36 +0900 (JST)
Received: 4UMDO00 id i5MG5ZH24655; Wed, 23 Jun 2004 01:05:36 +0900 (JST)
Received: 4UMRO01 id i5MG5YO05449; Wed, 23 Jun 2004 01:05:34 +0900 (JST)
	from stratos (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 23 Jun 2004 01:05:34 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: remove Eagle support
Message-Id: <20040623010534.23c7ab45.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20040622153252.GA6504@linux-mips.org>
References: <20040622013322.0273fadb.yuasa@hh.iij4u.or.jp>
	<20040622153252.GA6504@linux-mips.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Tue, 22 Jun 2004 17:32:52 +0200
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Tue, Jun 22, 2004 at 01:33:22AM +0900, Yoichi Yuasa wrote:
> 
> > NEC Eagle is obsolete hardware.
> > We have Victor MP-C30x as similar hardware,
> > I'm going to continue support of Victor MP-C30x and I decided to drop NEC Eagle.
> > 
> > Please apply this patch to v2.6 CVS tree.
> 
> Nobody who wants to raise a veto and take over maintenance?

As far as I know, NEC Eagle was sold only in Japan.

Yoichi
