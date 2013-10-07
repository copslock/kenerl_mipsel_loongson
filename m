Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Oct 2013 17:28:58 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47836 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6868729Ab3JGP24dRgW9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Oct 2013 17:28:56 +0200
Message-ID: <5252D343.6090100@imgtec.com>
Date:   Mon, 7 Oct 2013 16:29:07 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: SmartMIPS: Fix build
References: <1381158642-10598-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1381158642-10598-1-git-send-email-treding@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_07_16_28_50
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 10/07/13 16:10, Thierry Reding wrote:
> All CONFIG_CPU_HAS_SMARTMIPS #ifdefs have been removed from code, but
> the ACX register declaration in struct pt_regs is still protected by it,
> causing builds to fail. Remove the #ifdef protection and always declare
> the register.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   arch/mips/include/asm/ptrace.h | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 7bba9da..d47bdce 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -33,9 +33,7 @@ struct pt_regs {
>   	unsigned long cp0_status;
>   	unsigned long hi;
>   	unsigned long lo;
> -#ifdef CONFIG_CPU_HAS_SMARTMIPS
>   	unsigned long acx;
> -#endif
>   	unsigned long cp0_badvaddr;
>   	unsigned long cp0_cause;
>   	unsigned long cp0_epc;
>

Hi Thierry,

Looks good to me. Thanks!

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
