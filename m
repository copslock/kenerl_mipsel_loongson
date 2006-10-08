Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 02:17:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18631 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038822AbWJHBRo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 02:17:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k981Hn1w024503;
	Sun, 8 Oct 2006 02:17:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k981HmSv024502;
	Sun, 8 Oct 2006 02:17:48 +0100
Date:	Sun, 8 Oct 2006 02:17:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] fix build errors by IRQ hander change
Message-ID: <20061008011747.GA20330@linux-mips.org>
References: <20061007003516.5eec677e.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007003516.5eec677e.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 07, 2006 at 12:35:16AM +0900, Yoichi Yuasa wrote:

> Hi Ralf,
> 
> This patch has fixed build errors by the IRQ handler change.

I didn't like David Howell's MIPS patch which left alot of the pt_regs
passing in the MIPS code still alive.  So I went for a much larger and
intrusive solution which I've pushed just so at least some configurations
are usable again.  I've tested Malta without multithreading (OK), Malta
VSMP (hangs), Malta SMTC (hangs), Qemu (OK) so it seems there is
something still broken with SMP, I guess IPIs.

  Ralf
