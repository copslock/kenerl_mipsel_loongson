Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 08:29:44 +0200 (CEST)
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:14514
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdJEG3ho81ya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 08:29:37 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CuAADL0NVZ/zXSMGcNTxkBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYRBgRWDeppQAwEBAQaBCSKYOgciC4UYhSMUAQIBAQEBAQEBgVU?=
 =?us-ascii?q?SAYRFAQEEIlYbDQsCAiYCKjUNCAEBih8dpW9rgiciixIBAQEBAQUBAQEBHwWBD?=
 =?us-ascii?q?oIfgwuCMisLgnKIF4JhBYoSlyABjl0rh3GJYA2HCUiWSjaBLzIhCCoIhWMcgXl?=
 =?us-ascii?q?kAYV8g0YBAQE?=
X-IPAS-Result: =?us-ascii?q?A2CuAADL0NVZ/zXSMGcNTxkBAQEBAQEBAQEBAQcBAQEBAYR?=
 =?us-ascii?q?BgRWDeppQAwEBAQaBCSKYOgciC4UYhSMUAQIBAQEBAQEBgVUSAYRFAQEEIlYbD?=
 =?us-ascii?q?QsCAiYCKjUNCAEBih8dpW9rgiciixIBAQEBAQUBAQEBHwWBDoIfgwuCMisLgnK?=
 =?us-ascii?q?IF4JhBYoSlyABjl0rh3GJYA2HCUiWSjaBLzIhCCoIhWMcgXlkAYV8g0YBAQE?=
X-IronPort-AV: E=Sophos;i="5.42,480,1500912000"; 
   d="scan'208";a="9925903"
Received: from unknown (HELO [172.16.0.22]) ([103.48.210.53])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 05 Oct 2017 14:29:05 +0800
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 06/11] MIPS: cmpxchg: Implement __cmpxchg() as a function
Message-ID: <49fe6972-163d-3459-6963-582ffcc35b19@linux-m68k.org>
Date:   Thu, 5 Oct 2017 16:29:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@linux-m68k.org
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

Hi Paul,

On Fri, 9 Jun 2017 17:26:38 -0700, Paul Burton wrote:
> Replace the macro definition of __cmpxchg() with an inline function,
> which is easier to read & modify. The cmpxchg() & cmpxchg_local() macros
> are adjusted to call the new __cmpxchg() function.
> 
> Signed-off-by: Paul Burton <paul.burton@xxxxxxxxxx>
> Cc: Ralf Baechle <ralf@xxxxxxxxxxxxxx>
> Cc: linux-mips@xxxxxxxxxxxxxx

I think this patch is breaking user space for me. I say "think"
because it is a bit tricky to bisect for the few patches previous
to this one since they won't compile cleanly for me (due to this
https://www.spinics.net/lists/mips/msg68727.html).

I have a Cavium Octeon 5010 MIPS64 CPU on a custom board, have been
running it for years running various kernel versions. Linux-4.13
breaks for me, and I bisected back to this change.

What I see is user space bomb strait after boot with console messages
like this:

mount[37] killed because of sig - 11

STACK DUMP:
CPU: 0 PID: 37 Comm: mount Not tainted 4.13.0-uc0 #8
task: 8000000007d14200 task.stack: 8000000007f18000
$ 0   : 0000000000000000 000000ffffd23f70 000000000000001a 000000000001a7d0
$ 4   : 0000000125af9760 0000000125af9718 0000000125af9748 0000000000000001
$ 8   : 2f2f2f2f2f2f2f2f 8101010101010100 0000000000000000 00000000ffffffff
$12   : 000000fff79f6000 000000fff7980f00 000000fff79887d8 0000000000000018
$16   : 0000000125af9718 0000000125af9760 0000000125af9748 0000000120054cd8
$20   : 000000012006f3a0 00000001200083ac 0000000120059fa0 000000012006f3a0
$24   : 00000000000001c8 000000fff798f7d0                                  
$28   : 000000fff79f75e0 000000ffffd23fe0 0000000120010000 0000000120015820
Hi    : 00000000000001b6
Lo    : 000000000001b0b9
epc   : 000000fff798f7f4 0x000000fff798f7f4
ra    : 0000000120015820 0x0000000120015820
Status: 00008cf3	KX SX UX USER EXL IE 
Cause : 00800020 (ExcCode 08)
PrId  : 000d0601 (Cavium Octeon+)
000000ffffc9b000-000000ffffcbc000 rwxp 000000fffffdf000 00:00 0 

