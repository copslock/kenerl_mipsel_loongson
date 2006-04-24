Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 08:24:36 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:31134 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133490AbWDXHY1
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Apr 2006 08:24:27 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k3O7bLlR002628;
	Mon, 24 Apr 2006 00:37:22 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k3O7bKwe008070;
	Mon, 24 Apr 2006 00:37:21 -0700 (PDT)
Message-ID: <004801c66772$6cc350b0$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Kim, Jong-Sung" <jsungkim@lge.com>, <linux-mips@linux-mips.org>
References: <07fb01c66770$0d61a920$f3479696@LGE.NET>
Subject: Re: Reading an entire cacheline
Date:	Mon, 24 Apr 2006 09:40:55 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

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
> kernel problem. So I wanna inspect the contents of cache RAMs at the device
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
> This is executed for every index, every way, and every word. The thing aches
> my head is the tags from a single cacheline differs. (very often for
> d-cache) So I modified the code to reread the cacheline from the first word
> when the tag was modified before reading all four words. Then the code never
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
