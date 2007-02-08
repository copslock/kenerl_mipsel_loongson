Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 12:53:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5773 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038560AbXBHMxI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 12:53:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l18Cr7E4011046;
	Thu, 8 Feb 2007 12:53:08 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l18Cr6UA011045;
	Thu, 8 Feb 2007 12:53:06 GMT
Date:	Thu, 8 Feb 2007 12:53:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] removed needless #include <asm/i8259.h>  on emma2rh
Message-ID: <20070208125306.GA10739@linux-mips.org>
References: <20070208103029.40481af6.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070208103029.40481af6.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 08, 2007 at 10:30:29AM +0900, Yoichi Yuasa wrote:

> Hi Ralf,
> 
> These irq.c don't need #include <asm/i8259.h>.

Applied. Thanks,

  Ralf
