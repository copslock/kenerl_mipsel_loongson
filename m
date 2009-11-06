Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Nov 2009 13:49:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41671 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492687AbZKFMtA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Nov 2009 13:49:00 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA6CoVot006269;
	Fri, 6 Nov 2009 13:50:31 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA6CoVTw006267;
	Fri, 6 Nov 2009 13:50:31 +0100
Date:	Fri, 6 Nov 2009 13:50:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH -queue 2/2] [loongson] Cleanup the serial port support
Message-ID: <20091106125030.GB31392@linux-mips.org>
References: <cover.1257503696.git.wuzhangjin@gmail.com> <e87bb620cae987f747311920dffd99daf75b1f1f.1257503696.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e87bb620cae987f747311920dffd99daf75b1f1f.1257503696.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 06, 2009 at 06:35:34PM +0800, Wu Zhangjin wrote:

> To share the same kernel image amon different machines, we have added
> the machtype command line support.
> 
> but in the old serial port implementation, we have hardcoded the uart
> base address as a macro in machine.h, which will break the intention of
> machtype. this patch fixes it, and also move the initialization of uart
> base address to uart_base.c to avoid remapping twice for early_printk.c
> and serial.c.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks, queued for 2.6.33.

  Ralf
