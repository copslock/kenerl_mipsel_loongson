Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:55:52 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59624 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2EQKzo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:55:44 +0200
Received: by lbbgg6 with SMTP id gg6so1494834lbb.36
        for <linux-mips@linux-mips.org>; Thu, 17 May 2012 03:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=IhjD3BSlE6QKVWLLBFjpnbdu5nS7Gh+2hvYHlH7vgdg=;
        b=kQArYZt3IGuabC0kvhr/9GEaub7nc3cbwlt9zUieBky18lWlGpt6pHErMDaB8gPJpt
         QLyHLYHdlYXfAqjvsQj2nY2bDMfyG+cWjzFDIy2hXTpi8vN7qtO4s5/AE2z52U2Vl7mT
         iBFfCl+ql/m75yNh+JeaodtYPkjGCZdyITfml6/DP0raqAcBoacQZysv7cjNKdxt1BaG
         RfifJ0OfM7dqOYvlHt+EeTjHn6LVYtGvMsOcmgPoUva2MS4KSBTXLCjUS7Ojs5moMS4d
         12p7AXO4hnKIaP/qfzlX9+sKJB/Cae3X53RLKx9uMZONuyT4ok4wk/C2PAfK+kFmpv48
         XI8w==
Received: by 10.112.82.165 with SMTP id j5mr2904414lby.50.1337252138244;
        Thu, 17 May 2012 03:55:38 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-74-198.pppoe.mtu-net.ru. [91.79.74.198])
        by mx.google.com with ESMTPS id o2sm5162152lbd.7.2012.05.17.03.55.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:55:36 -0700 (PDT)
Message-ID: <4FB4D910.3020905@mvista.com>
Date:   Thu, 17 May 2012 14:55:12 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH 7/8] MIPS: smp: Warn on too early irq enable
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com> <1337249410-7162-8-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1337249410-7162-8-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnipxnj/KrM+dDSeuZstMMqaRWXJR5rROSfn2wozvxhHZaXiaMHL7Km7n/anS7n1k2Zsfem
X-archive-position: 33350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 17-05-2012 14:10, Yong Zhang wrote:

> From: Yong Zhang<yong.zhang@windriver.com>

> Just to catch a potential issue.

    Grammar nitpicking ahead. :-)

> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
> ---
>   arch/mips/kernel/smp.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 042145f..0d48598 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -130,6 +130,11 @@ asmlinkage __cpuinit void start_secondary(void)
>
>   	synchronise_count_slave();
>
> +	/*
> +	 * irq will be enabled in ->smp_finish(), enable it too early

    s/enable/enabling/

WBR, Sergei
