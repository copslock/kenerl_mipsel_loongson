Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 09:55:19 +0100 (CET)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:37477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990485AbdKNIzLT4Q3v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 09:55:11 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3ybhCm48X0z9sPr;
        Tue, 14 Nov 2017 19:55:00 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
Subject: Re: linux-next: Tree for Nov 7
In-Reply-To: <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au> <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com> <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz> <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz> <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com> <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz> <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz> <87lgjawgx1.fsf@concordia.ellerman.id.au> <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
Date:   Tue, 14 Nov 2017 19:54:59 +1100
Message-ID: <87h8txw87w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

Michal Hocko <mhocko@kernel.org> writes:

> On Mon 13-11-17 22:34:50, Michael Ellerman wrote:
>> Hi Michal,
>> 
>> Michal Hocko <mhocko@kernel.org> writes:
>> > On Mon 13-11-17 10:20:06, Michal Hocko wrote:
>> >> [Cc arm and ppc maintainers]
>> >
>> > Hmm, it turned out to be a problem on other architectures as well.
>> > CCing more maintainers. For your reference, we are talking about
>> > http://lkml.kernel.org/r/20171023082608.6167-1-mhocko@kernel.org
>> > which has broken architectures which do apply aligning on the mmap
>> > address hint without MAP_FIXED applied. See below my proposed way
>> > around this issue because I belive that the above patch is quite
>> > valuable on its own to be dropped for all archs.
>> 
>> I don't really like your solution sorry :)  The fact that you've had to
>> patch seven arches seems like a red flag.
>> 
>> I think this is a generic problem with MAP_FIXED, which I've heard
>> userspace folks complain about in the past.
>
> The thing is that we canno  change MAP_FIXED behavior as it is carved in
> stone

Yes obviously. I didn't mean to imply we would change MAP_FIXED, rather
we would add a new flag with the new semantics.

>> Currently MAP_FIXED does two things:
>>   1. makes addr not a hint but the required address
>>   2. blasts any existing mapping
>> 
>> You want 1) but not 2).
>
> + fail if there is a clashing range

Yep. I thought that was implied :)

>> So the right solution IMHO would be to add a new mmap flag to request
>> that behaviour, ie. a fixed address but iff there is nothing already
>> mapped there.
>> 
>> I don't know the mm code well enough to know if that's hard for some
>> reason, but it *seems* like it should be doable.
>
> Yes, I have mentioned that in the previous email but the amount of code
> would be even larger. Basically every arch which reimplements
> arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> do vma lookup.

I'd have to look, but my memory of the arch code is that it doesn't deal
with the vma so it wouldn't need any change.

> So this was the most simple solution I could come up
> with. If there was a general interest for MAP_FIXED_SAFE then we can
> introduce it later of course. I would just like the hardening merged
> sooner rather than later.

Sure. But in the scheme of things one more kernel release is not that
big a deal to get it right. Given that the simple approach of dropping
MAP_FIXED turns out to not be simple at all.

cheers
