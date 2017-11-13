Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 15:21:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35680 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990426AbdKMOVMPc9FH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Nov 2017 15:21:12 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vADELBGX009875;
        Mon, 13 Nov 2017 15:21:11 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vADELAmh009874;
        Mon, 13 Nov 2017 15:21:10 +0100
Date:   Mon, 13 Nov 2017 15:21:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     jiaxun.yang@flygoat.com
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Lonngson64: Copy kernel command line from
 arcs_cmdline Since lemte-2f/marchtype.c need to get cmdline from loongson.h
 this patch simply copy kernel command line from arcs_cmdline to fix that
 issue
Message-ID: <20171113142110.GA13046@linux-mips.org>
References: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112063617.26546-1-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60872
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

On Sun, Nov 12, 2017 at 02:36:14PM +0800, jiaxun.yang@flygoat.com wrote:
> Date:   Sun, 12 Nov 2017 14:36:14 +0800
> From: jiaxun.yang@flygoat.com
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Jiaxun Yang
>  <jiaxun.yang@flygoat.com>
> Subject: [PATCH 1/4] MIPS: Lonngson64: Copy kernel command line from
>  arcs_cmdline Since lemte-2f/marchtype.c need to get cmdline from
>  loongson.h this patch simply copy kernel command line from arcs_cmdline to
>  fix that issue

Please don't cram the entire commit message into the subject line.  The
standard for commit messages to keep lines only so long that when you
look at them in "git log" in a 80 column terminal they don't get line
wrapped or truncated.

And what is "lemte-2f/marchtype.c"?  Maybe you meant lemote-2f/machtype.c?

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/mach-loongson64/loongson.h | 6 ++++++
>  arch/mips/loongson64/common/cmdline.c            | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/mips/include/asm/mach-loongson64/loongson.h b/arch/mips/include/asm/mach-loongson64/loongson.h
> index c68c0cc879c6..1edf3a484e6a 100644
> --- a/arch/mips/include/asm/mach-loongson64/loongson.h
> +++ b/arch/mips/include/asm/mach-loongson64/loongson.h
> @@ -45,6 +45,12 @@ static inline void prom_init_uart_base(void)
>  #endif
>  }
>  
> +/*
> + * Copy kernel command line from arcs_cmdline
> + */
> +#include <asm/setup.h>

Please group #include lines at the top of the file.

> +extern char loongson_cmdline[COMMAND_LINE_SIZE];
> +
>  /* irq operation functions */
>  extern void bonito_irqdispatch(void);
>  extern void __init bonito_irq_init(void);
> diff --git a/arch/mips/loongson64/common/cmdline.c b/arch/mips/loongson64/common/cmdline.c
> index 01fbed137028..49e172184e15 100644
> --- a/arch/mips/loongson64/common/cmdline.c
> +++ b/arch/mips/loongson64/common/cmdline.c
> @@ -21,6 +21,11 @@
>  
>  #include <loongson.h>
>  
> +/* the kernel command line copied from arcs_cmdline */
> +#include <linux/export.h>
> +char loongson_cmdline[COMMAND_LINE_SIZE];
> +EXPORT_SYMBOL(loongson_cmdline);
> +
>  void __init prom_init_cmdline(void)
>  {
>  	int prom_argc;
> @@ -45,4 +50,6 @@ void __init prom_init_cmdline(void)
>  	}
>  
>  	prom_init_machtype();
> +	/* copy arcs_cmdline into loongson_cmdline */
> +	strncpy(loongson_cmdline, arcs_cmdline, COMMAND_LINE_SIZE);
>  }

  Ralf
