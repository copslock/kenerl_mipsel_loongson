Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 13:10:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:741 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021637AbXIMMKF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Sep 2007 13:10:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8DCA4EB004871;
	Thu, 13 Sep 2007 13:10:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8DCA3VK004870;
	Thu, 13 Sep 2007 13:10:03 +0100
Date:	Thu, 13 Sep 2007 13:10:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] move i8259 functions to include/asm-mips/i8259.h
Message-ID: <20070913121003.GE31940@linux-mips.org>
References: <20070912232333.22c4f7bb.yoichi_yuasa@tripeaks.co.jp> <20070913.003319.41011558.anemo@mba.ocn.ne.jp> <200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709130204.l8D244XV029841@po-mbox300.hop.2iij.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 13, 2007 at 11:04:04AM +0900, Yoichi Yuasa wrote:

> On Thu, 13 Sep 2007 00:33:19 +0900 (JST)
> Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> 
> > 
> > Please drop a comment in this part too.  The comment was there just
> > because we had to drop "static" from mask_and_ack_8259A() at that
> > time.
> 
> Thank you for your comment.
> The patch was updated.

Okay, queued for 2.6.24.  Thanks,

  Ralf
