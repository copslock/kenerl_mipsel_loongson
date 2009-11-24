Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:05:38 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2354 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1493578AbZKXVFf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 22:05:35 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4b0c4a930000>; Tue, 24 Nov 2009 13:05:23 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Nov 2009 13:04:56 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Nov 2009 13:04:56 -0800
Message-ID: <4B0C4A77.9020103@caviumnetworks.com>
Date:	Tue, 24 Nov 2009 13:04:55 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Aurelien Jarno <aurelien@aurel32.net>
CC:	linux-mips@linux-mips.org,
	Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: Re: Syncing CPU caches from userland on MIPS
References: <20091124182841.GE17477@hall.aurel32.net>
In-Reply-To: <20091124182841.GE17477@hall.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Nov 2009 21:04:56.0027 (UTC) FILETIME=[C64A2AB0:01CA6D49]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Aurelien Jarno wrote:
> Hi all,
> 
> This question is not really kernel related, but still MIPS related, I
> hope you don't mind.
> 
> Arnaud Patard and myself are trying to get qemu working on MIPS [1],
> which includes translating TCG code (internal representation) into MIPS
> instructions, that are then executed. Most of the code works, but we 
> have some strange behaviors that seems related to CPU caches.
> 
> The code is written to a buffer, which is then executed. Before the
> execution, the caches are synced using the cacheflush syscall:
> 
> | #include <sys/cachectl.h>
> |  
> | 
> | static inline void flush_icache_range(unsigned long start, unsigned long stop)
> | {
> |     cacheflush ((void *)start, stop-start, ICACHE);
> | }
> 
> It seems this is not enough, as sometimes, some executed code does not
> correspond to the assembly dump of this memory region. This seems to be 
> especially the case of memory regions that are written twice, due to
> relocations:
> 1) a branch instruction is written with an offset of 0
> 2) the offset is patched

Try inserting an 'asm volatile ("sync" ::: "memory");' here.  If that 
fixes things, then we can assume that your cacheflush system call is 
buggy, and would need to add a sync.

> 3) cacheflush is called
> 
> Sometimes the executed code correspond to the code written in 1), which
> means the branch is skipped.
> 
> Does someone knows and/or has example code to correctly sync the CPU 
> caches from userland on MIPS?
> 

http://gcc.gnu.org/viewcvs/trunk/libffi/src/mips/ffi.c

Look at ffi_prep_closure_loc() around line 721.


We also do a similar thing in the kernel in flush_cache_sigtramp(), but 
that is not really userland.


David Daney
