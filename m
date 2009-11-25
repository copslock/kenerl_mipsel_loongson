Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 15:30:35 +0100 (CET)
Received: from lechat.rtp-net.org ([88.191.19.38]:34123 "EHLO
        lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492872AbZKYOac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 15:30:32 +0100
Received: by lechat.rtp-net.org (Postfix, from userid 5001)
        id D18D610081; Wed, 25 Nov 2009 15:39:01 +0100 (CET)
Received: from lechat.rtp-net.org (ip6-localhost [IPv6:::1])
        by lechat.rtp-net.org (Postfix) with ESMTP id 3F0D31007D;
        Wed, 25 Nov 2009 15:39:01 +0100 (CET)
From:   Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
Subject: Re: Syncing CPU caches from userland on MIPS
References: <20091124182841.GE17477@hall.aurel32.net>
        <20091125140105.GB13938@paradigm.rfc822.org>
Organization: RtpNet
Date:   Wed, 25 Nov 2009 15:39:01 +0100
In-Reply-To: <20091125140105.GB13938@paradigm.rfc822.org> (Florian Lohoff's message of "Wed\, 25 Nov 2009 15\:01\:05 +0100")
Message-ID: <87pr76acu2.fsf@lechat.rtp-net.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@rtp-net.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.patard@rtp-net.org
Precedence: bulk
X-list: linux-mips

Florian Lohoff <flo@rfc822.org> writes:
Hi,

> On Tue, Nov 24, 2009 at 07:28:41PM +0100, Aurelien Jarno wrote:
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
>> |  
>> | 
>> | static inline void flush_icache_range(unsigned long start, unsigned long stop)
>> | {
>> |     cacheflush ((void *)start, stop-start, ICACHE);
>> | }
>
> Would this only evict stuff from the ICACHE? When trying to execute
> a just written buffer and with a writeback DCACHE you would need to 
> explicitly writeback the DCACHE to memory and invalidate the ICACHE.

we already though about using BCACHE instead of ICACHE only but it
didn't make any difference. the bug is still there.

Arnaud
