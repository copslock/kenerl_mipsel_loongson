Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 01:04:45 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41932 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011645AbbATAEnWT0gW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 01:04:43 +0100
Date:   Tue, 20 Jan 2015 00:04:43 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 10/70] MIPS: asm: asmmacro: Drop unused 'reg'
 argument on MIPSR2
In-Reply-To: <1421405389-15512-11-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501200003060.28301@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-11-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> The local_irq_{enable, disable} macros do not use the reg argument
> so drop it.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/asmmacro.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 6caf8766b80f..90f69c334a75 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -20,12 +20,12 @@
>  #endif
>  
>  #ifdef CONFIG_CPU_MIPSR2
> -	.macro	local_irq_enable reg=t0
> +	.macro	local_irq_enable
>  	ei
>  	irq_enable_hazard
>  	.endm
>  
> -	.macro	local_irq_disable reg=t0
> +	.macro	local_irq_disable
>  	di
>  	irq_disable_hazard
>  	.endm

 Their !CONFIG_CPU_MIPSR2 counterparts do however.  Have you checked with 
GAS that it is acceptable to pass an extra argument to a macro that 
doesn't expect one?

  Maciej
