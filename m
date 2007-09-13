Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 13:23:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:2515 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021781AbXIMMXS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 13:23:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DCNHM3005363;
	Thu, 13 Sep 2007 13:23:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DCNH63005362;
	Thu, 13 Sep 2007 13:23:17 +0100
Date:	Thu, 13 Sep 2007 13:23:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add GT641xx IRQ routines
Message-ID: <20070913122317.GB4961@linux-mips.org>
References: <20070912232750.645a980f.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070912232750.645a980f.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 11:27:50PM +0900, Yoichi Yuasa wrote:

> +	.ack		= ack_gt641xx_irq,
> +	.mask		= mask_gt641xx_irq,
> +	.mask_ack	= mask_ack_gt641xx_irq,
> +	.unmask		= unmask_gt641xx_irq,

You will need a spinlock to guarantee atomicity these irq_chip methods.
Otherwise okay I think.

  Ralf
