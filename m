Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 11:24:07 +0200 (CEST)
Received: from bes.se.axis.com ([195.60.68.10]:41110 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992241AbcJQJX7Ef96h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Oct 2016 11:23:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by bes.se.axis.com (Postfix) with ESMTP id AFB632E1A8;
        Mon, 17 Oct 2016 11:23:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dTxFtT27dOaJ; Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bes.se.axis.com (Postfix) with ESMTPS id 6E2D72E187;
        Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C9E81A091;
        Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E9D1A090;
        Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by seth.se.axis.com (Postfix) with ESMTP id 35A0B2B8;
        Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id 30B90800EE; Mon, 17 Oct 2016 11:23:52 +0200 (CEST)
Date:   Mon, 17 Oct 2016 11:23:52 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-mips@linux-mips.org,
        linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>,
        kvm@vger.kernel.org, linux-sh@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        x86@kernel.org, Hugh Dickins <hughd@google.com>,
        linux-media@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 10/10] mm: replace access_process_vm() write parameter
 with gup_flags
Message-ID: <20161017092352.GH30704@axis.com>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-11-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161013002020.3062-11-lstoakes@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Thu, Oct 13, 2016 at 01:20:20AM +0100, Lorenzo Stoakes wrote:
> This patch removes the write parameter from access_process_vm() and replaces it
> with a gup_flags parameter as use of this function previously _implied_
> FOLL_FORCE, whereas after this patch callers explicitly pass this flag.
> 
> We make this explicit as use of FOLL_FORCE can result in surprising behaviour
> (and hence bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  arch/cris/arch-v32/kernel/ptrace.c |  4 ++--

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
