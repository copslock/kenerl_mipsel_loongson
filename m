Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:10:40 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:33881 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007189AbbCENKhjrNXr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:10:37 +0100
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t25D9P2u014644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 5 Mar 2015 13:09:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t25D9P5g005991
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 5 Mar 2015 13:09:25 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t25D9OJT022581;
        Thu, 5 Mar 2015 13:09:24 GMT
Received: from mwanda (/154.0.139.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2015 05:09:18 -0800
Date:   Thu, 5 Mar 2015 16:08:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Valentin Rothberg <valentinrothberg@gmail.com>
Cc:     akpm@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Ewan Milne <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rajendra Nayak <rnayak@ti.com>,
        Sricharan R <r.sricharan@ti.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Felipe Balbi <balbi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, iss_storagedev@hp.com,
        linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
Message-ID: <20150305130850.GK5437@mwanda>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Thu, Mar 05, 2015 at 01:59:39PM +0100, Valentin Rothberg wrote:
> diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
> index 289ad3ac3e80..7f9f9c827c1d 100644
> --- a/drivers/mtd/nand/hisi504_nand.c
> +++ b/drivers/mtd/nand/hisi504_nand.c
> @@ -758,8 +758,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
>  
>  	hisi_nfc_host_init(host);
>  
> -	ret = devm_request_irq(dev, irq, hinfc_irq_handle, IRQF_DISABLED,
> -				"nandc", host);
> +	ret = devm_request_irq(dev, irq, hinfc_irq_handle, "nandc", host);

I think this breaks the build.

>  	if (ret) {
>  		dev_err(dev, "failed to request IRQ\n");
>  		goto err_res;

regards,
dan carpenter
