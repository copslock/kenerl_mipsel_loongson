Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 16:16:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:64656 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28600819AbYCQQQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 16:16:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2HGGgre028837;
	Mon, 17 Mar 2008 16:16:52 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2HGGZkt028836;
	Mon, 17 Mar 2008 16:16:35 GMT
Date:	Mon, 17 Mar 2008 16:16:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2][MIPS] replace c0_compare acknowledge by
	c0_timer_ack()
Message-ID: <20080317161635.GA25549@linux-mips.org>
References: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080317234740.705a8a34.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 11:47:40PM +0900, Yoichi Yuasa wrote:

> VR41xx, CP0 hazard is necessary between read_c0_count() and write_c0_compare().

Interesting.  I wonder why you need this patch but nobody else?

  Ralf
