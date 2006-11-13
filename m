Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 15:27:58 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:10595 "HELO krt.neobee.net")
	by ftp.linux-mips.org with SMTP id S20037875AbWKMP1y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 15:27:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (Postfix) with ESMTP id BBCD5A5F7B;
	Mon, 13 Nov 2006 16:27:50 +0100 (CET)
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14023-06; Mon, 13 Nov 2006 16:27:47 +0100 (CET)
Received: from had (unknown [192.168.0.92])
	by krt.neobee.net (Postfix) with ESMTP id 87C388F3D8;
	Mon, 13 Nov 2006 16:27:47 +0100 (CET)
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
Cc:	"'Ralf Baechle'" <ralf@linux-mips.org>
Subject: RE: Uncached mmap
Date:	Mon, 13 Nov 2006 16:30:26 +0100
Message-ID: <002101c70738$a4974ad0$5c00a8c0@niit.micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccHH9YOr1x418tdT9Clo10n00/ztgAA+0+Q
In-Reply-To: <20061113123233.GA20337@linux-mips.org>
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips


Hello again,
first I want to thank You for Your fast answer. I work on MIPS 4Kec with linux
kernel in version 2.6.15 from linux-mips (gcc 4.0.3 and gcc 3.4.3).

>> There is no byte access to uncached mmaped memory. Is this correct statement?
>Definately wrong.  For example alot of mmapped I/O devices use uncached
>byte accesses.

Ok, in that case I have problem with byte access on mmaped uncached memory. 
Reason for previous post is next:
If I write bytes to mmaped uncached memory like:
...
ptr = (unsigned char*)mmap(0,lineSize,PROT_READ|PROT_WRITE,MAP_SHARED,fd0,0);
...
for (i = 0; i < 12; i++) 
   *ptr++ = 0xaa;

this loop will not write all bytes correctly (every 4 bytes will have 0xaa as
value), here is dump from Lauterbach debugger:
___address__|_0________4________8________C________0123456789ABCDEF
  D:83660000|>FFFFFFFF FFFFFFFF FFFFFFFF FFFFFFFF ................
  D:83660010| 000000AA 000000AA 000000AA 0000AA02 ................

and if I use bigger loop
for (i = 0; i < 20; i++) 
   *ptr++ = 0xaa;
My linux will be crashed on 13 write. So, this is reason why I thought that
byte access is not allowed on mmaped uncached memory. 

Is it possible that problem with byte access is related with device mmap
function?

>This stament if of course limited to the CPU's part of the system.  Devices
>may have their specific restrictions on access size and its not uncommon to
>have such restrictions though that would seem unlikely for framebuffer
>memory.

Ok, I understood this.

>If your particular CPU support it you may want to use cache mode "uncached
>accellerated" for a framebuffer.  It should deliver significtn performance
>gains yet avoid the need for cache flushes.



Thanks in advance
Mile
