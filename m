Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 14:50:23 +0000 (GMT)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:80.176.203.50]:40147 "EHLO
	pangolin.localnet") by linux-mips.org with ESMTP
	id <S8225618AbUCYOuW>; Thu, 25 Mar 2004 14:50:22 +0000
Received: from sprocket.localnet ([192.168.1.27] helo=bitbox.co.uk)
	by pangolin.localnet with esmtp (Exim 3.35 #1 (Debian))
	id 1B6WBP-0007i9-00; Thu, 25 Mar 2004 14:50:11 +0000
Message-ID: <4062F1A1.9070005@bitbox.co.uk>
Date: Thu, 25 Mar 2004 14:50:09 +0000
From: Peter Horton <phorton@bitbox.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: anemo@mba.ocn.ne.jp
CC: linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
References: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp> <20040325143319.GA873@linux-mips.org>
In-Reply-To: <20040325143319.GA873@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Thu, Mar 25, 2004 at 10:42:29PM +0900, Atsushi Nemoto wrote:
>
>  
>
>>I noticed that reading from file with mmap sometimes return wrong data
>>on 2.4 kernel.
>>
>>This is a test program to reproduce the problem.
>>    
>>
>
>This seems to be the same problem as reported by Peter Horton as while
>ago; in his case that was with PIO IDE.
>
>  
>
Looks like it.

The fix we're using on Cobalt's at the moment is below (required for 
2.4.x and 2.6.x).

Fixing it this way fixes the problem with both page cache pages and swap 
pages.

For more details see the threads "Kernel 2.4.23 on Cobalt Qube2 - area 
of problem" and "Instability / caching problems on Qube 2 - solved ?" 
from December last year.

P.

diff -urN linux.cvs/arch/mips/mm/c-r4k.c linux/arch/mips/mm/c-r4k.c
--- linux.cvs/arch/mips/mm/c-r4k.c	Mon Jan 12 18:19:51 2004
+++ linux/arch/mips/mm/c-r4k.c	Sun Feb  1 13:35:55 2004
@@ -400,8 +400,10 @@
 	 * If there's no context yet, or the page isn't executable, no icache
 	 * flush is needed.
 	 */
+#ifndef CONFIG_MIPS_COBALT
 	if (!(vma->vm_flags & VM_EXEC))
 		return;
+#endif
 
 	/*
 	 * Tricky ...  Because we don't know the virtual address we've got the
@@ -425,6 +427,11 @@
 		r4k_blast_dcache_page(addr);
 		ClearPageDcacheDirty(page);
 	}
+
+#ifdef CONFIG_MIPS_COBALT
+	if (!(vma->vm_flags & VM_EXEC))
+		return;
+#endif
 
 	/*
 	 * We're not sure of the virtual address(es) involved here, so
