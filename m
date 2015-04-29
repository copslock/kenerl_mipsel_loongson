Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 11:39:04 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:43933 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011967AbbD2JjB0ykUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 11:39:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 9CBAB18101;
        Wed, 29 Apr 2015 11:38:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id UyCWJYinJkeX; Wed, 29 Apr 2015 11:38:56 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id 1591C180B2;
        Wed, 29 Apr 2015 11:38:56 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id F1CDC14AC;
        Wed, 29 Apr 2015 11:38:55 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id E5DD41217;
        Wed, 29 Apr 2015 11:38:55 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
        by seth.se.axis.com (Postfix) with ESMTP id E31363E049;
        Wed, 29 Apr 2015 11:38:55 +0200 (CEST)
Received: from [10.94.49.1] (10.94.49.1) by xmail2.se.axis.com (10.0.5.74)
 with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 29 Apr 2015 11:38:56
 +0200
Message-ID: <5540A6AF.5090701@axis.com>
Date:   Wed, 29 Apr 2015 11:38:55 +0200
From:   Niklas Cassel <niklas.cassel@axis.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
MIME-Version: 1.0
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH] MIPS: Fix up obsolete cpu_set usage
References: <1430256863-811-1-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1430256863-811-1-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <niklas.cassel@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: niklas.cassel@axis.com
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

On 04/28/2015 11:34 PM, Ezequiel Garcia wrote:
> cpu_set was removed (along with a bunch of cpumask helpers) by
> commit 2f0f267ea072 ("cpumask: remove deprecated functions.").
> 
> Fix this by replacing cpu_set with cpumask_set_cpu. Without this
> fix the following error is triggered when CONFIG_MIPS_MT_FPAFF=y.
> 
>   arch/mips/kernel/smp-cps.c: In function 'cps_smp_setup':
>   arch/mips/kernel/smp-cps.c:95:3: error: implicit declaration of function 'cpu_set' [-Werror=implicit-function-declaration]
> 
> Fixes: 90db024f140d ("MIPS: smp-cps: cpu_set FPU mask if FPU present")
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Acked-by: Niklas Cassel <niklass@axis.com>

> ---
> This is a fix for v4.1.
> 
>  arch/mips/kernel/smp-cps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
> index 7e011f9..4251d39 100644
> --- a/arch/mips/kernel/smp-cps.c
> +++ b/arch/mips/kernel/smp-cps.c
> @@ -92,7 +92,7 @@ static void __init cps_smp_setup(void)
>  #ifdef CONFIG_MIPS_MT_FPAFF
>  	/* If we have an FPU, enroll ourselves in the FPU-full mask */
>  	if (cpu_has_fpu)
> -		cpu_set(0, mt_fpu_cpumask);
> +		cpumask_set_cpu(0, &mt_fpu_cpumask);
>  #endif /* CONFIG_MIPS_MT_FPAFF */
>  }
>  
> 
