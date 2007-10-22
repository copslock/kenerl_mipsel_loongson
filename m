Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 13:16:15 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42710 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022895AbXJVMQN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 13:16:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9MCEqUl031049;
	Mon, 22 Oct 2007 13:14:52 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9MCEpdv031048;
	Mon, 22 Oct 2007 13:14:51 +0100
Date:	Mon, 22 Oct 2007 13:14:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
Message-ID: <20071022121451.GA31041@linux-mips.org>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 22, 2007 at 07:43:15PM +0900, Yoichi Yuasa wrote:

> Add GT641xx timer0 clockevent.

Thanks, applied.

Btw, I like that you put cevt-gt641xx.c into arch/mips/kernel.  Unlike the
per-vendor subdirectories under arch/mips which have a tradition of
promoting messy code and endorsing code duplication that rather is the
way to go.  Similar for clocksources.

  Ralf
