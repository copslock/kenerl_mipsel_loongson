Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 13:13:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56137 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010266AbbCaLNAfD9Rl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Mar 2015 13:13:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2VBD0dM031770;
        Tue, 31 Mar 2015 13:13:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2VBD0Hf031769;
        Tue, 31 Mar 2015 13:13:00 +0200
Date:   Tue, 31 Mar 2015 13:13:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: malta: pass fw arguments on kexec
Message-ID: <20150331111300.GB28951@linux-mips.org>
References: <1424877665-4487-1-git-send-email-aaro.koskinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424877665-4487-1-git-send-email-aaro.koskinen@nokia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Feb 25, 2015 at 05:21:05PM +0200, Aaro Koskinen wrote:

> Pass fw arguments on kexec to the new kernel.
> 
> Tested with MIPS64 QEMU. Without the patch the new kernel will default to
> (likely) incorrect default memory and console setup, making kexec pretty
> much useless.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/mips/mti-malta/malta-reset.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
> index 2fd2cc2..f218ba8 100644
> --- a/arch/mips/mti-malta/malta-reset.c
> +++ b/arch/mips/mti-malta/malta-reset.c
> @@ -8,8 +8,10 @@
>   */
>  #include <linux/io.h>
>  #include <linux/pm.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/reboot.h>
> +#include <asm/bootinfo.h>
>  #include <asm/mach-malta/malta-pm.h>
>  
>  #define SOFTRES_REG	0x1f000500
> @@ -36,8 +38,19 @@ static void mips_machine_power_off(void)
>  	mips_machine_restart(NULL);
>  }
>  
> +static int mips_kexec_prepare(struct kimage *image)
> +{
> +	kexec_args[0] = fw_arg0;
> +	kexec_args[1] = fw_arg1;
> +	kexec_args[2] = fw_arg2;
> +	kexec_args[3] = fw_arg3;
> +
> +	return 0;
> +}

This makes arguments coming from the firmware non-overridable default?

  Ralf
