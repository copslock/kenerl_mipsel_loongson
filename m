Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 12:54:08 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38884 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026603AbXLNMxn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 12:53:43 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBECrX3o029660;
	Fri, 14 Dec 2007 12:53:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBE17FqI024616;
	Fri, 14 Dec 2007 01:07:15 GMT
Date:	Fri, 14 Dec 2007 01:07:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2/2][MIPS] add cpu_wait() to machine_halt()
Message-ID: <20071214010715.GC20999@linux-mips.org>
References: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp> <20071212222313.92e69c16.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212222313.92e69c16.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 10:23:13PM +0900, Yoichi Yuasa wrote:

> 
> Added cpu_wait() to machine_halt().
> For the power reduction in halt.

Queued for 2.6.25.

Thanks,

  Ralf.
