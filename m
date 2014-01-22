Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 16:25:50 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60130 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825759AbaAVPZrPoEs1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 16:25:47 +0100
Message-ID: <52DFE2EE.8040108@phrozen.org>
Date:   Wed, 22 Jan 2014 16:25:34 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     fengguang.wu@intel.com, linux-serial@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: make loongsoon serial driver explicitly modular
References: <52df9ab1.ahF1zl0PTutzrviC%fengguang.wu@intel.com> <1390403871-16809-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1390403871-16809-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39065
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

Hi,

On 22/01/2014 16:17, Paul Gortmaker wrote:
> The file looks as if it is non-modular, but it piggy-backs
> off CONFIG_SERIAL_8250 which is tristate.  If set to "=m"
> we will get this after the init/module header cleanup:
>
> arch/mips/loongson/common/serial.c:76:1: error: data definition has no type or storage class [-Werror]
> arch/mips/loongson/common/serial.c:76:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
> arch/mips/loongson/common/serial.c:76:1: error: parameter names (without types) in function declaration [-Werror]
> arch/mips/loongson/common/serial.c:58:19: error: 'serial_init' defined but not used [-Werror=unused-function]
> cc1: all warnings being treated as errors
> make[3]: *** [arch/mips/loongson/common/serial.o] Error 1
>
> Make it clearly modular, and add a module_exit function,
> so that we avoid the above breakage.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: John Crispin <blogic@openwrt.org>

as this patch is already in Paul's tree, i will set it to "other
maintainer" in the linux-mips patchwork.

Thanks,
    John





> ---
>
> [patch added to init cleanup series:
>    http://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/  ]
>
>  arch/mips/loongson/common/serial.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
> index 5f2b78a..4d0922f 100644
> --- a/arch/mips/loongson/common/serial.c
> +++ b/arch/mips/loongson/common/serial.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include <linux/io.h>
> -#include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/serial_8250.h>
>  
>  #include <asm/bootinfo.h>
> @@ -72,5 +72,10 @@ static int __init serial_init(void)
>  
>  	return platform_device_register(&uart8250_device);
>  }
> +module_init(serial_init);
>  
> -device_initcall(serial_init);
> +static void __init serial_exit(void)
> +{
> +	platform_device_unregister(&uart8250_device);
> +}
> +module_exit(serial_exit);
