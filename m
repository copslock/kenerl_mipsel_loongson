Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 11:42:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43705 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029966AbXJWKma (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 11:42:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9NAgUQ7001604;
	Tue, 23 Oct 2007 11:42:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9NAgUBF001603;
	Tue, 23 Oct 2007 11:42:30 +0100
Date:	Tue, 23 Oct 2007 11:42:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2/2][MIPS] move clockevent_set_clock() before
	clockevent_delta2ns()
Message-ID: <20071023104230.GB1557@linux-mips.org>
References: <20071023181913.252daa3e.yoichi_yuasa@tripeaks.co.jp> <200710230922.l9N9M6qs011258@po-mbox302.po.2iij.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710230922.l9N9M6qs011258@po-mbox302.po.2iij.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 23, 2007 at 06:22:50PM +0900, Yoichi Yuasa wrote:

Applied, thanks.

  Ralf
