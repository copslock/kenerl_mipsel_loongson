Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2005 23:03:29 +0000 (GMT)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:17440
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S3466982AbVKNXDM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Nov 2005 23:03:12 +0000
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Nov 2005 15:05:06 -0800
Message-ID: <43791822.3050600@avtrex.com>
Date:	Mon, 14 Nov 2005 15:05:06 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build in ide-dma.c
References: <17273.5861.51238.726136@dl2.hq2.avtrex.com>
In-Reply-To: <17273.5861.51238.726136@dl2.hq2.avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2005 23:05:06.0260 (UTC) FILETIME=[DA462940:01C5E96F]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> When in_drive_list was renamed to ide_in_drive_list, several
> occurrences were missed.  This patch allows me to build.
> 
> David Daney
> 

I guess I should probably add:

Signed-off-by: David Daney <ddaney@avtrex.com>

> 
> diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
> --- a/drivers/ide/ide-dma.c
> +++ b/drivers/ide/ide-dma.c
> @@ -665,7 +665,7 @@ int __ide_dma_bad_drive (ide_drive_t *dr
>  {
>  	struct hd_driveid *id = drive->id;
>  
> -	int blacklist = in_drive_list(id, drive_blacklist);
> +	int blacklist = ide_in_drive_list(id, drive_blacklist);
>  	if (blacklist) {
>  		printk(KERN_WARNING "%s: Disabling (U)DMA for %s (blacklisted)\n",
>  				    drive->name, id->model);
> @@ -679,7 +679,7 @@ EXPORT_SYMBOL(__ide_dma_bad_drive);
>  int __ide_dma_good_drive (ide_drive_t *drive)
>  {
>  	struct hd_driveid *id = drive->id;
> -	return in_drive_list(id, drive_whitelist);
> +	return ide_in_drive_list(id, drive_whitelist);
>  }
>  
>  EXPORT_SYMBOL(__ide_dma_good_drive);
> 
