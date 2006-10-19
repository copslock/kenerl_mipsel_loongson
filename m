Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 18:48:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15302 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038566AbWJSRsX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 18:48:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9JHmhXx005396;
	Thu, 19 Oct 2006 18:48:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9JHmfdk005395;
	Thu, 19 Oct 2006 18:48:41 +0100
Date:	Thu, 19 Oct 2006 18:48:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>, vagabon.xyz@gmail.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
Message-ID: <20061019174840.GA5195@linux-mips.org>
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp> <45364F82.8030308@innova-card.com> <20061018161551.GA15530@linux-mips.org> <20061019170709.54a8b9a6.yoichi_yuasa@tripeaks.co.jp> <Pine.LNX.4.64N.0610191753180.5982@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610191753180.5982@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 19, 2006 at 05:54:19PM +0100, Maciej W. Rozycki wrote:

> 
> > > Or more radical, just getting rid of the printk entirely?  It doesn't
> > > provide very useful information.
> [...]
> > I agree with you.
> > I updated my patch.
> 
>  You might consider removing "Checking for..." in that case as well.

I acutally already have such a patch on the queue tree.

  Ralf
