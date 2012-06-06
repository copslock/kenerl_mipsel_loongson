Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2012 13:54:44 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55874 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab2FFLyh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2012 13:54:37 +0200
Received: by lbbgg6 with SMTP id gg6so5611777lbb.36
        for <linux-mips@linux-mips.org>; Wed, 06 Jun 2012 04:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=9gwX2NkMYw24RdHTGsTPs/SkkfiONXisE8ioSbU1rMo=;
        b=ENQgS2ldI/Hbi88EqOQ/s6s6VHBVSXuusQhd3WmmD2SJgvWLXCtNo1OZbkEUTlwo83
         4nE7LSR/cY34RKF0409lq7D7tUmiEjD6BQRm/5kKCoct3/ho35tre7tT6aXdmodiNmWR
         QWYI443mHQrghfifTyhdMRXPruvqA4a7zi2dn5GCvn4ZtfHjJlhz0v6tVwOtGyKG4Db6
         oIpjsZPiU2zdDRV6ybsJmTbKVtyi0VmHHEt1QFSq/mDdSFpqcnL4UPWlp+qV3cEVJ/eg
         l68rGHAuNTNpNdY0HffhRdR++zuZOJp9visxFSgcme/+OoDu3ISecMP19s5Yb4A2IcC0
         Y0zA==
Received: by 10.112.36.130 with SMTP id q2mr9628303lbj.44.1338983672336;
        Wed, 06 Jun 2012 04:54:32 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-181.pppoe.mtu-net.ru. [91.79.86.181])
        by mx.google.com with ESMTPS id s3sm984939lbk.11.2012.06.06.04.54.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jun 2012 04:54:31 -0700 (PDT)
Message-ID: <4FCF44D9.1020407@mvista.com>
Date:   Wed, 06 Jun 2012 15:54:01 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 17/35] MIPS: Lasat: Cleanup files effected by firmware
 changes.
References: <1338931179-9611-1-git-send-email-sjhill@mips.com> <1338931179-9611-18-git-send-email-sjhill@mips.com>
In-Reply-To: <1338931179-9611-18-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQl+u/oeor1+4oqkfzSwp1VA98dOMnEm21A/pToFIWG2ZeJ27OpNsrJPNAQEQbVzor09Vln3
X-archive-position: 33568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 06-06-2012 1:19, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Make headers consistent across the files

    It's the case where you don't do it (forgot? :-).

> and make changes based on running the checkpatch script.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
> ---
>   arch/mips/lasat/prom.c |   13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/lasat/prom.c b/arch/mips/lasat/prom.c
> index 8bd3994..0091351 100644
> --- a/arch/mips/lasat/prom.c
> +++ b/arch/mips/lasat/prom.c
> @@ -2,19 +2,18 @@
>    * PROM interface routines.
>    */
>   #include<linux/types.h>
> -#include<linux/init.h>

    No, it should be left intact because '__init' is used.

>   #include<linux/string.h>
>   #include<linux/ctype.h>
> -#include<linux/kernel.h>

    Doesn't the code use printk()?

> @@ -58,7 +57,7 @@ static void setup_prom_vectors(void)
>   		__prom_putc = (void *)PROM_PUTC_ADDR;
>   		prom_monitor = (void *)PROM_MONITOR_ADDR;
>   	}
> -	printk(KERN_DEBUG "prom vectors set up\n");
> +	pr_debug("prom vectors set up\n");

    Changes behavior: now you need to #define DEBUG at the start of file for 
anything to be printed here.

WBR, Sergei
