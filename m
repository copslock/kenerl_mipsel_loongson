Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2014 11:36:32 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:54718 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824283AbaBFKg1c4jvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Feb 2014 11:36:27 +0100
Date:   Thu, 6 Feb 2014 10:35:05 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fpu.h: fix build when CONFIG_BUG is not set
Message-ID: <20140206103505.GE54230@pburton-linux.le.imgtec.org>
References: <1391630744-32648-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1391630744-32648-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_02_06_10_36_21
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Feb 05, 2014 at 10:05:44PM +0200, Aaro Koskinen wrote:
> __enable_fpu produces a build failure when CONFIG_BUG is not set:
> 
> In file included from arch/mips/kernel/cpu-probe.c:24:0:
> arch/mips/include/asm/fpu.h: In function '__enable_fpu':
> arch/mips/include/asm/fpu.h:77:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> This is regression introduced in 3.14-rc1. Fix that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/include/asm/fpu.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/include/asm/fpu.h b/arch/mips/include/asm/fpu.h
> index cfe092fc720d..6b9749540edf 100644
> --- a/arch/mips/include/asm/fpu.h
> +++ b/arch/mips/include/asm/fpu.h
> @@ -74,6 +74,8 @@ static inline int __enable_fpu(enum fpu_mode mode)
>  	default:
>  		BUG();
>  	}
> +
> +	return SIGFPE;
>  }
>  
>  #define __disable_fpu()							\
> -- 
> 1.8.5.3
> 

Looks good to me, thanks for catching that.

Paul
