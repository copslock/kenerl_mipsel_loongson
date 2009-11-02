Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 14:17:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44297 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493888AbZKBNRN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 14:17:13 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2DIblm022356;
	Mon, 2 Nov 2009 14:18:37 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2DIbTg022354;
	Mon, 2 Nov 2009 14:18:37 +0100
Date:	Mon, 2 Nov 2009 14:18:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 3/7] [loongson] early_printk: fix the variable
	type of uart_base
Message-ID: <20091102131837.GB21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d771bbf1f97c456c8e845adfe2c0c05065f68d39.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:16PM +0800, Wu Zhangjin wrote:

> The uart_base variable here is not a physical address, so, we replace it
> by unsigned char *.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, queued for 2.6.33.

  Ralf
