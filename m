Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 19:29:08 +0100 (CET)
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36163 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007549AbbLBS3Gz8O07 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 19:29:06 +0100
Received: by lfs39 with SMTP id 39so58612439lfs.3
        for <linux-mips@linux-mips.org>; Wed, 02 Dec 2015 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xmhMbH7Jq2YJ99Bhvuk/VTviy4vRJpCqoR/bVjyCHS8=;
        b=dr+sqYXCgBfFc+b/m/nyQikneVtps8XnIbc+Kx/pVGeBHhcGxRjFdXlwVYJ/wqiGit
         o6JOWNJjNH7yO+QlAx63kEtmVIxZKzZhEBrIcbKi6/Tnn/A4xud2yibKC99egb2iWmCz
         qZsICmggkoj3ulkNJy8rmxEjK23nHrLXpoOkaNkI/b7RaCZn09nJyXI+hQ0JVUrhfRmi
         YWr9sxCVPgIL6697PYJt2HPltuiAoy2V25M8b+Q9zRRGi6TlwRqpAbFiVnAWYBgKuYgO
         zjHSG6NIPzQGajyxH974XbSZ1Gj1Wvpp8w/ZXa79D9AqSDI5tt6UjOheNhCAiivHHeZ8
         EUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xmhMbH7Jq2YJ99Bhvuk/VTviy4vRJpCqoR/bVjyCHS8=;
        b=c69xOIwCSsxL4CAaG7ccgvP2gL6PSO0tLomjPkafC4bji4VnCJ8h1ABdfJVKEMD0go
         8EBn+TuY0aI7vPp0k68dL0PyaDr8dsRHXkUuwwWgVDuBHnBTx0kLBj5QMTwwioSU5a/l
         nfq9zfoWWOHXgCxy3ID2U9d0Aq77gz4qPEAQ+zwMNNjm1T35XCbXbyJIqxFQHZ+qvapQ
         3CxwHiIKqyr2bwCFgn8u1blAnSec7Kz6TFaX6+L6U4m1RTJEo/c2SVv1SHnBlTIe8tDd
         wIqX8JJFkO7bafnLRTGC4bHVsiBizbWM9AHEK0SlWMFMdd5XElfrjZbuJkwBC4Ti2z4V
         av8A==
X-Gm-Message-State: ALoCoQnUqk530pgoSK4pzD6aJoIn8GCU2QFZeAGLwI9ocr20Qu5xFan9v+6Sc9ORH49hnrSSILqs
X-Received: by 10.112.99.4 with SMTP id em4mr3749387lbb.87.1449080940069;
        Wed, 02 Dec 2015 10:29:00 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.183])
        by smtp.gmail.com with ESMTPSA id mp1sm666131lbb.43.2015.12.02.10.28.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 10:28:58 -0800 (PST)
Subject: Re: [PATCH v3 14/19] irqchip/mips-gic: Use gic_vpes instead of
 NR_CPUS
To:     Qais Yousef <qais.yousef@imgtec.com>, linux-kernel@vger.kernel.org
References: <1449058920-21011-1-git-send-email-qais.yousef@imgtec.com>
 <1449058920-21011-15-git-send-email-qais.yousef@imgtec.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <565F3869.4020603@cogentembedded.com>
Date:   Wed, 2 Dec 2015 21:28:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1449058920-21011-15-git-send-email-qais.yousef@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12/02/2015 03:21 PM, Qais Yousef wrote:

> NR_CPUS is set by Kconfig and could be much higher than what actually is in the
> system.
>
> gic_vpes should be a true representitives of the number of cpus in the system,
> so use it instead.
>
> Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
> ---
>   drivers/irqchip/irq-mips-gic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 41ccc84c68ba..c24feb739bb3 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
[...]
> @@ -1084,7 +1084,7 @@ static void __init __gic_init(unsigned long gic_base_addr,
>   	gic_ipi_domain->bus_token = DOMAIN_BUS_IPI;
>
>   	/* Make the last 2 * NR_CPUS available for IPIs */

    Looks like you forgot to also change this comment...

> -	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * NR_CPUS, 2 * NR_CPUS);
> +	bitmap_set(ipi_resrv, gic_shared_intrs - 2 * gic_vpes, 2 * gic_vpes);
>
>   	gic_basic_init();
>

MBR, Sergei
