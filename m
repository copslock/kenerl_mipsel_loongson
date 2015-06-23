Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2015 15:04:26 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:40077 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006932AbbFWNEYnZXPS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Jun 2015 15:04:24 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF68FAAB4;
        Tue, 23 Jun 2015 13:04:23 +0000 (UTC)
Message-ID: <55895956.5020707@suse.cz>
Date:   Tue, 23 Jun 2015 15:04:22 +0200
From:   Vlastimil Babka <vbabka@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Eric B Munson <emunson@akamai.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH V2 0/3] Allow user to request memory to be locked
 on page fault
References: <1433942810-7852-1-git-send-email-emunson@akamai.com> <20150610145929.b22be8647887ea7091b09ae1@linux-foundation.org> <5579DFBA.80809@akamai.com> <20150611123424.4bb07cffd0e5bb146cc92231@linux-foundation.org> <557ACAFC.90608@suse.cz> <20150615144356.GB12300@akamai.com>
In-Reply-To: <20150615144356.GB12300@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbabka@suse.cz
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

On 06/15/2015 04:43 PM, Eric B Munson wrote:
>> Note that the semantic of MAP_LOCKED can be subtly surprising:
>>
>> "mlock(2) fails if the memory range cannot get populated to guarantee
>> that no future major faults will happen on the range.
>> mmap(MAP_LOCKED) on the other hand silently succeeds even if the
>> range was populated only
>> partially."
>>
>> ( from http://marc.info/?l=linux-mm&m=143152790412727&w=2 )
>>
>> So MAP_LOCKED can silently behave like MAP_LOCKONFAULT. While
>> MAP_LOCKONFAULT doesn't suffer from such problem, I wonder if that's
>> sufficient reason not to extend mmap by new mlock() flags that can
>> be instead applied to the VMA after mmapping, using the proposed
>> mlock2() with flags. So I think instead we could deprecate
>> MAP_LOCKED more prominently. I doubt the overhead of calling the
>> extra syscall matters here?
>
> We could talk about retiring the MAP_LOCKED flag but I suspect that
> would get significantly more pushback than adding a new mmap flag.

Oh no we can't "retire" as in remove the flag, ever. Just not continue 
the way of mmap() flags related to mlock().

> Likely that the overhead does not matter in most cases, but presumably
> there are cases where it does (as we have a MAP_LOCKED flag today).
> Even with the proposed new system calls I think we should have the
> MAP_LOCKONFAULT for parity with MAP_LOCKED.

I'm not convinced, but it's not a major issue.

>>
>>> - mlock() takes a `flags' argument.  Presently that's
>>>    MLOCK_LOCKED|MLOCK_LOCKONFAULT.
>>>
>>> - munlock() takes a `flags' arument.  MLOCK_LOCKED|MLOCK_LOCKONFAULT
>>>    to specify which flags are being cleared.
>>>
>>> - mlockall() and munlockall() ditto.
>>>
>>>
>>> IOW, LOCKED and LOCKEDONFAULT are treated identically and independently.
>>>
>>> Now, that's how we would have designed all this on day one.  And I
>>> think we can do this now, by adding new mlock2() and munlock2()
>>> syscalls.  And we may as well deprecate the old mlock() and munlock(),
>>> not that this matters much.
>>>
>>> *should* we do this?  I'm thinking "yes" - it's all pretty simple
>>> boilerplate and wrappers and such, and it gets the interface correct,
>>> and extensible.
>>
>> If the new LOCKONFAULT functionality is indeed desired (I haven't
>> still decided myself) then I agree that would be the cleanest way.
>
> Do you disagree with the use cases I have listed or do you think there
> is a better way of addressing those cases?

I'm somewhat sceptical about the security one. Are security sensitive 
buffers that large to matter? The performance one is more convincing and 
I don't see a better way, so OK.

>
>>
>>> What do others think?
