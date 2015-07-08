Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 23:17:55 +0200 (CEST)
Received: from tex.lwn.net ([70.33.254.29]:55408 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008099AbbGHVRxdscLt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 23:17:53 +0200
Received: from lwn.net (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by vena.lwn.net (Postfix) with ESMTP id 7E1A91540042;
        Wed,  8 Jul 2015 15:17:51 -0600 (MDT)
Date:   Wed, 8 Jul 2015 15:17:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric B Munson <emunson@akamai.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add
 mlock flags to enable it
Message-ID: <20150708151750.75e65859@lwn.net>
In-Reply-To: <20150708203456.GC4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
        <1436288623-13007-4-git-send-email-emunson@akamai.com>
        <20150708132351.61c13db6@lwn.net>
        <20150708203456.GC4669@akamai.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: corbet@lwn.net
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

On Wed, 8 Jul 2015 16:34:56 -0400
Eric B Munson <emunson@akamai.com> wrote:

> > Quick, possibly dumb question: I've been beating my head against these for
> > a little bit, and I can't figure out what's supposed to happen in this
> > case:
> > 
> > 	mlock2(addr, len, MLOCK_ONFAULT);
> > 	munlock2(addr, len, MLOCK_LOCKED);
> > 
> > It looks to me like it will clear VM_LOCKED without actually unlocking any
> > pages.  Is that the intended result?  
> 
> This is not quite right, what happens when you call munlock2(addr, len,
> MLOCK_LOCKED); is we call apply_vma_flags(addr, len, VM_LOCKED, false).

From your explanation, it looks like what I said *was* right...what I was
missing was the fact that VM_LOCKED isn't set in the first place.  So that
call would be a no-op, clearing a flag that's already cleared.

One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
already has resident pages, I believe that those pages will not be locked
until they are reclaimed and faulted back in again, right?  I suspect that
could be surprising to users.

Thanks,

jon
