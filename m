Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 15:35:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:17080 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021759AbXJKOfy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 15:35:54 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9BEZ77X015883;
	Thu, 11 Oct 2007 15:35:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9BEYt4N015874;
	Thu, 11 Oct 2007 15:34:55 +0100
Date:	Thu, 11 Oct 2007 15:34:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix wrong variable in rtc_mips_set_time() for
	yosemite
Message-ID: <20071011143455.GA15861@linux-mips.org>
References: <20071011230115.2e2b86df.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071011230115.2e2b86df.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 11, 2007 at 11:01:15PM +0900, Yoichi Yuasa wrote:

> Fix wrong variable in rtc_mips_set_time() for yosemite.

Thanks, applied.

  Ralf
