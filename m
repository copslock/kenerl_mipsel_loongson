Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 11:08:23 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:56757 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008877AbbG0JIVtZBTn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jul 2015 11:08:21 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94F43AAD1;
        Mon, 27 Jul 2015 09:08:19 +0000 (UTC)
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
To:     Eric B Munson <emunson@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
Cc:     Shuah Khan <shuahkh@osg.samsung.com>,
        Michal Hocko <mhocko@suse.cz>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55B5F4FF.9070604@suse.cz>
Date:   Mon, 27 Jul 2015 11:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1437773325-8623-1-git-send-email-emunson@akamai.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48428
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

On 07/24/2015 11:28 PM, Eric B Munson wrote:

...

> Changes from V4:
> Drop all architectures for new sys call entries except x86[_64] and MIPS
> Drop munlock2 and munlockall2
> Make VM_LOCKONFAULT a modifier to VM_LOCKED only to simplify book keeping
> Adjust tests to match

Hi, thanks for considering my suggestions. Well, I do hope there were 
correct as API's are hard and I'm no API expert. But since API's are 
also impossible to change after merging, I'm sorry but I'll keep 
pestering for one last thing. Thanks again for persisting, I do believe 
it's for the good thing!

The thing is that I still don't like that one has to call 
mlock2(MLOCK_LOCKED) to get the equivalent of the old mlock(). Why is 
that flag needed? We have two modes of locking now, and v5 no longer 
treats them separately in vma flags. But having two flags gives us four 
possible combinations, so two of them would serve nothing but to confuse 
the programmer IMHO. What will mlock2() without flags do? What will 
mlock2(MLOCK_LOCKED | MLOCK_ONFAULT) do? (Note I haven't studied the 
code yet, as having agreed on the API should come first. But I did 
suggest documenting these things more thoroughly too...)
OK I checked now and both cases above seem to return EINVAL.

So about the only point I see in MLOCK_LOCKED flag is parity with 
MAP_LOCKED for mmap(). But as Kirill said (and me before as well) 
MAP_LOCKED is broken anyway so we shouldn't twist the rest just of the 
API to keep the poor thing happier in its misery.

Also note that AFAICS you don't have MCL_LOCKED for mlockall() so 
there's no full parity anyway. But please don't fix that by adding 
MCL_LOCKED :)

Thanks!
