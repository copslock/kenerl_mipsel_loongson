Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jan 2016 11:22:08 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:37754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008473AbcAAKWGGA6Qe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Jan 2016 11:22:06 +0100
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (Postfix) with ESMTPS id B396B8F4F9;
        Fri,  1 Jan 2016 10:21:59 +0000 (UTC)
Received: from redhat.com (vpn1-7-173.ams2.redhat.com [10.36.7.173])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u01ALq8K016806;
        Fri, 1 Jan 2016 05:21:53 -0500
Date:   Fri, 1 Jan 2016 12:21:52 +0200
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH v2 30/32] virtio_ring: update weak barriers to use
 __smp_xxx
Message-ID: <20160101122115-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-31-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451572003-2440-31-git-send-email-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <mst@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mst@redhat.com
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

On Fri, Jan 01, 2016 at 11:39:40AM +0200, Michael S. Tsirkin wrote:
> virtio ring uses smp_wmb on SMP and wmb on !SMP,
> the reason for the later being that it might be
> talking to another kernel on the same SMP machine.
> 
> This is exactly what __smp_XXX barriers do,
> so switch to these instead of homegrown ifdef hacks.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

The subject and commit log should say
virt_xxx and not __smp_xxx - I fixed this up in
my tree.

> ---
>  include/linux/virtio_ring.h | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 67e06fe..f3fa55b 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -12,7 +12,7 @@
>   * anyone care?
>   *
>   * For virtio_pci on SMP, we don't need to order with respect to MMIO
> - * accesses through relaxed memory I/O windows, so smp_mb() et al are
> + * accesses through relaxed memory I/O windows, so virt_mb() et al are
>   * sufficient.
>   *
>   * For using virtio to talk to real devices (eg. other heterogeneous
> @@ -21,11 +21,10 @@
>   * actually quite cheap.
>   */
>  
> -#ifdef CONFIG_SMP
>  static inline void virtio_mb(bool weak_barriers)
>  {
>  	if (weak_barriers)
> -		smp_mb();
> +		virt_mb();
>  	else
>  		mb();
>  }
> @@ -33,7 +32,7 @@ static inline void virtio_mb(bool weak_barriers)
>  static inline void virtio_rmb(bool weak_barriers)
>  {
>  	if (weak_barriers)
> -		smp_rmb();
> +		virt_rmb();
>  	else
>  		rmb();
>  }
> @@ -41,26 +40,10 @@ static inline void virtio_rmb(bool weak_barriers)
>  static inline void virtio_wmb(bool weak_barriers)
>  {
>  	if (weak_barriers)
> -		smp_wmb();
> +		virt_wmb();
>  	else
>  		wmb();
>  }
> -#else
> -static inline void virtio_mb(bool weak_barriers)
> -{
> -	mb();
> -}
> -
> -static inline void virtio_rmb(bool weak_barriers)
> -{
> -	rmb();
> -}
> -
> -static inline void virtio_wmb(bool weak_barriers)
> -{
> -	wmb();
> -}
> -#endif
>  
>  struct virtio_device;
>  struct virtqueue;
> -- 
> MST
