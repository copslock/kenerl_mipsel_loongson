Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 11:21:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19651 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025501AbXEaKUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 11:20:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l4VAJmrm022195;
	Thu, 31 May 2007 11:19:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l4TAZ8Jt024579;
	Tue, 29 May 2007 11:35:08 +0100
Date:	Tue, 29 May 2007 11:35:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix pb1500 reg B access
Message-ID: <20070529103508.GD24410@linux-mips.org>
References: <20070528232656.5f0a568c.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070528232656.5f0a568c.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 28, 2007 at 11:26:56PM +0900, Yoichi Yuasa wrote:

> I think that au_readl() is correct here.

Yes - even though the difference is only cosmetic and au_readl() etc.
operations essentially are equivalent to __raw_readX / __raw_writeX anyway
(or their modern equivalents), so maybe the should simply be replaced.

Anyway, applied.  Thanks,

  Ralf
