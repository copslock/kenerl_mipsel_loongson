Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 16:49:53 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:59486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990427AbdKMPtmC2XEu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 16:49:42 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ECDA2AAC1;
        Mon, 13 Nov 2017 15:49:40 +0000 (UTC)
Date:   Mon, 13 Nov 2017 16:49:39 +0100
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
Message-ID: <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
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
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mhocko@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60877
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

On Mon 13-11-17 16:16:41, Michal Hocko wrote:
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

Hmm, the bigger problem would be the backward compatibility actually. We
would get silent corruptions which is exactly what the flag is trying
fix. mmap flags handling really sucks. So I guess we would have to make
the flag internal only :/

-- 
Michal Hocko
SUSE Labs
