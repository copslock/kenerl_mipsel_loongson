Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 00:57:58 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59250 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860164AbaHDW54D0E10 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2014 00:57:56 +0200
Received: by mail-pd0-f171.google.com with SMTP id z10so140946pdj.30
        for <linux-mips@linux-mips.org>; Mon, 04 Aug 2014 15:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LvJKP88Z9iyVgxu794nWXd2NZiU/5cZCVt4can5tYCc=;
        b=zNxizfk6+IWfKg49wllgL9gwkOE7cTdZ+pxMmEkrBszhYVqS596VGXeao6CjEC/rEF
         tdDhqDEoNnIhFDaEOb+z43PPYPrY0pj+Txy0SzvHnG4Mn0bf7b/5e+X7ufisuEP3XMiC
         ccRKunHFT4AUty/4sGpuUXWnU+yJVvrgK3hAYWRt7SyHO2fPg0A/x+NcEGMWFbSWOc/d
         85J46pYEueLDhg6RGNi89D/C95qCGXhp/LRpCH559JoZ6u6bHfzgMxtBnhJMHiLa0W4z
         48euYl72m8H/A7an/VTdJvJkdXTV6sBEDIRGbK/XwrxRSXAzfFxIedArPIDKgecg6k1l
         kc0g==
X-Received: by 10.70.138.75 with SMTP id qo11mr27131229pdb.40.1407193069560;
        Mon, 04 Aug 2014 15:57:49 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id cm7sm28465368pdb.74.2014.08.04.15.57.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2014 15:57:48 -0700 (PDT)
Message-ID: <53E00FE2.3050002@gmail.com>
Date:   Mon, 04 Aug 2014 15:57:38 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
CC:     Jeffrey Deans <jeffrey.deans@imgtec.com>
Subject: Re: [PATCH 6/7] MIPS: Malta: Fix dispatching of GIC interrupts
References: <1405585259-24941-1-git-send-email-markos.chandras@imgtec.com> <1405585259-24941-7-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405585259-24941-7-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41879
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

On 07/17/2014 01:20 AM, Markos Chandras wrote:
> From: Jeffrey Deans <jeffrey.deans@imgtec.com>
> 
> The Malta malta_ipi_irqdispatch() routine now checks only IPI interrupts
> when handling IPIs. It could previously call do_IRQ() for non-IPIs, and
> also call do_IRQ() with an invalid IRQ number if there were no pending
> GIC interrupts when gic_get_int() was called.
> 
> Signed-off-by: Jeffrey Deans <jeffrey.deans@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/mti-malta/malta-int.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
> index 4ab919141737..e4f43baa8f67 100644
> --- a/arch/mips/mti-malta/malta-int.c
> +++ b/arch/mips/mti-malta/malta-int.c
> @@ -42,6 +42,10 @@ static unsigned int ipi_map[NR_CPUS];
>  
>  static DEFINE_RAW_SPINLOCK(mips_irq_lock);
>  
> +#ifdef CONFIG_MIPS_GIC_IPI
> +DECLARE_BITMAP(ipi_ints, GIC_NUM_INTRS);
> +#endif

I caught this one too late (it is already in mips-for-linux-next), but
it looks like we could make ipi_ints static.
--
Florian
