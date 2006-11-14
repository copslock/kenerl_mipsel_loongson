Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 10:56:26 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:17769 "HELO krt.neobee.net")
	by ftp.linux-mips.org with SMTP id S20037749AbWKNK4V (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2006 10:56:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (Postfix) with ESMTP id 129B7282DA;
	Tue, 14 Nov 2006 11:55:58 +0100 (CET)
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28235-04; Tue, 14 Nov 2006 11:55:57 +0100 (CET)
Received: from had (unknown [192.168.0.92])
	by krt.neobee.net (Postfix) with ESMTP id 742CB2828B;
	Tue, 14 Nov 2006 11:55:57 +0100 (CET)
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
Cc:	"'Ralf Baechle'" <ralf@linux-mips.org>
Subject: RE: Uncached mmap
Date:	Tue, 14 Nov 2006 11:58:12 +0100
Message-ID: <013c01c707db$c70cde10$5c00a8c0@niit.micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
thread-index: AccHZ7TR8/4yl5a4Tr+t5fPHfq8UQgAbY4UQ
In-Reply-To: <20061113164054.GA31476@linux-mips.org>
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all again,

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

Ok, physical address for fb mmap is 0x03660000, mmap return 0x2aaa8000 to user
space application and ptr is shifted for 16 bytes (only for test purpose), so
loop will start writing from 0x2aaa8010, with Lauterbach I can check only
0x83660000 or 0xA3660000 address and both are different then expected. Also
small test loop also show that values on 0x2aaa8010 are not ok.
Also if I write/read to this memory as u32 everything work as expected.

I also have here IDT board with 79RC32K438 (4Kc core) and I will same test.

> My linux will be crashed on 13 write. So, this is reason why I thought that
> byte access is not allowed on mmaped uncached memory. 

Let me guess, you filled up some write queue which now is waiting for
an acknowledge which never arrives.

Unfortunately no, linux stopped and ejtag debugger is dead. 


> Is it possible that problem with byte access is related with device mmap
> function?

That is fairly simple code.

  Ralf
