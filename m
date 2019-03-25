Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D1C43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 16:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835B920828
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 16:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfCYQ1e (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:27:34 -0400
Received: from mga18.intel.com ([134.134.136.126]:50097 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfCYQ1e (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Mar 2019 12:27:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="217406487"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2019 09:27:31 -0700
Date:   Mon, 25 Mar 2019 01:26:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RESEND 3/7] mm/gup: Change GUP fast to use flags rather than a
 write 'bool'
Message-ID: <20190325082620.GB16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-4-ira.weiny@intel.com>
 <CAA9_cmd9gUWMbpkP_AuxZ08iqvZdxjbtDoR-FpSjAyhZJisRZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmd9gUWMbpkP_AuxZ08iqvZdxjbtDoR-FpSjAyhZJisRZA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Mar 22, 2019 at 03:05:53PM -0700, Dan Williams wrote:
> On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > To facilitate additional options to get_user_pages_fast() change the
> > singular write parameter to be gup_flags.
> >
> > This patch does not change any functionality.  New functionality will
> > follow in subsequent patches.
> >
> > Some of the get_user_pages_fast() call sites were unchanged because they
> > already passed FOLL_WRITE or 0 for the write parameter.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes from V1:
> >         Rebase to current merge tree
> >         arch/powerpc/mm/mmu_context_iommu.c no longer calls gup_fast
> >                 The gup_longterm was converted in patch 1
> >
> >  arch/mips/mm/gup.c                         | 11 ++++++-----
> >  arch/powerpc/kvm/book3s_64_mmu_hv.c        |  4 ++--
> >  arch/powerpc/kvm/e500_mmu.c                |  2 +-
> >  arch/s390/kvm/interrupt.c                  |  2 +-
> >  arch/s390/mm/gup.c                         | 12 ++++++------
> >  arch/sh/mm/gup.c                           | 11 ++++++-----
> >  arch/sparc/mm/gup.c                        |  9 +++++----
> >  arch/x86/kvm/paging_tmpl.h                 |  2 +-
> >  arch/x86/kvm/svm.c                         |  2 +-
> >  drivers/fpga/dfl-afu-dma-region.c          |  2 +-
> >  drivers/gpu/drm/via/via_dmablit.c          |  3 ++-
> >  drivers/infiniband/hw/hfi1/user_pages.c    |  3 ++-
> >  drivers/misc/genwqe/card_utils.c           |  2 +-
> >  drivers/misc/vmw_vmci/vmci_host.c          |  2 +-
> >  drivers/misc/vmw_vmci/vmci_queue_pair.c    |  6 ++++--
> >  drivers/platform/goldfish/goldfish_pipe.c  |  3 ++-
> >  drivers/rapidio/devices/rio_mport_cdev.c   |  4 +++-
> >  drivers/sbus/char/oradax.c                 |  2 +-
> >  drivers/scsi/st.c                          |  3 ++-
> >  drivers/staging/gasket/gasket_page_table.c |  4 ++--
> >  drivers/tee/tee_shm.c                      |  2 +-
> >  drivers/vfio/vfio_iommu_spapr_tce.c        |  3 ++-
> >  drivers/vhost/vhost.c                      |  2 +-
> >  drivers/video/fbdev/pvr2fb.c               |  2 +-
> >  drivers/virt/fsl_hypervisor.c              |  2 +-
> >  drivers/xen/gntdev.c                       |  2 +-
> >  fs/orangefs/orangefs-bufmap.c              |  2 +-
> >  include/linux/mm.h                         |  4 ++--
> >  kernel/futex.c                             |  2 +-
> >  lib/iov_iter.c                             |  7 +++++--
> >  mm/gup.c                                   | 10 +++++-----
> >  mm/util.c                                  |  8 ++++----
> >  net/ceph/pagevec.c                         |  2 +-
> >  net/rds/info.c                             |  2 +-
> >  net/rds/rdma.c                             |  3 ++-
> >  35 files changed, 79 insertions(+), 63 deletions(-)
> 
> 
> >
> > diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
> > index 0d14e0d8eacf..4c2b4483683c 100644
> > --- a/arch/mips/mm/gup.c
> > +++ b/arch/mips/mm/gup.c
> > @@ -235,7 +235,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >   * get_user_pages_fast() - pin user pages in memory
> >   * @start:     starting user address
> >   * @nr_pages:  number of pages from start to pin
> > - * @write:     whether pages will be written to
> > + * @gup_flags: flags modifying pin behaviour
> >   * @pages:     array that receives pointers to the pages pinned.
> >   *             Should be at least nr_pages long.
> >   *
> > @@ -247,8 +247,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >   * requested. If nr_pages is 0 or negative, returns 0. If no pages
> >   * were pinned, returns -errno.
> >   */
> > -int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> > -                       struct page **pages)
> > +int get_user_pages_fast(unsigned long start, int nr_pages,
> > +                       unsigned int gup_flags, struct page **pages)
> 
> This looks a tad scary given all related thrash especially when it's
> only 1 user that wants to do get_user_page_fast_longterm, right?

Agreed but the discussion back in Feb agreed that it would be better to make
get_user_pages_fast() use flags rather than add another *_longterm call, and I
agree.

> Maybe
> something like the following. Note I explicitly moved the flags to the
> end so that someone half paying attention that calls
> __get_user_pages_fast will get a compile error if they specify the
> args in the same order.

I did this to remain consistent with the other public calls.  They put the
"return" pages parameter at the end.  For example get_user_pages() is defined
this way with pages and vmas at the end.

long get_user_pages(unsigned long start, unsigned long nr_pages,
                unsigned int gup_flags, struct page **pages,
                struct vm_area_struct **vmas)

I'm pretty sure I got all the callers.  Is this worth making the signature
"non-standard" WRT the other calls?

Ira

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 76ba638ceda8..c6c743bc2c68 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1505,8 +1505,15 @@ static inline long
> get_user_pages_longterm(unsigned long start,
>  }
>  #endif /* CONFIG_FS_DAX */
> 
> -int get_user_pages_fast(unsigned long start, int nr_pages, int write,
> -                       struct page **pages);
> +
> +int __get_user_pages_fast(unsigned long start, int nr_pages,
> +               struct page **pages, unsigned int gup_flags);
> +
> +static inline int get_user_pages_fast(unsigned long start, int
> nr_pages, int write,
> +                       struct page **pages)
> +{
> +       return __get_user_pages_fast(start, nr_pages, pages, write ?
> FOLL_WRITE);
> +}
> 
>  /* Container for pinned pfns / pages */
>  struct frame_vector {
> 
