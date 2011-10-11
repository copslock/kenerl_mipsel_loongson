Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 20:06:19 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10835 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1JKSGO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 20:06:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e9485e20000>; Tue, 11 Oct 2011 11:07:30 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 11:06:12 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 11:06:12 -0700
Message-ID: <4E948593.6030604@cavium.com>
Date:   Tue, 11 Oct 2011 11:06:11 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Joe Buehler <aspam@cox.net>
CC:     linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
References: <loom.20111010T215444-70@post.gmane.org> <4E9470A1.8020309@cavium.com> <4E947D8A.9090409@cox.net>
In-Reply-To: <4E947D8A.9090409@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2011 18:06:12.0232 (UTC) FILETIME=[75C96880:01CC8840]
X-archive-position: 31223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7420

On 10/11/2011 10:31 AM, Joe Buehler wrote:
> David Daney wrote:
>
>> No, it does nothing of the sort.  You need cacheflush() for that.
>
> OK, I looked at cacheflush and it can be used to flush the icache on all
> CPUs, which is what I want.  My current code sequence is more than that
> however.  Something like this:
>
> 	CVMX_ICACHE_INVALIDATE;

This only works if you can guarantee that the code will never be run on 
a different CPU than the current one.  For most Linux code you cannot 
make such an assertion.

> 	CVMX_SYNC;

Unneeded.

> 	uint64_t tmp;
> 	asm volatile ("    la %0,10f\n"
> 		  "    jr.hb %0\n"
> 		  "    nop\n"
> 		  "    10:\n" : "=r" (tmp) : : "memory");

jr.hb is equivalent to jr on Octeon.

>
> I can certainly modify cacheflush for my application so the extra hazard
> clearing is done when icache is flushed.  Is there any way to avoid that
> and use existing kernel functionality?
>

I cannot parse the meaning out of these last two sentences.  The 
cacheflush() system call both exists and works.  You want to change it?

David Daney
