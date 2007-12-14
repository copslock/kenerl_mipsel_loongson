Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 12:55:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:39908 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026633AbXLNMxo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 12:53:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBECrX3u029660;
	Fri, 14 Dec 2007 12:53:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBE162pm024580;
	Fri, 14 Dec 2007 01:06:02 GMT
Date:	Fri, 14 Dec 2007 01:06:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] move vr41xx_calculate_clock_frequency() to
	plat_time_init()
Message-ID: <20071214010602.GA20999@linux-mips.org>
References: <20071212221109.e0448c18.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212221109.e0448c18.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 10:11:09PM +0900, Yoichi Yuasa wrote:

> Moved vr41xx_calculate_clock_frequency() to plat_time_init().
> This function relates to the timer function.
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

Queued for 2.6.25.

Thanks,

  Ralf.
