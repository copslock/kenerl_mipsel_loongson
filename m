Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 19:35:07 +0100 (CET)
Received: from fg-out-1718.google.com ([72.14.220.157]:60935 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492078Ab0CLSfC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 19:35:02 +0100
Received: by fg-out-1718.google.com with SMTP id 16so445069fgg.6
        for <multiple recipients>; Fri, 12 Mar 2010 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4EQCixT/lHMIvQCQyw82WpBHcR91whUHkdAKx3Oyzso=;
        b=U8SuxvII3h1lnsN7mrobQIT18Xfo8imE/xFZU1Jz5diaHIBQwSkHnSQITyTDUOsdwD
         zIFv6W85SpCWHmWnKb0iNr9hqTpYB8gsGv/oBlkE7DWiAD3yfyIk3mOaSAws2s6ge4PK
         G47irrZkWcy1OA/y3l155Tv23zns6EVXtGXDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uuZ3XIUn2LSfnk6VIyEYkzJnmfRfUApdB0GzQVD2QUSLn8kxOJ6hhwLH1stBL+3UYT
         sLzy5Q4x3UPbYuEkBhatpmcMAoFuqVfBVEg9oIRmaisBXkT/LoCuHe6WYnvG2f4AQj0r
         1zUM5ahj2pS3SXiMGbWxDV7ciwvCevDTuBoO4=
Received: by 10.103.4.25 with SMTP id g25mr2195511mui.59.1268418899707;
        Fri, 12 Mar 2010 10:34:59 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-206.hsd1.ca.comcast.net [24.6.153.206])
        by mx.google.com with ESMTPS id 14sm6357941muo.32.2010.03.12.10.34.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 10:34:58 -0800 (PST)
Date:   Fri, 12 Mar 2010 10:34:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arch/mips/txx9/generic: init dynamic bin_attribute
 structures
Message-ID: <20100312183450.GC8736@core.coreip.homeip.net>
References: <1268377431-11671-1-git-send-email-w.sang@pengutronix.de>
 <1268377431-11671-2-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268377431-11671-2-git-send-email-w.sang@pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Mar 12, 2010 at 08:03:49AM +0100, Wolfram Sang wrote:
> Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requirement.
> Found with coccinelle, but fixed manually. Compile tested on X86 where
> possible.
> 

Regarding all 3 - it looks like these dynamically alocated attributes
could be converted to statically allocated ones. I'd recommend doing
that instead (in fact, I posted patch for the firmware_class couple days
ago).

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/mips/txx9/generic/setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index 7174d83..95184a0 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -956,6 +956,7 @@ void __init txx9_sramc_init(struct resource *r)
>  	if (!dev->base)
>  		goto exit;
>  	dev->dev.cls = &txx9_sramc_sysdev_class;
> +	sysfs_bin_attr_init(&dev->bindata_attr);
>  	dev->bindata_attr.attr.name = "bindata";
>  	dev->bindata_attr.attr.mode = S_IRUSR | S_IWUSR;
>  	dev->bindata_attr.read = txx9_sram_read;

-- 
Dmitry
