Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 21:02:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22169 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039435AbWKMQke (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Nov 2006 16:40:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kADGet5H006551;
	Mon, 13 Nov 2006 16:40:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kADGes1c006550;
	Mon, 13 Nov 2006 16:40:54 GMT
Date:	Mon, 13 Nov 2006 16:40:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mile Davidovic <Mile.Davidovic@micronasnit.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Uncached mmap
Message-ID: <20061113164054.GA31476@linux-mips.org>
References: <20061113123233.GA20337@linux-mips.org> <002101c70738$a4974ad0$5c00a8c0@niit.micronasnit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002101c70738$a4974ad0$5c00a8c0@niit.micronasnit.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 13, 2006 at 04:30:26PM +0100, Mile Davidovic wrote:

> ptr = (unsigned char*)mmap(0,lineSize,PROT_READ|PROT_WRITE,MAP_SHARED,fd0,0);
> ...
> for (i = 0; i < 12; i++) 
>    *ptr++ = 0xaa;
> 
> this loop will not write all bytes correctly (every 4 bytes will have 0xaa as
> value), here is dump from Lauterbach debugger:
> ___address__|_0________4________8________C________0123456789ABCDEF
>   D:83660000|>FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF ................
>   D:83660010| 000000AA 000000AA 000000AA 0000AA02 ................

Is 83660000 a proper physical address or a virtual address?  A common
mistake is mapping a KSEG _virtual_ address to a userspace _virtual_
address.  Obviously mapping anything virtual to something else virtual
doesn't work ...

> and if I use bigger loop
> for (i = 0; i < 20; i++) 
>    *ptr++ = 0xaa;
> My linux will be crashed on 13 write. So, this is reason why I thought that
> byte access is not allowed on mmaped uncached memory. 

Let me guess, you filled up some write queue which now is waiting for
an acknowledge which never arrives.

> Is it possible that problem with byte access is related with device mmap
> function?

That is fairly simple code.

  Ralf
