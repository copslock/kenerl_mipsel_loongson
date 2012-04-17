Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2012 05:09:23 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:57631 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901173Ab2DQDJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2012 05:09:07 +0200
Received: by qafi29 with SMTP id i29so110742qaf.15
        for <multiple recipients>; Mon, 16 Apr 2012 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KHWZGjbF8JmOp5ELestiWaj5wwigfe1u5dxF9/WtJBA=;
        b=smGL1PdQG5i0JQFfvJS0W9Q46eDHSWuO4Oo6ED7BIUKq6VY2jaHsTXMzUrCOe2iiyn
         uiQqmacWPQWzubJDDeDuUFcn/uR9pyeBj1x7zDaB/salTfC8C1tZO7D9C9al8aGOFpOu
         zIVV/U7Oi5LIZcjE65MK4iM1DododudhW7A6fXtK2JB7Ah7uakmkZnC+ixBd1iIO2opp
         sTydaP1j6aZTIZxtTnS9BzyFr58nCsGAmnSdkfZ0IJoSHvauYcvdeEgRtkTTiXC2zfzR
         0B2+jR7YjKpYaVLgnUlBEfPnCim/KyEj23edFQEUboKSo2epqSa0XTi9fKbBL23Y4PTl
         byBQ==
Received: by 10.224.213.196 with SMTP id gx4mr18499495qab.95.1334632141548;
        Mon, 16 Apr 2012 20:09:01 -0700 (PDT)
Received: from localhost ([61.148.56.138])
        by mx.google.com with ESMTPS id gy2sm37893892qab.10.2012.04.16.20.08.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 20:09:00 -0700 (PDT)
Date:   Tue, 17 Apr 2012 11:08:48 +0800
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: cavium: Don't enable irq in ->init__secondary()
Message-ID: <20120417030848.GA6377@zhy>
Reply-To: Yong Zhang <yong.zhang0@gmail.com>
References: <1334561133-19139-1-git-send-email-yong.zhang0@gmail.com>
 <4F8C4D4E.4060900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F8C4D4E.4060900@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 16, 2012 at 09:48:14AM -0700, David Daney wrote:
> On 04/16/2012 12:25 AM, Yong Zhang wrote:
> >From: Yong Zhang<yong.zhang@windriver.com>
> >
> >Too early to enable irq will break some following action,
> >such as notify_cpu_starting().
> 
> Can you be more specific about what breaks?

For example:

	CPU1				CPU2
__cpu_up();
  mp_ops->boot_secondary();
    				start_secondary();
				  octeon_init_secondary();
				    raw_local_irq_enable();
				    <IRQ>
				      do something;
				      wake up softirqd;
				      try_to_wake_up();
				        select_fallback_rq();
					/* select wrong cpu */
    set_cpu_online();

> 
> >
> >I don't get side effect with this patch.
> 
> Without this, where do irqs get enabled on the secondary CPUs?

cpu_idle() will handle it. But in fact we should not depend on
cpu_idle().

But it seems there is not suitable place to put local_irq_enable(),
though ->smp_finish() looks like a more suitable place.

When looking more at smp support on MIPS, there is more things I find.
Such as set_cpu_online() is called on CPU1, so there will be another race
window like above scenario. Please take a look at what commit 2baab4e9
intend to resolve.

Thanks,
Yong




> 
> >
> >Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>
> >Cc: David Daney<ddaney@caviumnetworks.com>
> >Cc: Ralf Baechle<ralf@linux-mips.org>
> >---
> >  arch/mips/cavium-octeon/smp.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> >diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> >index 97e7ce9..7e65c88 100644
> >--- a/arch/mips/cavium-octeon/smp.c
> >+++ b/arch/mips/cavium-octeon/smp.c
> >@@ -185,7 +185,6 @@ static void __cpuinit octeon_init_secondary(void)
> >  	octeon_init_cvmcount();
> >
> >  	octeon_irq_setup_secondary();
> >-	raw_local_irq_enable();
> >  }
> >
> >  /**

-- 
Only stand for myself
