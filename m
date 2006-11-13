Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 12:32:11 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52948 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038324AbWKMMcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Nov 2006 12:32:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kADCWYTB020584;
	Mon, 13 Nov 2006 12:32:34 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kADCWX5k020583;
	Mon, 13 Nov 2006 12:32:33 GMT
Date:	Mon, 13 Nov 2006 12:32:33 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <Mile.Davidovic@micronasnit.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Uncached mmap
Message-ID: <20061113123233.GA20337@linux-mips.org>
References: <001201c70704$bc731230$5c00a8c0@niit.micronasnit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201c70704$bc731230$5c00a8c0@niit.micronasnit.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 13, 2006 at 10:18:52AM +0100, Mile Davidovic wrote:

> Hello to all,
> I am working on fb device and I have general questions regarding cache/uncache
> access to MIPS memory. 
> 
> User space application use mmap access for r/w access to fb device. If fb use
> cached memory, user space application has to call cacheflush to flush contents
> instruction and/or data cache. In this case there are no limitations regarding
> byte access to this memory. Is this correct statement?

Yes.

With caching bus transfers from and to the device happen at the full width
of the bus, so a device won't see byte accesses ever.

> If fb use uncached memory, there is no need for cacheflush call in user space
> application but limitation is access to mmap uncached memory.

Correct.

> There is no byte access to uncached mmaped memory. Is this correct statement?

Definately wrong.  For example alot of mmapped I/O devices use uncached
byte accesses.

This stament if of course limited to the CPU's part of the system.  Devices
may have their specific restrictions on access size and its not uncommon to
have such restrictions though that would seem unlikely for framebuffer
memory.

If your particular CPU support it you may want to use cache mode "uncached
accellerated" for a framebuffer.  It should deliver significtn performance
gains yet avoid the need for cache flushes.

  Ralf
