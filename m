Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jul 2015 17:11:02 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:55245 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011429AbbG1PK7eThPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Jul 2015 17:10:59 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEF68ABDE;
        Tue, 28 Jul 2015 15:10:57 +0000 (UTC)
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
To:     Eric B Munson <emunson@akamai.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz> <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz> <20150727145409.GB21664@akamai.com>
 <20150728111725.GG24972@dhcp22.suse.cz> <20150728134942.GB2407@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <55B79B7F.9010604@suse.cz>
Date:   Tue, 28 Jul 2015 17:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20150728134942.GB2407@akamai.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48489
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

On 07/28/2015 03:49 PM, Eric B Munson wrote:
> On Tue, 28 Jul 2015, Michal Hocko wrote:
>

[...]

> The only
> remaining question I have is should we have 2 new mlockall flags so that
> the caller can explicitly set VM_LOCKONFAULT in the mm->def_flags vs
> locking all current VMAs on fault.  I ask because if the user wants to
> lock all current VMAs the old way, but all future VMAs on fault they
> have to call mlockall() twice:
>
> 	mlockall(MCL_CURRENT);
> 	mlockall(MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT);
>
> This has the side effect of converting all the current VMAs to
> VM_LOCKONFAULT, but because they were all made present and locked in the
> first call, this should not matter in most cases.

Shouldn't the user be able to do this?

mlockall(MCL_CURRENT)
mlockall(MCL_FUTURE | MCL_ONFAULT);

Note that the second call shouldn't change (i.e. munlock) existing vma's 
just because MCL_CURRENT is not present. The current implementation 
doesn't do that thanks to the following in do_mlockall():

         if (flags == MCL_FUTURE)
                 goto out;

before current vma's are processed and MCL_CURRENT is checked. This is 
probably so that do_mlockall() can also handle the munlockall() syscall.
So we should be careful not to break this, but otherwise there are no 
limitations by not having two MCL_ONFAULT flags. Having to do invoke 
syscalls instead of one is not an issue as this shouldn't be frequent 
syscall.

> The catch is that,
> like mmap(MAP_LOCKED), mlockall() does not communicate if mm_populate()
> fails.  This has been true of mlockall() from the beginning so I don't
> know if it needs more than an entry in the man page to clarify (which I
> will add when I add documentation for MCL_ONFAULT).

Good point.

> In a much less
> likely corner case, it is not possible in the current setup to request
> all current VMAs be VM_LOCKONFAULT and all future be VM_LOCKED.

So again this should work:

mlockall(MCL_CURRENT | MCL_ONFAULT)
mlockall(MCL_FUTURE);

But the order matters here, as current implementation of do_mlockall() 
will clear VM_LOCKED from def_flags if MCL_FUTURE is not passed. So 
*it's different* from how it handles MCL_CURRENT (as explained above). 
And not documented in manpage. Oh crap, this API is a closet full of 
skeletons. Maybe it was an unnoticed regression and we can restore some 
sanity?
