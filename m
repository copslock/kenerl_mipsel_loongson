Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Dec 2007 19:10:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25258 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573796AbXLITKn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Dec 2007 19:10:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB9JAIA9032743;
	Sun, 9 Dec 2007 19:10:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB9JAF5O032742;
	Sun, 9 Dec 2007 19:10:15 GMT
Date:	Sun, 9 Dec 2007 19:10:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] remove mips_timer_state()
Message-ID: <20071209191015.GA32724@linux-mips.org>
References: <20071209211936.05b97163.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071209211936.05b97163.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 09, 2007 at 09:19:36PM +0900, Yoichi Yuasa wrote:

> Remove mips_timer_state().
> It is not used at all.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Queued for 2.6.25.

Thanks,

  Ralf
