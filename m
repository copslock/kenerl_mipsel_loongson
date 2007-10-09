Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 10:58:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42465 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20029986AbXJIJ6s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 10:58:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l999wmCL029254;
	Tue, 9 Oct 2007 10:58:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l999wibe029253;
	Tue, 9 Oct 2007 10:58:44 +0100
Date:	Tue, 9 Oct 2007 10:58:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: a garbage character in syscall.c
Message-ID: <20071009095844.GA20698@linux-mips.org>
References: <20071009160743.5cba9b34.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071009160743.5cba9b34.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 09, 2007 at 04:07:43PM +0900, Yoichi Yuasa wrote:

> linux-queue.git:
> http://www.linux-mips.org/git?p=linux-queue.git;a=commit;h=81c6bb39250146e5db5365f843ed9c4b7604f3bd
> 
> Please remove it from your patch, or apply this patch.

Thanks, fixed.

For the -queue branch I usually prefer to fold fixes into the patches that
did introduce them.

  Ralf
