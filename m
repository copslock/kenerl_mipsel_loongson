Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Dec 2013 10:42:48 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:41643 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823068Ab3LIJmpqBEO1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Dec 2013 10:42:45 +0100
Message-ID: <52A59099.3000506@imgtec.com>
Date:   Mon, 9 Dec 2013 09:42:49 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: microMIPS: Remove unsupported compiler flag.
References: <1386265069-21930-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1386265069-21930-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_12_09_09_42_40
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38684
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

On 12/05/2013 05:37 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
>
> Remove usage of -mno-jals compiler flag when building a pure
> microMIPS kernel. The -mno-jals flag only ever existed within
> Mentor toolchains. Dropping this flag allows all FSF toolchains
> to work.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index de300b9..873a0ca 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -114,7 +114,7 @@ cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(shell $(CC) -dumpmachine |grep -q 'mips.*e
>   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= $(shell $(CC) -dumpmachine |grep -q 'mips.*el-.*' || echo -EL $(undef-all) $(predef-le))
>
>   cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,-msmartmips)
> -cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips -mno-jals)
> +cflags-$(CONFIG_CPU_MICROMIPS) += $(call cc-option,-mmicromips)
>
>   cflags-$(CONFIG_SB1XXX_CORELIS)	+= $(call cc-option,-mno-sched-prolog) \
>   				   -fno-omit-frame-pointer
>

Ralf,

Do you think we can have this in v3.13 (and maybe stable)?

-- 
markos
