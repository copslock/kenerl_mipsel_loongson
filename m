Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 13:27:25 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34966 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133592AbWFGM1S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 13:27:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k57CRI3Y008613;
	Wed, 7 Jun 2006 13:27:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k57CRGlu008612;
	Wed, 7 Jun 2006 13:27:16 +0100
Date:	Wed, 7 Jun 2006 13:27:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] cobalt: fixed undefined reference to `disable_early_printk'
Message-ID: <20060607122716.GA8606@linux-mips.org>
References: <20060607095334.156f19a0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607095334.156f19a0.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 07, 2006 at 09:53:34AM +0900, Yoichi Yuasa wrote:

> This patch has fixed build error about cobalt.
> 
> drivers/built-in.o: In function `console_init':
> : undefined reference to `disable_early_printk'
> make: *** [.tmp_vmlinux1] Error 1

Thanks, applied.

  Ralf
