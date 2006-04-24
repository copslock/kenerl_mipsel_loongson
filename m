Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 10:40:19 +0100 (BST)
Received: from mail1.lge.co.kr ([156.147.1.151]:54766 "EHLO mail1.lge.co.kr")
	by ftp.linux-mips.org with ESMTP id S8133654AbWDXJkJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 10:40:09 +0100
Received: from [150.150.71.243] (jsungkim@lge.com) by 
          mail1.lge.co.kr (Terrace MailWatcher) 
          with ESMTP id 2006042418:53:00:828273.280.53
          for <linux-mips@linux-mips.org>; 
          Mon, 24 Apr 2006 18:53:00 +0900 (KST) 
From:	"Kim, Jong-Sung" <jsungkim@lge.com>
To:	<linux-mips@linux-mips.org>
Subject: RE: Reading an entire cacheline
Date:	Mon, 24 Apr 2006 18:52:19 +0900
Message-ID: <081a01c66784$c6f7cb30$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZnc7CyPdJwbX50SoibeeLGSRB4FwABg8kAAAK736A=
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Return-Path: <jsungkim@lge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsungkim@lge.com
Precedence: bulk
X-list: linux-mips

Dear Mr. Kissell and the others,

I apologize for my rude question if you felt like. I was first in this
mailing list and I didn't think I had to describe the background of my
problem such in depth. I have an application stored in an onboard block
device and it sometimes makes bus error or segmentation fault during
do_page_fault().
When the application is stored in and executed from an nfs device or an
ramfs or any other device, it works without any problem. So I think the
problem comes from the device driver or something below.
In some experiments, the cache invalidation in a point reduces the frequency
of abnormal terminations. (I don't know it's a walk-around or just reduction
yet) When the application was copied from the device onto the other (ram or
network) device, it works well. So I guess the problem is related to the
cache and not from just d-cache incoherency. I targeted the consistency
between d- and i-cache as first. If you have any idea, please let me know.
For the device driver for the block device is very large and not my work,
I'm still in the dark. ^^;

Thank you for your hints about the interrupt disabling and the variable
cachability. They could be very helpful for me. For the tag, I meant the
physical address field of the valid tag. Thank you again.


Regards,
JS.


-----Original Message-----
From: Kevin D. Kissell [mailto:kevink@mips.com] 
Sent: Monday, April 24, 2006 4:41 PM
To: Kim, Jong-Sung; linux-mips@linux-mips.org
Subject: Re: Reading an entire cacheline

Yes, your question was too brief the first time around - I couldn't
tell what you were really asking.  I'm still not 100% sure of what
you're doing, though.   I don't want to sound insulting, but you're
disabling interrupts during this operation, right?  And if you're
copying the values into variables in memory, you're doing nothing
but non-cached references, right?  When you see the tags changing
on you, which bits are changing, and what are they defined to mean?

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Kim, Jong-Sung" <jsungkim@lge.com>
To: <linux-mips@linux-mips.org>
Sent: Monday, April 24, 2006 9:23 AM
Subject: RE: Reading an entire cacheline


> Hi all,
> 
> Was my question too brief? I'm using MIPS5Kf core included in a Broadcom
> implemented processor and it has a 32kB d-cache and a same sized i-cache.
> Cache configuration is 2-way, 32-byte cacheline for both d- and i-cache
> without L2 cache. Of course, MIPS-port Linux as the kernel for it. And, a
> onboard block device has problem in its operation. I don't think it's a
> kernel problem. So I wanna inspect the contents of cache RAMs at the
device
> driver's context. I've added some lines of codes look like follow:
> 
> __asm__ __volatile__(
> ".set noreorder\n\t"
> ".set mips3\n\t"
> "cache 5, 0x00(%3)\n\t" // load d-cache tag
> ".set mips0\n\t" // by index
> ".set mips32\n\t"
> "mfc0 %0, $28, 0\n\t"
> "mfc0 %1, $28, 1\n\t"
> "mfc0 %2, $29, 1\n\t"
> .set mips0\n\t"
> .set reorder"
> : "=r" (tag), "=r" (data_lo), "=r" (data_hi)
> : "r" (0x80000000 | (way << 14) | (index << 5) | (word <<
> 3))
> );
> 
> This is executed for every index, every way, and every word. The thing
aches
> my head is the tags from a single cacheline differs. (very often for
> d-cache) So I modified the code to reread the cacheline from the first
word
> when the tag was modified before reading all four words. Then the code
never
> return. I couldn't find any related information from manual.
> 
> Please give me a hint for reading whole cacheline safely.
> 
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kim, Jong-Sung
> Sent: Tuesday, April 18, 2006 9:37 AM
> To: linux-mips@linux-mips.org
> Subject: Reading an entire cacheline
> 
> Hi,
> 
> Is there any way to read an entire cacheline from the MIPS5Kf? Four
> sequential cache instructions do similarly, but sometimes the tags from a
> same cacheline differ. How can I read a consistent cacheline safely?
> 
> Thanks.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
