Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 13:04:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42701 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026785AbXKANEQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 13:04:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lA1D3tFB012467;
	Thu, 1 Nov 2007 13:03:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lA1D3qEo012466;
	Thu, 1 Nov 2007 13:03:52 GMT
Date:	Thu, 1 Nov 2007 13:03:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] bcm47xx: remove unneeded clear_c0_status()
Message-ID: <20071101130352.GA18642@linux-mips.org>
References: <20071101213036.c383957f.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071101213036.c383957f.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 01, 2007 at 09:30:36PM +0900, Yoichi Yuasa wrote:

> Remove unneeded clear_c0_status().
> irq_cpu routines take care of it.

Actually this write is plain nonsense; it has no effect.  The only time
acknowledging an interrupt in c0_cause is needed is for the two software
interrupts but the only user of these is SMTC.

  Ralf
