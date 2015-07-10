Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2015 18:11:37 +0200 (CEST)
Received: from tex.lwn.net ([70.33.254.29]:32769 "EHLO vena.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010892AbbGJQLgE7zG1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Jul 2015 18:11:36 +0200
Received: from lwn.net (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by vena.lwn.net (Postfix) with ESMTP id EC8811540042;
        Fri, 10 Jul 2015 10:11:31 -0600 (MDT)
Date:   Fri, 10 Jul 2015 10:11:18 -0600
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
Message-ID: <20150710101118.5d04d627@lwn.net>
In-Reply-To: <20150709184635.GE4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
        <1436288623-13007-4-git-send-email-emunson@akamai.com>
        <20150708132351.61c13db6@lwn.net>
        <20150708203456.GC4669@akamai.com>
        <20150708151750.75e65859@lwn.net>
        <20150709184635.GE4669@akamai.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48196
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

On Thu, 9 Jul 2015 14:46:35 -0400
Eric B Munson <emunson@akamai.com> wrote:

> > One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
> > already has resident pages, I believe that those pages will not be locked
> > until they are reclaimed and faulted back in again, right?  I suspect that
> > could be surprising to users.  
> 
> That is the case.  I am looking into what it would take to find only the
> present pages in a range and lock them, if that is the behavior that is
> preferred I can include it in the updated series.

For whatever my $0.02 is worth, I think that should be done.  Otherwise
the mlock2() interface is essentially nondeterministic; you'll never
really know if a specific page is locked or not.

Thanks,

jon
