Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 22:59:55 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59336 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013091AbbBIV7xUd45X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 22:59:53 +0100
Received: by mail-pa0-f48.google.com with SMTP id eu11so14585954pac.7
        for <linux-mips@linux-mips.org>; Mon, 09 Feb 2015 13:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=UEIlT8/i3pddIxhjV1V6FJT9KdIG7aTxYmEqB3/fSRE=;
        b=sQUZNjiXKlWkVsv9DMAE/NcVkrQflHryjUgJiscLyavi7vBRklVMM+IV7xhZNyF6iJ
         sA0mpqrIpFI8rV7o6iiq6yfCAZn+gxu/kpKLcVX9IuygfckXrF8NMLYWaduA58Cce+sm
         UAejQjrGOxwNCcpNIuYBTyln//hnDrruoOgF86zPFUmapHyw2lToZKFrNoHYCy/ozPHa
         wBI7wMRMf9r6yWRzqb+4HbV5BLMA8KGeVi1NDQkOxa+JfvHA55Y8jgxWzIL7VQAiR4i0
         ClQa2pdv1UNs++iqLsqitCRONc5jUSvnMUTGEcth3MIa+cZ79dZcZRS1ywpiM45ANmtX
         RSgg==
X-Received: by 10.68.69.40 with SMTP id b8mr15467576pbu.88.1423519187283;
        Mon, 09 Feb 2015 13:59:47 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id fx1sm2932964pbb.42.2015.02.09.13.59.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Feb 2015 13:59:46 -0800 (PST)
Message-ID: <54D92DCE.8090100@gmail.com>
Date:   Mon, 09 Feb 2015 13:59:42 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, sre@kernel.org,
        dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de,
        linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
CC:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 8/9] bus: brcmstb_gisb: Honor the "big-endian" and "native-endian"
 DT properties
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com> <1416962994-27095-9-git-send-email-cernekee@gmail.com>
In-Reply-To: <1416962994-27095-9-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 25/11/14 16:49, Kevin Cernekee wrote:
> On chips strapped for BE, we'll need to use ioread32be/iowrite32be instead of
> ioread32/iowrite32.

Has of_device_is_big_endian() been merged in a tree now, I am not seeing
it in Linus' tree, but have not look at Grant's tree yet. Thanks

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/bus/brcmstb_gisb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
> index 172908d..969b992 100644
> --- a/drivers/bus/brcmstb_gisb.c
> +++ b/drivers/bus/brcmstb_gisb.c
> @@ -90,6 +90,7 @@ static const int gisb_offsets_bcm7445[] = {
>  struct brcmstb_gisb_arb_device {
>  	void __iomem	*base;
>  	const int	*gisb_offsets;
> +	bool		big_endian;
>  	struct mutex	lock;
>  	struct list_head next;
>  	u32 valid_mask;
> @@ -106,7 +107,10 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
>  	if (offset == -1)
>  		return 1;
>  
> -	return ioread32(gdev->base + offset);
> +	if (gdev->big_endian)
> +		return ioread32be(gdev->base + offset);
> +	else
> +		return ioread32(gdev->base + offset);
>  }
>  
>  static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
> @@ -115,7 +119,11 @@ static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
>  
>  	if (offset == -1)
>  		return;
> -	iowrite32(val, gdev->base + reg);
> +
> +	if (gdev->big_endian)
> +		iowrite32be(val, gdev->base + reg);
> +	else
> +		iowrite32(val, gdev->base + reg);
>  }
>  
>  static ssize_t gisb_arb_get_timeout(struct device *dev,
> @@ -300,6 +308,7 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  	gdev->gisb_offsets = of_id->data;
> +	gdev->big_endian = of_device_is_big_endian(dn);
>  
>  	err = devm_request_irq(&pdev->dev, timeout_irq,
>  				brcmstb_gisb_timeout_handler, 0, pdev->name,
> 


-- 
Florian
