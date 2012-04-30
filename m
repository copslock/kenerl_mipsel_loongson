Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 01:01:00 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43265 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903720Ab2D3XAx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 01:00:53 +0200
Received: by lbbgg6 with SMTP id gg6so939417lbb.36
        for <linux-mips@linux-mips.org>; Mon, 30 Apr 2012 16:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=EYs4+oqXLZaXmVvuOBoq6n7JvXBjwMyaBHuZlj3h3Y4=;
        b=Og0bsfq4MMKrGcBzPImqjah2pproHcIp+bSMVbS3cibTQ+yBuUZfiy7Uc4sJ0E8yRO
         gnxe2crNh/3+uvscQbRv4osuxrDYmh+pD4jhtRLhQv1OXUXX8rSjiYiREis18XQxTgyT
         ieW3sHsCpXZPhqhF9yFq6UpjLuzK+oemX4anPm7CbDxWX17jEr+Qi7t9z8+PuwJWoZ0U
         Smdbx+4YZDNdYNrmxb2nXjfXAHi+x//1LNOv804lsJqi9I9y8qQ3DXxt8KGrEMc1Cuet
         dkaw8S3YGO61WFOvM2HMSAT7yCNrr2o9O1BZL4kWrXRnjXoU77yYdAtXn2KDdc6VKBrf
         ejjQ==
Received: by 10.112.25.40 with SMTP id z8mr10631197lbf.95.1335826844885;
        Mon, 30 Apr 2012 16:00:44 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-91-188.pppoe.mtu-net.ru. [91.79.91.188])
        by mx.google.com with ESMTPS id pb13sm17970645lab.16.2012.04.30.16.00.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 16:00:42 -0700 (PDT)
Message-ID: <4F9F192D.8060207@mvista.com>
Date:   Tue, 01 May 2012 02:58:53 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120420 Thunderbird/12.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 04/14] MIPS: Add helper function to allow platforms to
 point at a DTB.
References: <1335785589-32532-1-git-send-email-blogic@openwrt.org> <1335785589-32532-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335785589-32532-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkOBub3nA2cZemkkMlLLUSEy5/VR6L4WgSbWvfCGrZNZst/a1odIa7PjTjyDVvn8OSULHRe
X-archive-position: 33101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 30-04-2012 15:32, John Crispin wrote:

> Add __dt_setup_arch() that can be called to load a builtin DT.
> Additionally we add a macro to allow loading a specific symbol
> from the __dtb_* section.

> Signed-off-by: Ralf Baechle<ralf@linux-mips.org>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> ---
>   arch/mips/include/asm/prom.h |   11 +++++++++++
>   arch/mips/kernel/prom.c      |   14 ++++++++++++++
>   2 files changed, 25 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 558b539..271ad98 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -95,3 +95,17 @@ void __init device_tree_init(void)
>   	/* free the space reserved for the dt blob */
>   	free_mem_mach(base, size);
>   }
> +
> +void __init __dt_setup_arch(struct boot_param_header *bph)
> +{
> +	unsigned long size;
> +
> +	if (be32_to_cpu(bph->magic) != OF_DT_HEADER) {
> +		pr_err("DTB has bad magic, ignoring builtin OF DTB\n");
> +
> +		return;
> +	}
> +
> +	initial_boot_params = bph;
> +	size = be32_to_cpu(bph->totalsize);

    'size' only assigned, not used.

> +}

WBR, Sergei
