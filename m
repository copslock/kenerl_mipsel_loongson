Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 16:11:01 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:46312 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022297AbXIMPK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 16:10:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DFAw8p007845;
	Thu, 13 Sep 2007 16:10:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DFAwvj007832;
	Thu, 13 Sep 2007 16:10:58 +0100
Date:	Thu, 13 Sep 2007 16:10:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx IRQ routines
Message-ID: <20070913151058.GA32545@linux-mips.org>
References: <20070912232750.645a980f.yoichi_yuasa@tripeaks.co.jp> <20070913122317.GB4961@linux-mips.org> <20070913235126.65e142fb.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913235126.65e142fb.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 11:51:26PM +0900, Yoichi Yuasa wrote:

> > > +	.ack		= ack_gt641xx_irq,
> > > +	.mask		= mask_gt641xx_irq,
> > > +	.mask_ack	= mask_ack_gt641xx_irq,
> > > +	.unmask		= unmask_gt641xx_irq,
> > 
> > You will need a spinlock to guarantee atomicity these irq_chip methods.
> > Otherwise okay I think.
> 
> Thank you for your comment.
> It was updated.

Okay, applied.

  Ralf
