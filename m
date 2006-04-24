Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 08:12:03 +0100 (BST)
Received: from mail1.lge.co.kr ([156.147.1.151]:62973 "EHLO mail1.lge.co.kr")
	by ftp.linux-mips.org with ESMTP id S8133490AbWDXHLs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2006 08:11:48 +0100
Received: from [150.150.71.243] (jsungkim@lge.com) by 
          mail1.lge.co.kr (Terrace MailWatcher) 
          with ESMTP id 2006042416:24:39:650536.280.168
          for <linux-mips@linux-mips.org>; 
          Mon, 24 Apr 2006 16:24:39 +0900 (KST) 
From:	"Kim, Jong-Sung" <jsungkim@lge.com>
To:	<linux-mips@linux-mips.org>
Subject: RE: Reading an entire cacheline
Date:	Mon, 24 Apr 2006 16:23:58 +0900
Message-ID: <07fb01c66770$0d61a920$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
thread-index: AcZigD+A+CMHDL7jSviP63YyQN7LKwE4sZxQ
In-Reply-To: <058801c66280$3fa1ebb0$f3479696@LGE.NET>
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Return-Path: <jsungkim@lge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsungkim@lge.com
Precedence: bulk
X-list: linux-mips

Hi all,

Was my question too brief? I'm using MIPS5Kf core included in a Broadcom
implemented processor and it has a 32kB d-cache and a same sized i-cache.
Cache configuration is 2-way, 32-byte cacheline for both d- and i-cache
without L2 cache. Of course, MIPS-port Linux as the kernel for it. And, a
onboard block device has problem in its operation. I don't think it's a
kernel problem. So I wanna inspect the contents of cache RAMs at the device
driver's context. I've added some lines of codes look like follow:

	__asm__ __volatile__(
		".set	noreorder\n\t"
		".set	mips3\n\t"
		"cache	5, 0x00(%3)\n\t"	// load d-cache tag
		".set	mips0\n\t"		// by index
		".set	mips32\n\t"
		"mfc0	%0, $28, 0\n\t"
		"mfc0	%1, $28, 1\n\t"
		"mfc0	%2, $29, 1\n\t"
		.set	mips0\n\t"
		.set	reorder"
		: "=r" (tag), "=r" (data_lo), "=r" (data_hi)
		: "r" (0x80000000 | (way << 14) | (index << 5) | (word <<
3))
	);

This is executed for every index, every way, and every word. The thing aches
my head is the tags from a single cacheline differs. (very often for
d-cache) So I modified the code to reread the cacheline from the first word
when the tag was modified before reading all four words. Then the code never
return. I couldn't find any related information from manual.

Please give me a hint for reading whole cacheline safely.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kim, Jong-Sung
Sent: Tuesday, April 18, 2006 9:37 AM
To: linux-mips@linux-mips.org
Subject: Reading an entire cacheline

Hi,

Is there any way to read an entire cacheline from the MIPS5Kf? Four
sequential cache instructions do similarly, but sometimes the tags from a
same cacheline differ. How can I read a consistent cacheline safely?

Thanks.
