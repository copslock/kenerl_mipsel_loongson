Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 12:50:04 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:37911 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009443AbbG2KuCsGSgy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Jul 2015 12:50:02 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D487ABF9;
        Wed, 29 Jul 2015 10:50:01 +0000 (UTC)
Subject: Re: [PATCH V5 0/7] Allow user to request memory to be locked on page
 fault
To:     Michal Hocko <mhocko@kernel.org>,
        Eric B Munson <emunson@akamai.com>
References: <1437773325-8623-1-git-send-email-emunson@akamai.com>
 <55B5F4FF.9070604@suse.cz> <20150727133555.GA17133@akamai.com>
 <55B63D37.20303@suse.cz> <20150727145409.GB21664@akamai.com>
 <20150728111725.GG24972@dhcp22.suse.cz> <20150728134942.GB2407@akamai.com>
 <20150729104532.GE15801@dhcp22.suse.cz>
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
Message-ID: <55B8AFD5.3030902@suse.cz>
Date:   Wed, 29 Jul 2015 12:49:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150729104532.GE15801@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <vbabka@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48493
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

On 07/29/2015 12:45 PM, Michal Hocko wrote:
>> In a much less
>> likely corner case, it is not possible in the current setup to request
>> all current VMAs be VM_LOCKONFAULT and all future be VM_LOCKED.
> 
> Vlastimil has already pointed that out. MCL_FUTURE doesn't clear
> MCL_CURRENT. I was quite surprised in the beginning but it makes a
> perfect sense. mlockall call shouldn't lead into munlocking, that would
> be just weird. Clearing MCL_FUTURE on MCL_CURRENT makes sense on the
> other hand because the request is explicit about _current_ memory and it
> doesn't lead to any munlocking.

Yeah after more thinking it does make some sense despite the perceived
inconsistency, but it's definitely worth documenting properly. It also already
covers the usecase for munlockall2(MCL_FUTURE) which IIRC you had in the earlier
revisions...
