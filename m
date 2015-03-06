Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 19:46:23 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34097 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008279AbbCFSqUW2PJb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 19:46:20 +0100
Received: by paceu11 with SMTP id eu11so39636869pac.1;
        Fri, 06 Mar 2015 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RPdCuUEGxovoZeaXsM2fUYRYgaiMvwApyD4J6KL9tOA=;
        b=sOvKh9D6UjeInl0IgDit0dIyIU1rHwGiqzz3oRJhCD/YHp7LRQve3L4hKU38gmXJfJ
         m1vNB9sXEx3ZmQOYhAei+FTO2nveyqBFjHsG8B+hkHG4C4WDg/LUN+zODUwEQ8QsC48e
         bCZPamlIxQMsjNuJNm0Ro6i48QUhW0/142vqASftXZO6yWuxPUe7BRdIkICXJQamv2ak
         Z8J3QO+0hb7wu6k45/JAjVtIGznhSyzD+acZ8fDg0t4IVpGJMr4zB/UhMGp5h9HDskbB
         qpyC+bzLtbic+8DwRq7jHuQcrHTXkmsUMbZbI4HKJhoeygEZs+cT1BalNT0cHdGiVmt0
         CYaA==
X-Received: by 10.68.197.133 with SMTP id iu5mr28052872pbc.131.1425667575003;
        Fri, 06 Mar 2015 10:46:15 -0800 (PST)
Received: from ld-irv-0074 (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ev2sm10125719pbb.69.2015.03.06.10.46.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Mar 2015 10:46:14 -0800 (PST)
Date:   Fri, 6 Mar 2015 10:46:05 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
Cc:     akpm@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rajendra Nayak <rnayak@ti.com>, Afzal Mohammed <afzal@ti.com>,
        Keerthy <j-keerthy@ti.com>, Sricharan R <r.sricharan@ti.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Felipe Balbi <balbi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Eyal Perry <eyalpe@mellanox.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, iss_storagedev@hp.com,
        linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Remove deprecated IRQF_DISABLED flag entirely
Message-ID: <20150306184605.GQ18140@ld-irv-0074>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
 <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Thu, Mar 05, 2015 at 03:23:08PM +0100, Valentin Rothberg wrote:
> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
> core code").
> 
> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
> interrupts disabled") running IRQ handlers with interrupts enabled can
> cause stack overflows when the interrupt line of the issuing device is
> still active.
> 
> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
> in older versions of Linux) and removes the definition and all remaining
> usages of this flag.
> 
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> ---
> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
> as IRQF_DISABLED is gone now; the usage in older kernel versions
> (including the old SA_INTERRUPT flag) should be discouraged.  The
> trouble of using IRQF_SHARED is a general problem and not specific to
> any driver.
> 
> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
> it has already been removed in linux-next by commit b0e1ee8e1405
> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
> 
> All remaining references are changelogs that I suggest to keep.
> 
> Changelog
> 
> v2: Correct previous change to drivers/mtd/nand/hisi504_nand.c that
> broke compilation.  Reported by Dan Carpenter.
> ---
>  Documentation/scsi/ncr53c8xx.txt     | 25 -------------------------
>  Documentation/scsi/tmscsim.txt       |  4 ----
>  arch/mips/loongson/loongson-3/hpet.c |  2 +-
>  drivers/block/cpqarray.c             |  4 ++--
>  drivers/bus/omap_l3_noc.c            |  4 ++--
>  drivers/bus/omap_l3_smx.c            | 10 ++++------
>  drivers/mtd/nand/hisi504_nand.c      |  3 +--
>  drivers/usb/isp1760/isp1760-core.c   |  3 +--
>  drivers/usb/isp1760/isp1760-udc.c    |  4 ++--
>  include/linux/interrupt.h            |  3 ---
>  10 files changed, 13 insertions(+), 49 deletions(-)
> 

For this piece:

> diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
> index 289ad3ac3e80..8dcc7b8fee40 100644
> --- a/drivers/mtd/nand/hisi504_nand.c
> +++ b/drivers/mtd/nand/hisi504_nand.c
> @@ -758,8 +758,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
>  
>  	hisi_nfc_host_init(host);
>  
> -	ret = devm_request_irq(dev, irq, hinfc_irq_handle, IRQF_DISABLED,
> -				"nandc", host);
> +	ret = devm_request_irq(dev, irq, hinfc_irq_handle, 0x0, "nandc", host);
>  	if (ret) {
>  		dev_err(dev, "failed to request IRQ\n");
>  		goto err_res;

Acked-by: Brian Norris <computersforpeace@gmail.com>

Sorry for the oversight in review, and thanks for the fixup.

Brian
