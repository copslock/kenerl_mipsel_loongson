Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 17:15:37 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52461 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038553AbWJRQPf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 17:15:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9IGFrUc015707;
	Wed, 18 Oct 2006 17:15:53 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9IGFqLv015706;
	Wed, 18 Oct 2006 17:15:52 +0100
Date:	Wed, 18 Oct 2006 17:15:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
Message-ID: <20061018161551.GA15530@linux-mips.org>
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp> <45364F82.8030308@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45364F82.8030308@innova-card.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 18, 2006 at 06:00:02PM +0200, Franck Bui-Huu wrote:

> 
> 	printk(" %savailable.\n", cpu_wait ? "" : "un");

Or more radical, just getting rid of the printk entirely?  It doesn't
provide very useful information.

  Ralf
