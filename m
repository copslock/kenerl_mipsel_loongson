Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 09:15:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53633 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022587AbXDPIPt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Apr 2007 09:15:49 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3G8FOec026635;
	Mon, 16 Apr 2007 10:15:25 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3G8FLPj026634;
	Mon, 16 Apr 2007 09:15:21 +0100
Date:	Mon, 16 Apr 2007 09:15:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] remove double config entries in drivers/char/Kconfig
Message-ID: <20070416081521.GA26440@linux-mips.org>
References: <20070416140910.47937dcf.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070416140910.47937dcf.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 16, 2007 at 02:09:10PM +0900, Yoichi Yuasa wrote:

> This patch has removed double config entries in drivers/char/Kconfig.
> This problem is only in linux-mips.org tree.

Thanks, applied.

  Ralf
