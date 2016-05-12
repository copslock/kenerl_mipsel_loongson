Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 15:08:03 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:57583 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029295AbcELNIBogoF4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 15:08:01 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC2976407D;
        Thu, 12 May 2016 13:07:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4CD7quf002784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 12 May 2016 09:07:54 -0400
Subject: Re: Endless loop on execution attempt on non-executable page
To:     Ralf Baechle <ralf@linux-mips.org>
References: <57345F0D.9070503@redhat.com>
 <20160512125342.GS16402@linux-mips.org>
Cc:     linux-mips@linux-mips.org
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <9af052f6-b50c-7ba5-ebbb-0bdff0c58dd9@redhat.com>
Date:   Thu, 12 May 2016 15:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <20160512125342.GS16402@linux-mips.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 12 May 2016 13:07:55 +0000 (UTC)
Return-Path: <fweimer@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweimer@redhat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/12/2016 02:53 PM, Ralf Baechle wrote:
> On Thu, May 12, 2016 at 12:46:37PM +0200, Florian Weimer wrote:
>
>> The GCC compile farm has a big-endian 64-bit MIPS box.  The kernel is:
>>
>> Linux erpro8-fsf1 3.14.10-er8mod-00013-ge0fe977 #1 SMP PREEMPT Wed Jan
>> 14 12:33:22 PST 2015 mips64 GNU/Linux
>>
>> Which is a vendor kernel for the EdgeRouter Pro-8.
>>
>> /proc/cpuinfo reports:
>>
>> system type             : UBNT_E200 (CN6120p1.1-1000-NSP)
>> machine                 : Unknown
>> processor               : 0
>> cpu model               : Cavium Octeon II V0.1
>>
>> While testing W^X (execmod, DEP, NX) stack enforcement, I noticed that once
>> I try to execute code off a non-executable page, I do not get a signal, but
>> the code appears to enter an infinite loop.  The generated function starts
>> with a jump instruction to return to the caller, but instead, the program
>> counter does not seem to change at all.
>>
>> “si” in GDB also hangs (but can be interrupted with ^C).
>>
>> My test code is here:
>>
>>   https://pagure.io/execmod-tests
>>
>> Is this a kernel bug or an issue with the silicon?
>
> I see the test case uses mprotect to add PROT_EXEC after writing the code
> to memory.  I don't think mprotect however gives any guarantee that this
> will make the I-cache coherent with the D-cache, that is that the CPU will
> actually fetch and execute the instruction that were just written to memory.
> For that you have to do something architecture specific such as dancing
> around a fire waving a dead chicken.  Or on MIPS call cacheflush(), see
> the man page for details.

There is a fork between the write and the execute.  It is somewhat 
unlikely that that's not a barrier, but it did happen on POWER.

However, I can successfully execute code without the barrier, so this 
whole thing goes in the wrong direction. :)

I have added it, just to be on the safe side.

> For portability sake to some broken processors you should also ensure
> that a 32 byte cache line is entirely filled with valid instructions by
> padding the two test instructions with another six no-op (opcode 0).

Added as well.

> The test case as it is guarantees this implicitly by using a freshly
> allocated page but I thought I should mention it.

There are some tests that don't (the stack variable might be clobbered, 
for example).

Anyway, neither change fixed things for me.  Given the peculiar “si” 
behavior in GDB, that's not entirely unexpected ...

Thanks,
Florian
