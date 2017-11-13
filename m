Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 16:49:10 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:33156
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMPtEFXR9u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 16:49:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=armlinux.org.uk; s=pandora-2014;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=3dbHJRuQje94EUEDpm9Mj0JLrfq+QdV2otgWOjClzJQ=;
        b=CCeN+mh22cIPwatQ56AJSncUGBq67/Q3fVWjKsma+z0+DfvBKiAyCoRbump5FlL+2rTvr65qD1QuhmhEtbN433mqOe5KUIdCT2caZsv04ue2fiQdRUl8MyWfB/aOLSRTFlGqeV6kagPjz5FTr88/5mPvIIixr0X1kqr2Y6zWCMk=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:40205)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <linux@armlinux.org.uk>)
        id 1eEGyA-0005gw-At; Mon, 13 Nov 2017 15:48:18 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.76)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1eEGy6-0006EU-7P; Mon, 13 Nov 2017 15:48:14 +0000
Date:   Mon, 13 Nov 2017 15:48:13 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Message-ID: <20171113154811.GM12318@n2100.armlinux.org.uk>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Mon, Nov 13, 2017 at 04:16:41PM +0100, Michal Hocko wrote:
> On Mon 13-11-17 13:00:57, Michal Hocko wrote:
> [...]
> > Yes, I have mentioned that in the previous email but the amount of code
> > would be even larger. Basically every arch which reimplements
> > arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> > do vma lookup.
> 
> It turned out that this might be much more easier than I thought after
> all. It seems we can really handle that in the common code. This would
> mean that we are exposing a new functionality to the userspace though.
> Myabe this would be useful on its own though. Just a quick draft (not
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

A few things...

1. Does this need to be exposed to userland?
2. Can it end up in include/uapi/asm-generic/mman*.h ?
3. The definition of MAP_FIXED_SAFE should really have parens around it.

> @@ -1365,6 +1365,13 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (offset_in_page(addr))
>  		return addr;
>  
> +	if ((flags & MAP_FIXED_SAFE) == MAP_FIXED_SAFE) {

I'm surprised this doesn't warn - since this effectively expands to:

	flags & MAP_FIXED | MAP_KEEP_MAPPING

hence why MAP_FIXED_SAFE needs parens.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
