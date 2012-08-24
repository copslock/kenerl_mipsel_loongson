Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2012 15:23:29 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59066 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903472Ab2HXNXZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Aug 2012 15:23:25 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7ODNEui024209;
        Fri, 24 Aug 2012 15:23:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7ODNBh4024208;
        Fri, 24 Aug 2012 15:23:11 +0200
Date:   Fri, 24 Aug 2012 15:23:11 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jovi Zhang <bookjovi@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mips@linux-mips.org, Youquan Song <youquan.song@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS/mm: add compound tail page _mapcount when mapped
Message-ID: <20120824132311.GG10439@linux-mips.org>
References: <CACV3sb+nocqeDiM+4m+hv1ygu=KAxD6CpR5wQmawkKMdAuXbgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACV3sb+nocqeDiM+4m+hv1ygu=KAxD6CpR5wQmawkKMdAuXbgA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Aug 22, 2012 at 11:02:34AM +0800, Jovi Zhang wrote:

> see commit b6999b191 which target for x86 mm/gup, let it align with
> mips architecture.
> 
> Quote from commit b6999b191:
>     "If compound pages are used and the page is a
>     tail page, gup_huge_pmd() increases _mapcount to record tail page are
>     mapped while gup_huge_pud does not do that."

Thanks, applied and also acked' for -stable.

Note the patch got linewrapped along the way but it's trivial enough to be
fixed up.

  Ralf
