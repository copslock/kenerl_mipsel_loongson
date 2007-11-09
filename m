Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Nov 2007 11:06:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52182 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021617AbXKILGd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Nov 2007 11:06:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA9B6Xkl015126;
	Fri, 9 Nov 2007 11:06:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA9B6KIb015125;
	Fri, 9 Nov 2007 11:06:20 GMT
Date:	Fri, 9 Nov 2007 11:06:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix LASAT IRQ overlap
Message-ID: <20071109110619.GB12469@linux-mips.org>
References: <20071109184235.d87433e6.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071109184235.d87433e6.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 09, 2007 at 06:42:35PM +0900, Yoichi Yuasa wrote:

> The range of MIPS_CPU IRQ and the range of LASAT IRQ overlap.
> This patch has fixed it.

You forgot to mention the tidying up part which really is the majority
of the patch ;-)

Anyway, thanks & applied.

  Ralf