I get a lot of them from various programs running from rc scripts.
It never manages to fully boot to login/shell.

If I take the linux-4.12 arch/mips/include/asm/cmpxchg.h and drop that
in place on a linux-4.13 (or even linux-4.14-rc3) I can compile and
run everything successfully.

Any thoughts?

Regards
Greg



> ---
> 
>  arch/mips/include/asm/cmpxchg.h | 59 ++++++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
> index e9c1e97bc29d..516cb66f066b 100644
> --- a/arch/mips/include/asm/cmpxchg.h
> +++ b/arch/mips/include/asm/cmpxchg.h
> @@ -34,7 +34,7 @@
>   *
>   * - Get an error at link-time due to the call to the missing function.
>   */
> -extern void __cmpxchg_called_with_bad_pointer(void)
> +extern unsigned long __cmpxchg_called_with_bad_pointer(void)
>  	__compiletime_error("Bad argument size for cmpxchg");
>  extern unsigned long __xchg_called_with_bad_pointer(void)
>  	__compiletime_error("Bad argument size for xchg");
> @@ -137,38 +137,43 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
>  	__ret;								\
>  })
>  
> -#define __cmpxchg(ptr, old, new, pre_barrier, post_barrier)		\
> +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> +				      unsigned long new, unsigned int size)
> +{
> +	switch (size) {
> +	case 4:
> +		return __cmpxchg_asm("ll", "sc", (volatile u32 *)ptr, old, new);
> +
> +	case 8:
> +		/* lld/scd are only available for MIPS64 */
> +		if (!IS_ENABLED(CONFIG_64BIT))
> +			return __cmpxchg_called_with_bad_pointer();
> +
> +		return __cmpxchg_asm("lld", "scd", (volatile u64 *)ptr, old, new);
> +
> +	default:
> +		return __cmpxchg_called_with_bad_pointer();
> +	}
> +}
> +
> +#define cmpxchg_local(ptr, old, new)					\
> +	((__typeof__(*(ptr)))						\
> +		__cmpxchg((ptr),					\
> +			  (unsigned long)(__typeof__(*(ptr)))(old),	\
> +			  (unsigned long)(__typeof__(*(ptr)))(new),	\
> +			  sizeof(*(ptr))))
> +
> +#define cmpxchg(ptr, old, new)						\
>  ({									\
> -	__typeof__(ptr) __ptr = (ptr);					\
> -	__typeof__(*(ptr)) __old = (old);				\
> -	__typeof__(*(ptr)) __new = (new);				\
> -	__typeof__(*(ptr)) __res = 0;					\
> -									\
> -	pre_barrier;							\
> -									\
> -	switch (sizeof(*(__ptr))) {					\
> -	case 4:								\
> -		__res = __cmpxchg_asm("ll", "sc", __ptr, __old, __new); \
> -		break;							\
> -	case 8:								\
> -		if (sizeof(long) == 8) {				\
> -			__res = __cmpxchg_asm("lld", "scd", __ptr,	\
> -					   __old, __new);		\
> -			break;						\
> -		}							\
> -	default:							\
> -		__cmpxchg_called_with_bad_pointer();			\
> -		break;							\
> -	}								\
> +	__typeof__(*(ptr)) __res;					\
>  									\
> -	post_barrier;							\
> +	smp_mb__before_llsc();						\
> +	__res = cmpxchg_local((ptr), (old), (new));			\
> +	smp_llsc_mb();							\
>  									\
>  	__res;								\
>  })
>  
> -#define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_mb__before_llsc(), smp_llsc_mb())
> -#define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, , )
> -
>  #ifdef CONFIG_64BIT
>  #define cmpxchg64_local(ptr, o, n)					\
>    ({									\
> -- 
> 2.13.1
