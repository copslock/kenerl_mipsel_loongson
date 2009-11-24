Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 22:35:28 +0100 (CET)
Received: from hall.aurel32.net ([88.191.82.174]:53084 "EHLO hall.aurel32.net"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493585AbZKXVfZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 22:35:25 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1ND32g-0003tM-OE; Tue, 24 Nov 2009 22:35:22 +0100
Date:	Tue, 24 Nov 2009 22:35:22 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: Re: Syncing CPU caches from userland on MIPS
Message-ID: <20091124213522.GH17477@hall.aurel32.net>
References: <20091124182841.GE17477@hall.aurel32.net> <4B0C4A77.9020103@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4B0C4A77.9020103@caviumnetworks.com>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 01:04:55PM -0800, David Daney wrote:
> Aurelien Jarno wrote:
>> Hi all,
>>
>> This question is not really kernel related, but still MIPS related, I
>> hope you don't mind.
>>
>> Arnaud Patard and myself are trying to get qemu working on MIPS [1],
>> which includes translating TCG code (internal representation) into MIPS
>> instructions, that are then executed. Most of the code works, but we  
>> have some strange behaviors that seems related to CPU caches.
>>
>> The code is written to a buffer, which is then executed. Before the
>> execution, the caches are synced using the cacheflush syscall:
>>
>> | #include <sys/cachectl.h>
>> |  | | static inline void flush_icache_range(unsigned long start, 
>> unsigned long stop)
>> | {
>> |     cacheflush ((void *)start, stop-start, ICACHE);
>> | }
>>
>> It seems this is not enough, as sometimes, some executed code does not
>> correspond to the assembly dump of this memory region. This seems to be 
>> especially the case of memory regions that are written twice, due to
>> relocations:
>> 1) a branch instruction is written with an offset of 0
>> 2) the offset is patched
>
> Try inserting an 'asm volatile ("sync" ::: "memory");' here.  If that  
> fixes things, then we can assume that your cacheflush system call is  
> buggy, and would need to add a sync.
>

That doesn't help, it still crashes at the same location.

Aurelien

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
