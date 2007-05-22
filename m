Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2007 15:39:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:51171 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022852AbXEVOjp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 May 2007 15:39:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4MEdVdV027830;
	Tue, 22 May 2007 15:39:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4MEdTmo027829;
	Tue, 22 May 2007 15:39:29 +0100
Date:	Tue, 22 May 2007 15:39:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	florian.fainelli@telecomint.eu, linux-mips@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH UPDATE] Add MIPS generic GPIO support
Message-ID: <20070522143929.GA26154@linux-mips.org>
References: <20070521.001238.41198930.anemo@mba.ocn.ne.jp> <20070521161303.0d9db8e4.yoichi_yuasa@tripeaks.co.jp> <200705210729.l4L7TZB3079730@mbox31.po.2iij.net> <20070521.231200.74752428.anemo@mba.ocn.ne.jp> <20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070522000558.7dc5b747.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 22, 2007 at 12:05:58AM +0900, Yoichi Yuasa wrote:

> On Mon, 21 May 2007 23:12:00 +0900 (JST)
> Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> 
> > On Mon, 21 May 2007 16:29:35 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > > This patch has added support for the generic GPIO API header file to MIPS.
> > 
> > With the change, adding these lines to Kconfig would be better.
> > 
> > config GENERIC_GPIO
> >         bool
> 
> Atsushi, thank you for your comment.
> 
> This patch has added support for the generic GPIO API to MIPS.

Okay.  Since no platform is currently setting I've dropped this into the
2.6.23 patch queue.

Thanks,

  Ralf
