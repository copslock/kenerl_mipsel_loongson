Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 10:29:26 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:42008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990485AbdKNJ3TCfqEh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 10:29:19 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 634C6AAB5;
        Tue, 14 Nov 2017 09:29:17 +0000 (UTC)
Date:   Tue, 14 Nov 2017 10:29:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
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
Message-ID: <20171114092916.ho5mvwc23xnelmod@dhcp22.suse.cz>
References: <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
 <87a7zpw75f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7zpw75f.fsf@concordia.ellerman.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mhocko@kernel.org
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

On Tue 14-11-17 20:18:04, Michael Ellerman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > [Sorry for spamming, this one is the last attempt hopefully]
> >
> > On Mon 13-11-17 16:49:39, Michal Hocko wrote:
> >> On Mon 13-11-17 16:16:41, Michal Hocko wrote:
> >> > On Mon 13-11-17 13:00:57, Michal Hocko wrote:
> >> > [...]
> >> > > Yes, I have mentioned that in the previous email but the amount of code
> >> > > would be even larger. Basically every arch which reimplements
> >> > > arch_get_unmapped_area would have to special case new MAP_FIXED flag to
> >> > > do vma lookup.
> >> > 
> >> > It turned out that this might be much more easier than I thought after
> >> > all. It seems we can really handle that in the common code. This would
> >> > mean that we are exposing a new functionality to the userspace though.
> >> > Myabe this would be useful on its own though. Just a quick draft (not
> >> > even compile tested) whether this makes sense in general. I would be
> >> > worried about unexpected behavior when somebody set other bit without a
> >> > good reason and we might fail with ENOMEM for such a call now.
> >> 
> >> Hmm, the bigger problem would be the backward compatibility actually. We
> >> would get silent corruptions which is exactly what the flag is trying
> >> fix. mmap flags handling really sucks. So I guess we would have to make
> >> the flag internal only :/
> >
> > OK, so this one should take care of the backward compatibility while
> > still not touching the arch code
> 
> I'm not sure I understand your worries about backward compatibility?

Just imagine you are running an application which uses the new flag
combination on an older kernel. You will get no warning, yet you have no
way to check that you have actually clobbered an existing mapping
because MAP_FIXED will be used the old way.

> If we add a new mmap flag which is currently unused then what is the
> problem? Are you worried about user code that accidentally passes that
> flag already?

If we add a completely new flag, like in this patch, then the code using
the flag will not clobber an existing mapping on older kernels which do
not recognize it (we will simply fall back to the default hint based
implementation). You might not get the mapping you asked for which sucks
but that is not fixable AFAICS. You can at least do

	mapped_addr = mmap(addr, ... MAP_FIXED_SAFE...);
	assert(mapped_addr == addr);

So I do not think we can go with the modifier unfortunatelly.
-- 
Michal Hocko
SUSE Labs
