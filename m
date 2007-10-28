Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 19:23:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6371 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023420AbXJ1TXN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Oct 2007 19:23:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9SJNChu008393;
	Sun, 28 Oct 2007 19:23:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9SJNAqM008392;
	Sun, 28 Oct 2007 19:23:10 GMT
Date:	Sun, 28 Oct 2007 19:23:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add mips_hpt_frequency check to
	mips_clockevent_init()
Message-ID: <20071028192310.GB7661@linux-mips.org>
References: <20071026222705.9ef9c808.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071026222705.9ef9c808.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 26, 2007 at 10:27:05PM +0900, Yoichi Yuasa wrote:

> Add mips_hpt_frequency check to mips_clockevent_init().

Indeed.  I actually meant that check to be there ...

Thanks, applied.

  Ralf
