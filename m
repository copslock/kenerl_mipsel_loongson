Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Sep 2013 18:31:58 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:60842 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3IAQbzY2oxf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Sep 2013 18:31:55 +0200
Message-ID: <52236BED.9090207@phrozen.org>
Date:   Sun, 01 Sep 2013 18:31:41 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Prem Mallappa <prem.mallappa@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH 2/2] MIPS: KEXEC: Fixes Random crashes while loading crashkernel
References: <1377857111-15493-1-git-send-email-pmallappa@caviumnetworks.com> <1377857111-15493-2-git-send-email-pmallappa@caviumnetworks.com>
In-Reply-To: <1377857111-15493-2-git-send-email-pmallappa@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 30/08/13 12:05, Prem Mallappa wrote:
> MIPS: KEXEC: Fixes Random crashes while loading crashkernel
>
> Rearranging code so that crashk_res gets updated.
> - crashk_res is updated after mips_parse_crashkernel(),
>     after resource_init(), which is after arch_mem_init().
> - The reserved memory is actually treated as Usable memory,
>     Unless we load the crash kernel, everything works.
>
> Signed-off-by: Prem Mallappa<pmallappa@caviumnetworks.com>
> ---
>   arch/mips/kernel/setup.c | 99 +++++++++++++++++++++++-------------------------
>   1 file changed, 48 insertions(+), 51 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c7f9051..e98a256 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c

<snip>

> +static void __init request_crashkernel(struct resource *res)
> +{
> +	int ret;
> +
> +	ret = request_resource(res,&crashk_res);
> +	if (!ret)
> +		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
> +			(unsigned long)((crashk_res.end -
> +					 crashk_res.start + 1)>>  20),
> +			(unsigned long)(crashk_res.start>>  20));
> +}
> +#else /* !defined(CONFIG_KEXEC)		*/
> +static void __init mips_parse_crashkernel(void)
> +{
> +}
> +

Hi,

the function is not used and causes the following error.

arch/mips/kernel/setup.c:592:20: error: 'mips_parse_crashkernel' defined 
but not used [-Werror=unused-function]
cc1: all warnings being treated as errors

make[2]: *** [arch/mips/kernel/setup.o] Error 1
make[1]: *** [arch/mips/kernel] Error 2

	John






> +static void __init request_crashkernel(struct resource *res)
> +{
> +}
> +#endif /* !defined(CONFIG_KEXEC)  */
> +
>   static void __init arch_mem_init(char **cmdline_p)
>   {
>   	extern void plat_mem_setup(void);
> @@ -609,6 +655,8 @@ static void __init arch_mem_init(char **cmdline_p)
>   	}
>   #endif
>   #ifdef CONFIG_KEXEC
> +	mips_parse_crashkernel();
> +
>   	if (crashk_res.start != crashk_res.end)
>   		reserve_bootmem(crashk_res.start,
>   				crashk_res.end - crashk_res.start + 1,
> @@ -620,52 +668,6 @@ static void __init arch_mem_init(char **cmdline_p)
>   	paging_init();
>   }
>
> -#ifdef CONFIG_KEXEC
> -static inline unsigned long long get_total_mem(void)
> -{
> -	unsigned long long total;
> -
> -	total = max_pfn - min_low_pfn;
> -	return total<<  PAGE_SHIFT;
> -}
> -
> -static void __init mips_parse_crashkernel(void)
> -{
> -	unsigned long long total_mem;
> -	unsigned long long crash_size, crash_base;
> -	int ret;
> -
> -	total_mem = get_total_mem();
> -	ret = parse_crashkernel(boot_command_line, total_mem,
> -				&crash_size,&crash_base);
> -	if (ret != 0 || crash_size<= 0)
> -		return;
> -
> -	crashk_res.start = crash_base;
> -	crashk_res.end	 = crash_base + crash_size - 1;
> -}
> -
> -static void __init request_crashkernel(struct resource *res)
> -{
> -	int ret;
> -
> -	ret = request_resource(res,&crashk_res);
> -	if (!ret)
> -		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
> -			(unsigned long)((crashk_res.end -
> -				crashk_res.start + 1)>>  20),
> -			(unsigned long)(crashk_res.start>>  20));
> -}
> -#else /* !defined(CONFIG_KEXEC)	 */
> -static void __init mips_parse_crashkernel(void)
> -{
> -}
> -
> -static void __init request_crashkernel(struct resource *res)
> -{
> -}
> -#endif /* !defined(CONFIG_KEXEC)  */
> -
>   static void __init resource_init(void)
>   {
>   	int i;
> @@ -678,11 +680,6 @@ static void __init resource_init(void)
>   	data_resource.start = __pa_symbol(&_etext);
>   	data_resource.end = __pa_symbol(&_edata) - 1;
>
> -	/*
> -	 * Request address space for all standard RAM.
> -	 */
> -	mips_parse_crashkernel();
> -
>   	for (i = 0; i<  boot_mem_map.nr_map; i++) {
>   		struct resource *res;
>   		unsigned long start, end;
