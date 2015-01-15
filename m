Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 20:36:22 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45378 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011506AbbAOTgUJRPMy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 20:36:20 +0100
Received: by mail-ie0-f170.google.com with SMTP id rd18so16832864iec.1;
        Thu, 15 Jan 2015 11:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EUe8uhpsiumDpIIH6SCl+YzH6A/bzwd3ThEDzWN7ruU=;
        b=P4xLzTwqFG0YmhZfd7mmpfwjw2aXUTClgLz8/rNFcGe6NLRByuaXyzZiNSn7dMzXim
         x2rze1ZO6GYvWjflxERkUwVKZnOGsgm2r96XUnTcY2rhH2wirkC9LXZ0JN8uWze/Ee4/
         C77dJALZuDroMiOHbwxblKZKQZxstmsWXGTl5pWbsEn330ILF0X99HXQ2ZYW6kw/FpCj
         /Gwa+Rl6QAutYbsudxeXSbxM5zNqaFbHsoWQcdlTcxPA+eC+baLATst1CN0Rytq7tc6C
         aXPdEICWjqXGLYgm6aJac7lmIqeBlGOyR8fpNrhugshLXp7nz/jp1VOvi156czksSrpe
         kj4g==
X-Received: by 10.50.25.225 with SMTP id f1mr5938734igg.29.1421350574320;
        Thu, 15 Jan 2015 11:36:14 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id x124sm1489515iod.38.2015.01.15.11.36.13
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 11:36:13 -0800 (PST)
Message-ID: <54B816AC.7070902@gmail.com>
Date:   Thu, 15 Jan 2015 11:36:12 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: OCTEON: fix kernel crash when offlining a CPU
References: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 01/15/2015 10:49 AM, Aaro Koskinen wrote:
> octeon_cpu_disable() will unconditionally enable interrupts when called
> with interrupts disabled. Fix that.

interrupts are always disabled here, so...

[...]
>
> Reported-by: Hemmo Nieminen <hemmo.nieminen@iki.fi>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org

NACK!

> ---
>   arch/mips/cavium-octeon/smp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index ecd903d..9673c5b 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -231,6 +231,7 @@ DEFINE_PER_CPU(int, cpu_state);
>   static int octeon_cpu_disable(void)
>   {
>   	unsigned int cpu = smp_processor_id();
> +	unsigned long flags;
>
>   	if (cpu == 0)
>   		return -EBUSY;
> @@ -240,9 +241,9 @@ static int octeon_cpu_disable(void)
>
>   	set_cpu_online(cpu, false);
>   	cpu_clear(cpu, cpu_callin_map);
> -	local_irq_disable();
> +	local_irq_save(flags);

Just remove this...

>   	octeon_fixup_irqs();
> -	local_irq_enable();
> +	local_irq_restore(flags);

... and this.

>
>   	flush_cache_all();
>   	local_flush_tlb_all();
>

You can add an Acked-by me if you do that.

David Daney.
