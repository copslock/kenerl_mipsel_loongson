Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 13:06:25 +0100 (CET)
Received: from smtp02.citrix.com ([66.165.176.63]:35554 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009352AbcADMGWFpfVO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 13:06:22 +0100
X-IronPort-AV: E=Sophos;i="5.20,520,1444694400"; 
   d="scan'208";a="328833949"
Date:   Mon, 4 Jan 2016 12:05:57 +0000
From:   Stefano Stabellini <stefano.stabellini@eu.citrix.com>
X-X-Sender: sstabellini@kaball.uk.xensource.com
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>
Subject: Re: [PATCH v2 34/34] xen/io: use virt_xxx barriers
In-Reply-To: <1451572003-2440-35-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.02.1601041201440.19710@kaball.uk.xensource.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-35-git-send-email-mst@redhat.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-DLP:  MIA2
Return-Path: <prvs=80452ccb6=Stefano.Stabellini@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefano.stabellini@eu.citrix.com
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

On Thu, 31 Dec 2015, Michael S. Tsirkin wrote:
> include/xen/interface/io/ring.h uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  include/xen/interface/io/ring.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
> index 7dc685b..21f4fbd 100644
> --- a/include/xen/interface/io/ring.h
> +++ b/include/xen/interface/io/ring.h
> @@ -208,12 +208,12 @@ struct __name##_back_ring {						\
>  
>  
>  #define RING_PUSH_REQUESTS(_r) do {					\
> -    wmb(); /* back sees requests /before/ updated producer index */	\
> +    virt_wmb(); /* back sees requests /before/ updated producer index */	\
>      (_r)->sring->req_prod = (_r)->req_prod_pvt;				\
>  } while (0)
>  
>  #define RING_PUSH_RESPONSES(_r) do {					\
> -    wmb(); /* front sees responses /before/ updated producer index */	\
> +    virt_wmb(); /* front sees responses /before/ updated producer index */	\
>      (_r)->sring->rsp_prod = (_r)->rsp_prod_pvt;				\
>  } while (0)
>  
> @@ -250,9 +250,9 @@ struct __name##_back_ring {						\
>  #define RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(_r, _notify) do {		\
>      RING_IDX __old = (_r)->sring->req_prod;				\
>      RING_IDX __new = (_r)->req_prod_pvt;				\
> -    wmb(); /* back sees requests /before/ updated producer index */	\
> +    virt_wmb(); /* back sees requests /before/ updated producer index */	\
>      (_r)->sring->req_prod = __new;					\
> -    mb(); /* back sees new requests /before/ we check req_event */	\
> +    virt_mb(); /* back sees new requests /before/ we check req_event */	\
>      (_notify) = ((RING_IDX)(__new - (_r)->sring->req_event) <		\
>  		 (RING_IDX)(__new - __old));				\
>  } while (0)
> @@ -260,9 +260,9 @@ struct __name##_back_ring {						\
>  #define RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(_r, _notify) do {		\
>      RING_IDX __old = (_r)->sring->rsp_prod;				\
>      RING_IDX __new = (_r)->rsp_prod_pvt;				\
> -    wmb(); /* front sees responses /before/ updated producer index */	\
> +    virt_wmb(); /* front sees responses /before/ updated producer index */	\
>      (_r)->sring->rsp_prod = __new;					\
> -    mb(); /* front sees new responses /before/ we check rsp_event */	\
> +    virt_mb(); /* front sees new responses /before/ we check rsp_event */	\
>      (_notify) = ((RING_IDX)(__new - (_r)->sring->rsp_event) <		\
>  		 (RING_IDX)(__new - __old));				\
>  } while (0)
> @@ -271,7 +271,7 @@ struct __name##_back_ring {						\
>      (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
>      if (_work_to_do) break;						\
>      (_r)->sring->req_event = (_r)->req_cons + 1;			\
> -    mb();								\
> +    virt_mb();								\
>      (_work_to_do) = RING_HAS_UNCONSUMED_REQUESTS(_r);			\
>  } while (0)
>  
> @@ -279,7 +279,7 @@ struct __name##_back_ring {						\
>      (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
>      if (_work_to_do) break;						\
>      (_r)->sring->rsp_event = (_r)->rsp_cons + 1;			\
> -    mb();								\
> +    virt_mb();								\
>      (_work_to_do) = RING_HAS_UNCONSUMED_RESPONSES(_r);			\
>  } while (0)
>  
> -- 
> MST
> 
