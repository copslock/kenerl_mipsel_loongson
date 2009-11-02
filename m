Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 14:28:22 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41002 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493892AbZKBN2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 14:28:19 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2DTgSE022669;
	Mon, 2 Nov 2009 14:29:42 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2DTehS022667;
	Mon, 2 Nov 2009 14:29:40 +0100
Date:	Mon, 2 Nov 2009 14:29:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 4/7] [loongosn] add a new serial port debug
	function
Message-ID: <20091102132940.GC21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa536e7b25f41bf1ed1a1e203de389bb970e8174.1255673756.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 02:17:17PM +0800, Wu Zhangjin wrote:

> There is an existing serial port debug function: prom_putchar(), but it
> can only print one char, herein add a new prom_printf(), which works
> like printk, but print to serial port, which is very important to kernel
> debugging.

Does this mean early_printk doesn't work for you?  We rather get that to
work for you than introducing something equivalent.

  Ralf
