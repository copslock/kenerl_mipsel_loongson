Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 13:04:06 +0100 (CET)
Received: from smtp.citrix.com ([66.165.176.89]:38067 "EHLO SMTP.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009352AbcADMEE1DNnO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 13:04:04 +0100
X-IronPort-AV: E=Sophos;i="5.20,520,1444694400"; 
   d="scan'208";a="322704095"
Date:   Mon, 4 Jan 2016 12:03:11 +0000
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
Subject: Re: [PATCH v2 33/34] xenbus: use virt_xxx barriers
In-Reply-To: <1451572003-2440-34-git-send-email-mst@redhat.com>
Message-ID: <alpine.DEB.2.02.1601041201120.19710@kaball.uk.xensource.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-34-git-send-email-mst@redhat.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-DLP:  MIA2
Return-Path: <prvs=80452ccb6=Stefano.Stabellini@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50841
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
> drivers/xen/xenbus/xenbus_comms.c uses
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

Are you also going to take care of

drivers/xen/grant-table.c
drivers/xen/evtchn.c
drivers/xen/events/events_fifo.c
drivers/xen/xen-scsiback.c
drivers/xen/tmem.c
drivers/xen/xen-pciback/pci_stub.c
drivers/xen/xen-pciback/pciback_ops.c

?


>  drivers/xen/xenbus/xenbus_comms.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index fdb0f33..ecdecce 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -123,14 +123,14 @@ int xb_write(const void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must write data /after/ reading the consumer index. */
> -		mb();
> +		virt_mb();
>  
>  		memcpy(dst, data, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see new producer until data is there. */
> -		wmb();
> +		virt_wmb();
>  		intf->req_prod += avail;
>  
>  		/* Implies mb(): other side will see the updated producer. */
> @@ -180,14 +180,14 @@ int xb_read(void *data, unsigned len)
>  			avail = len;
>  
>  		/* Must read data /after/ reading the producer index. */
> -		rmb();
> +		virt_rmb();
>  
>  		memcpy(data, src, avail);
>  		data += avail;
>  		len -= avail;
>  
>  		/* Other side must not see free space until we've copied out */
> -		mb();
> +		virt_mb();
>  		intf->rsp_cons += avail;
>  
>  		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
> -- 
> MST
> 
