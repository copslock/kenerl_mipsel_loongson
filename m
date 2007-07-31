Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2007 14:50:03 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:22146 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021682AbXGaNt7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2007 14:49:59 +0100
Received: (qmail 29844 invoked by uid 511); 31 Jul 2007 13:54:47 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 31 Jul 2007 13:54:47 -0000
Message-ID: <46AF3DEE.2080603@lemote.com>
Date:	Tue, 31 Jul 2007 21:49:34 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Dajie Tan <jiankemeng@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] 16K page size in 32 bit kernel
References: <20070731130950.GA5540@sw-linux.com> <20070731100027.GA3983@linux-mips.org>
In-Reply-To: <20070731100027.GA3983@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Jul 31, 2007 at 05:09:51PM +0400, Dajie Tan wrote:
>
>   
>> 32-bit Kernel for loongson2e currently use 16KB page size to avoid
>> cache alias problem.So, the definiton of PGDIR_SHIFT muse be 12+14.
>>
>> Using 22 in 16K page size do not lead to a serious problem but the number
>> of pages allocated for page table is more than previous. (cat
>> /proc/vmstat | grep nr_page_table_pages)
>>
>> It's been tested on FuLong mini PC(loongson2e inside).
>>     
>
> Looking good, applied.  Thanks!
>
> Did by coincidence any of you try 64K pages with a 32-bit kernel?
>
>   Ralf
>
>
>
>   
I think the following is more complete?

 #ifdef CONFIG_64BIT_PHYS_ADDR
-#define PGDIR_SHIFT    21
+#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 3))
 #else
-#define PGDIR_SHIFT    22
+#define PGDIR_SHIFT    (PAGE_SHIFT + (PAGE_SHIFT + PTE_ORDER - 2))
 #endif
