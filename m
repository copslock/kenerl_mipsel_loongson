Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 09:34:47 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52967 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcJSHehLSkKB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 09:34:37 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7419ACBD;
        Wed, 19 Oct 2016 07:34:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B88ED1E09E1; Wed, 19 Oct 2016 09:34:35 +0200 (CEST)
Date:   Wed, 19 Oct 2016 09:34:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, linux-fbdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mips@linux-mips.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 05/10] mm: replace get_vaddr_frames() write/force
 parameters with gup_flags
Message-ID: <20161019073435.GM29967@quack2.suse.cz>
References: <20161013002020.3062-1-lstoakes@gmail.com>
 <20161013002020.3062-6-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161013002020.3062-6-lstoakes@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <jack@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack@suse.cz
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

On Thu 13-10-16 01:20:15, Lorenzo Stoakes wrote:
> This patch removes the write and force parameters from get_vaddr_frames() and
> replaces them with a gup_flags parameter to make the use of FOLL_FORCE explicit
> in callers as use of this flag can result in surprising behaviour (and hence
> bugs) within the mm subsystem.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c    |  3 ++-
>  drivers/media/platform/omap/omap_vout.c    |  2 +-
>  drivers/media/v4l2-core/videobuf2-memops.c |  6 +++++-
>  include/linux/mm.h                         |  2 +-
>  mm/frame_vector.c                          | 13 ++-----------
>  5 files changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index aa92dec..fbd13fa 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -488,7 +488,8 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct drm_device *drm_dev,
>  		goto err_free;
>  	}
>  
> -	ret = get_vaddr_frames(start, npages, true, true, g2d_userptr->vec);
> +	ret = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
> +		g2d_userptr->vec);
>  	if (ret != npages) {
>  		DRM_ERROR("failed to get user pages from userptr.\n");
>  		if (ret < 0)
> diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
> index e668dde..a31b95c 100644
> --- a/drivers/media/platform/omap/omap_vout.c
> +++ b/drivers/media/platform/omap/omap_vout.c
> @@ -214,7 +214,7 @@ static int omap_vout_get_userptr(struct videobuf_buffer *vb, u32 virtp,
>  	if (!vec)
>  		return -ENOMEM;
>  
> -	ret = get_vaddr_frames(virtp, 1, true, false, vec);
> +	ret = get_vaddr_frames(virtp, 1, FOLL_WRITE, vec);
>  	if (ret != 1) {
>  		frame_vector_destroy(vec);
>  		return -EINVAL;
> diff --git a/drivers/media/v4l2-core/videobuf2-memops.c b/drivers/media/v4l2-core/videobuf2-memops.c
> index 3c3b517..1cd322e 100644
> --- a/drivers/media/v4l2-core/videobuf2-memops.c
> +++ b/drivers/media/v4l2-core/videobuf2-memops.c
> @@ -42,6 +42,10 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
>  	unsigned long first, last;
>  	unsigned long nr;
>  	struct frame_vector *vec;
> +	unsigned int flags = FOLL_FORCE;
> +
> +	if (write)
> +		flags |= FOLL_WRITE;
>  
>  	first = start >> PAGE_SHIFT;
>  	last = (start + length - 1) >> PAGE_SHIFT;
> @@ -49,7 +53,7 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
>  	vec = frame_vector_create(nr);
>  	if (!vec)
>  		return ERR_PTR(-ENOMEM);
> -	ret = get_vaddr_frames(start & PAGE_MASK, nr, write, true, vec);
> +	ret = get_vaddr_frames(start & PAGE_MASK, nr, flags, vec);
>  	if (ret < 0)
>  		goto out_destroy;
>  	/* We accept only complete set of PFNs */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ab538..5ff084f6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1305,7 +1305,7 @@ struct frame_vector {
>  struct frame_vector *frame_vector_create(unsigned int nr_frames);
>  void frame_vector_destroy(struct frame_vector *vec);
>  int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
> -		     bool write, bool force, struct frame_vector *vec);
> +		     unsigned int gup_flags, struct frame_vector *vec);
>  void put_vaddr_frames(struct frame_vector *vec);
>  int frame_vector_to_pages(struct frame_vector *vec);
>  void frame_vector_to_pfns(struct frame_vector *vec);
> diff --git a/mm/frame_vector.c b/mm/frame_vector.c
> index 81b6749..db77dcb 100644
> --- a/mm/frame_vector.c
> +++ b/mm/frame_vector.c
> @@ -11,10 +11,7 @@
>   * get_vaddr_frames() - map virtual addresses to pfns
>   * @start:	starting user address
>   * @nr_frames:	number of pages / pfns from start to map
> - * @write:	whether pages will be written to by the caller
> - * @force:	whether to force write access even if user mapping is
> - *		readonly. See description of the same argument of
> -		get_user_pages().
> + * @gup_flags:	flags modifying lookup behaviour
>   * @vec:	structure which receives pages / pfns of the addresses mapped.
>   *		It should have space for at least nr_frames entries.
>   *
> @@ -34,23 +31,17 @@
>   * This function takes care of grabbing mmap_sem as necessary.
>   */
>  int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
> -		     bool write, bool force, struct frame_vector *vec)
> +		     unsigned int gup_flags, struct frame_vector *vec)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	int ret = 0;
>  	int err;
>  	int locked;
> -	unsigned int gup_flags = 0;
>  
>  	if (nr_frames == 0)
>  		return 0;
>  
> -	if (write)
> -		gup_flags |= FOLL_WRITE;
> -	if (force)
> -		gup_flags |= FOLL_FORCE;
> -
>  	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
>  		nr_frames = vec->nr_allocated;
>  
> -- 
> 2.10.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
