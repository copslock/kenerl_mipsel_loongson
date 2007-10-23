Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 11:42:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:694 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025962AbXJWKmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 11:42:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9NAgGVr001564;
	Tue, 23 Oct 2007 11:42:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9NAgGHO001563;
	Tue, 23 Oct 2007 11:42:16 +0100
Date:	Tue, 23 Oct 2007 11:42:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][1/2][MIPS] remove irqsave/irqrestore from spinlock for
	GT641xx clockevent
Message-ID: <20071023104216.GA1557@linux-mips.org>
References: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 06:19:13PM +0900, Yoichi Yuasa wrote:

> set_next_event() and set_mode() are always called with interrupt disabled.
> irqsave and irqrestore are not necessary for spinlock.
> Pointed out by Atsushi Nemoto.

Applied, thanks.

  Ralf
