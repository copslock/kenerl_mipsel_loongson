Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jul 2009 17:38:12 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:45446 "EHLO
	mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492461AbZGCPiE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 3 Jul 2009 17:38:04 +0200
Received: by pzk3 with SMTP id 3so2280664pzk.22
        for <multiple recipients>; Fri, 03 Jul 2009 08:31:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=QQ1x5vDF/dcdQbAW8QxH3eho7gvFJ/j3ZoqZAUmzov8=;
        b=pOQxssZ6Chc5mXRACD52jOsc62J6phIkUS/72rN40KCN+juxPNNAhzIg1DGO+FMs7p
         9L0i7xjaHnHJOnJPB/vOFMTkZC8mzqQIbA8kqbk6WcDk3PLz5l4avYiAFrvXNWcaW/2k
         83HvCubG7dp9s2W/wia3fo6H2cSeVLDbbMpxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=O8woN5XdJfuG7TqNKL8prIEeXQ+jARDQLzIaSC2+WeVfMMSe69sjllPlBYdwg6nThj
         MrFclc5LEBBmETMfcQtVwxP3AThKL4XTRHanSKGQSKX1jASj6tJJQR6UhzlTMsWymLxa
         vPPNtZdoyZVo+o2TdqBYTmQltTs3iRt6drPTo=
Received: by 10.142.148.9 with SMTP id v9mr531120wfd.148.1246635115121;
        Fri, 03 Jul 2009 08:31:55 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm11259947wfg.21.2009.07.03.08.31.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Jul 2009 08:31:53 -0700 (PDT)
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
In-Reply-To: <200907031508.47891.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <200907021813.57322.bzolnier@gmail.com> <1246593505.27828.187.camel@falcon>
	 <200907031508.47891.bzolnier@gmail.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Fri, 03 Jul 2009 23:31:36 +0800
Message-Id: <1246635096.16890.6.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

> OK, I see another gotcha added by recent changes, we need to explicitly
> initialize rq_in_flight variables now.  Revised patch below..
> 

Sorry, STD also not work. if apply this patch, the same problem as not
apply it, it stopped at:

...
PM: Crete hibernation image:
PM: Need to copy ... pages
PM: Hibernation image created ...

I think it's better to revert this commit:
 a1317f714af7aed60ddc182d0122477cbe36ee9b ("ide: improve handling of
Power Management requests")

Regards,
Wu Zhangjin

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: make resume work again (for real)
> 
> It turns out that commit a1317f714af7aed60ddc182d0122477cbe36ee9b
> ("ide: improve handling of Power Management requests") needs to take
> into the account a new code added by the recent block layer changes
> in commit 8f6205cd572fece673da0255d74843680f67f879 ("ide: dequeue
> in-flight request") and prevent clearing of hwif->rq if the device
> is blocked.
> 
> Thanks to Etienne, Wu and Jeff for help in fixing the issue.
> 
> Reported-and-tested-by: Jeff Chua <jeff.chua.linux@gmail.com>
> Reported-and-tested-by: Etienne Basset <etienne.basset@numericable.fr>
> Reported-by: Wu Zhangjin <wuzhangjin@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Added patch description, no other changes.
> 
>  drivers/ide/ide-io.c |   19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> Index: b/drivers/ide/ide-io.c
> ===================================================================
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -532,7 +532,8 @@ repeat:
>  
>  		if (startstop == ide_stopped) {
>  			rq = hwif->rq;
> -			hwif->rq = NULL;
> +			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0)
> +				hwif->rq = NULL;
>  			goto repeat;
>  		}
>  	} else
> @@ -616,7 +617,7 @@ void ide_timer_expiry (unsigned long dat
>  	unsigned long	flags;
>  	int		wait = -1;
>  	int		plug_device = 0;
> -	struct request	*uninitialized_var(rq_in_flight);
> +	struct request	*rq_in_flight = NULL;
>  
>  	spin_lock_irqsave(&hwif->lock, flags);
>  
> @@ -679,8 +680,10 @@ void ide_timer_expiry (unsigned long dat
>  		spin_lock_irq(&hwif->lock);
>  		enable_irq(hwif->irq);
>  		if (startstop == ide_stopped && hwif->polling == 0) {
> -			rq_in_flight = hwif->rq;
> -			hwif->rq = NULL;
> +			if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
> +				rq_in_flight = hwif->rq;
> +				hwif->rq = NULL;
> +			}
>  			ide_unlock_port(hwif);
>  			plug_device = 1;
>  		}
> @@ -775,7 +778,7 @@ irqreturn_t ide_intr (int irq, void *dev
>  	ide_startstop_t startstop;
>  	irqreturn_t irq_ret = IRQ_NONE;
>  	int plug_device = 0;
> -	struct request *uninitialized_var(rq_in_flight);
> +	struct request *rq_in_flight = NULL;
>  
>  	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
>  		if (hwif != host->cur_port)
> @@ -856,8 +859,10 @@ irqreturn_t ide_intr (int irq, void *dev
>  	 */
>  	if (startstop == ide_stopped && hwif->polling == 0) {
>  		BUG_ON(hwif->handler);
> -		rq_in_flight = hwif->rq;
> -		hwif->rq = NULL;
> +		if ((drive->dev_flags & IDE_DFLAG_BLOCKED) == 0) {
> +			rq_in_flight = hwif->rq;
> +			hwif->rq = NULL;
> +		}
>  		ide_unlock_port(hwif);
>  		plug_device = 1;
>  	}
