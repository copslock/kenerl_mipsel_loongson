Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 17:36:07 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:33203 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008757AbbGUPgD71yfx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jul 2015 17:36:03 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B748DAB02;
        Tue, 21 Jul 2015 15:36:02 +0000 (UTC)
Message-ID: <55AE66DF.1060600@suse.cz>
Date:   Tue, 21 Jul 2015 17:35:59 +0200
From:   Vlastimil Babka <vbabka@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Eric B Munson <emunson@akamai.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add mlock
 flags to enable it
References: <1436288623-13007-1-git-send-email-emunson@akamai.com> <1436288623-13007-4-git-send-email-emunson@akamai.com> <20150708132351.61c13db6@lwn.net> <20150708203456.GC4669@akamai.com> <20150708151750.75e65859@lwn.net> <20150709184635.GE4669@akamai.com> <20150710101118.5d04d627@lwn.net> <20150710161948.GF4669@akamai.com>
In-Reply-To: <20150710161948.GF4669@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48365
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

On 07/10/2015 06:19 PM, Eric B Munson wrote:
> On Fri, 10 Jul 2015, Jonathan Corbet wrote:
>
>> On Thu, 9 Jul 2015 14:46:35 -0400
>> Eric B Munson <emunson@akamai.com> wrote:
>>
>>>> One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
>>>> already has resident pages, I believe that those pages will not be locked
>>>> until they are reclaimed and faulted back in again, right?  I suspect that
>>>> could be surprising to users.
>>>
>>> That is the case.  I am looking into what it would take to find only the
>>> present pages in a range and lock them, if that is the behavior that is
>>> preferred I can include it in the updated series.
>>
>> For whatever my $0.02 is worth, I think that should be done.  Otherwise
>> the mlock2() interface is essentially nondeterministic; you'll never
>> really know if a specific page is locked or not.
>>
>> Thanks,
>>
>> jon
>
> Okay, I likely won't have the new set out today then.  This change is
> more invasive.  IIUC, I need an equivalent to __get_user_page() skips
> pages which are not present instead of faulting in and the call chain to
> get to it.  Unless there is an easier way that I am missing.

IIRC having page PageMlocked and put on unevictable list isn't necessary 
to prevent it from being reclaimed. It's just to prevent it from being 
scanned for reclaim in the first place. When attempting to unmap the 
page, vma flags are still checked, see the code in try_to_unmap_one(). 
You should probably extend the checks to your new VM_ flag as it is done 
for VM_LOCKED and then you shouldn't need to walk the pages to mlock 
them (although it would probably still be better for the accounting 
accuracy).

> Eric
>
