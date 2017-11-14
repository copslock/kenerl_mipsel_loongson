Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 10:02:22 +0100 (CET)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:44345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990485AbdKNJCPCDm0v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 10:02:15 +0100
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3ybhN232lMz9sPs;
        Tue, 14 Nov 2017 20:02:10 +1100 (AEDT)
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
In-Reply-To: <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au> <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com> <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz> <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz> <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com> <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz> <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz> <87lgjawgx1.fsf@concordia.ellerman.id.au> <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz> <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
Date:   Tue, 14 Nov 2017 20:02:09 +1100
Message-ID: <87efp1w7vy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60906
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

> On Mon 13-11-17 13:00:57, Michal Hocko wrote:
> [...]
>> Yes, I have mentioned that in the previous email but the amount of code
>> would be even larger. Basically every arch which reimplements
>> arch_get_unmapped_area would have to special case new MAP_FIXED flag to
>> do vma lookup.
>
> It turned out that this might be much more easier than I thought after
> all. It seems we can really handle that in the common code.

Ah nice. I should have read this before replying to your previous mail.

> This would mean that we are exposing a new functionality to the userspace though.
> Myabe this would be useful on its own though.

Yes I think it would. At least jemalloc seems like it could use it:

  https://github.com/jemalloc/jemalloc/blob/9f455e2786685b443201c33119765c8093461174/src/pages.c#L65

And I have memories of some JIT code I read once which did a loop of
mmap()s or something to try and get allocations below 4GB or some other
limit - but I can't remember now what it was.

> Just a quick draft (not
> even compile tested) whether this makes sense in general. I would be
> worried about unexpected behavior when somebody set other bit without a
> good reason and we might fail with ENOMEM for such a call now.
>
> Elf loader would then use MAP_FIXED_SAFE rather than MAP_FIXED.
> ---
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> index 3b26cc62dadb..d021c21f9b01 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -31,6 +31,9 @@
>  #define MAP_STACK	0x80000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x100000	/* create a huge page mapping */
>  
> +#define MAP_KEEP_MAPPING 0x2000000
> +#define MAP_FIXED_SAFE	MAP_FIXED|MAP_KEEP_MAPPING /* enforce MAP_FIXED without clobbering an existing mapping */


So bike-shedding a bit, but I think "SAFE" is too vague a name.

Perhaps MAP_NO_CLOBBER - which has the single semantic of "do not
clobber any existing mappings".

It would be a flag on its own, so you could pass it with or without
MAP_FIXED, but it would only change the behaviour when MAP_FIXED is
specified also.

cheers
