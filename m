Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 08:08:04 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:55565 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990482AbdKNHH5ciYuF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 08:07:57 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3AA358130F;
        Tue, 14 Nov 2017 07:07:53 +0000 (UTC)
Date:   Tue, 14 Nov 2017 08:07:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joel Stanley <joel@jms.id.au>,
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
Message-ID: <20171114070748.in5zdc4giqbxowjy@dhcp22.suse.cz>
References: <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
 <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60904
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

On Mon 13-11-17 09:35:22, Khalid Aziz wrote:
> On 11/13/2017 09:06 AM, Michal Hocko wrote:
> > OK, so this one should take care of the backward compatibility while
> > still not touching the arch code
> > ---
> > commit 39ff9bf8597e79a032da0954aea1f0d77d137765
> > Author: Michal Hocko <mhocko@suse.com>
> > Date:   Mon Nov 13 17:06:24 2017 +0100
> > 
> >      mm: introduce MAP_FIXED_SAFE
> >      MAP_FIXED is used quite often but it is inherently dangerous because it
> >      unmaps an existing mapping covered by the requested range. While this
> >      might be might be really desidered behavior in many cases there are
> >      others which would rather see a failure than a silent memory corruption.
> >      Introduce a new MAP_FIXED_SAFE flag for mmap to achive this behavior.
> >      It is a MAP_FIXED extension with a single exception that it fails with
> >      ENOMEM if the requested address is already covered by an existing
> >      mapping. We still do rely on get_unmaped_area to handle all the arch
> >      specific MAP_FIXED treatment and check for a conflicting vma after it
> >      returns.
> >      Signed-off-by: Michal Hocko <mhocko@suse.com>
> > 
> > ...... deleted .......
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 680506faceae..aad8d37f0205 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1358,6 +1358,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >   	if (mm->map_count > sysctl_max_map_count)
> >   		return -ENOMEM;
> > +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> > +	if (flags & MAP_FIXED_SAFE)
> > +		flags |= MAP_FIXED;
> > +
> >   	/* Obtain the address to map to. we verify (or select) it and ensure
> >   	 * that it represents a valid section of the address space.
> >   	 */
> 
> Do you need to move this code above:
> 
>         if (!(flags & MAP_FIXED))
>                 addr = round_hint_to_min(addr);
> 
>         /* Careful about overflows.. */
>         len = PAGE_ALIGN(len);
>         if (!len)
>                 return -ENOMEM;
> 
> Not doing that might mean the hint address will end up being rounded for
> MAP_FIXED_SAFE which would change the behavior from MAP_FIXED.

Yes, I will move it.
-- 
Michal Hocko
SUSE Labs
