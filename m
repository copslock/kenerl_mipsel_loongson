Received:  by oss.sgi.com id <S42414AbQI2XGe>;
	Fri, 29 Sep 2000 16:06:34 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:42748 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S42406AbQI2XGR>;
	Fri, 29 Sep 2000 16:06:17 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e8TN57x15668;
	Fri, 29 Sep 2000 16:05:07 -0700
Message-ID: <39D5204A.8BE1E357@mvista.com>
Date:   Fri, 29 Sep 2000 16:05:46 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     glonnon@ridgerun.com
CC:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: problems execve("/sbin/init",...)
References: <39D3FFE4.35E83599@ridgerun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Greg Lonnon wrote:
> 
> So, my questions are:
> 1) Does anyone have a good way to debug in this small window going
> between kernel mode and user mode for the first time?

Not really.  One time I had similar problem.  I was able to figure out
the problem by setting breakpoints in fault handlers.

> 2) Is there anything else I could try to prove out that the kernel is
> going into user mode?

Try to set breakpoint in fault handlers.

> 3) Has anyone else had these issues?
>

I found one bug in arch/mm/r4xx0.c, where cache invalidation causes
recursive page faults.  See the page below.  Not sure if it is fixed in
the tree yet.

diff -Nru linux/arch/mips/mm/r4xx0.c.orig linux/arch/mips/mm/r4xx0.c
--- linux/arch/mips/mm/r4xx0.c.orig     Sun Jul 30 20:39:50 2000
+++ linux/arch/mips/mm/r4xx0.c  Thu Aug 10 16:08:20 2000
@@ -1972,7 +1972,8 @@
        if (!(vma->vm_flags & VM_EXEC))
                return;

-       blast_icache32_page(address);
+        address = KSEG0 + (address & PAGE_MASK & (dcache_size - 1));
+        blast_icache32_page_indexed(address);
 }

 /*
 
Jun
