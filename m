Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 13:13:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:42410 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037484AbXCENNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 13:13:54 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l25DC5Nd029224;
	Mon, 5 Mar 2007 13:12:05 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l25DC3HJ029223;
	Mon, 5 Mar 2007 13:12:03 GMT
Date:	Mon, 5 Mar 2007 13:12:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] separate Cobalt PCI codes from setup.c
Message-ID: <20070305131203.GA29204@linux-mips.org>
References: <20070305191003.5357b4bf.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070305191003.5357b4bf.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 07:10:03PM +0900, Yoichi Yuasa wrote:

> This patch has separated cobalt PCI codes from setup.c .
> It's removed #ifdef CONFIG_PCI/#endif from cobalt setup.c .

Thanks, queued.

2.6.21 ante portas ;-)

  Ralf
