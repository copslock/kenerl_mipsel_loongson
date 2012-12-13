Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2012 18:50:47 +0100 (CET)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38678 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6829639Ab2LMRuqbgXYd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2012 18:50:46 +0100
Received: by mail-pb0-f49.google.com with SMTP id un15so1580553pbc.36
        for <multiple recipients>; Thu, 13 Dec 2012 09:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8EUKjPEp7H85h7TebDxRVFo41uzkYa96DTz1osn0w5U=;
        b=RpjVO4QaXxyve2Y6xJmpVcr5hw3E0rtfXHZeF7/+wfEI7ygf7Tovst7Mixsysa5nBs
         grDbPOintr4e8K1hSpe4UOWPZCxHUUq1yO90qjb0hkqSpSu+tlTEJ9zWGjO+wThEBmgs
         IWP4Za0DwmgV8AnQfXcdyeBn3+upsjVDZoAriLoMELh3pYmrvBeIJQlraVsZjV3g9ifA
         nA20sm2rZt/ByA0DKQQbtgLr3jbBPDka0aQNEEfqlNuhRS1HLtw76MQLjhjm2hEtuwZ9
         vpzQNetXqGrhqbWvP2fTTaGftvayLF7JvtbYu4Tl+Yn5WYZvAFuStdx+JWo8Ksf/QV2V
         278Q==
Received: by 10.69.0.10 with SMTP id au10mr7836862pbd.18.1355421039606;
        Thu, 13 Dec 2012 09:50:39 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id yi9sm1366181pbc.39.2012.12.13.09.50.36
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Dec 2012 09:50:36 -0800 (PST)
Message-ID: <50CA156B.6000002@gmail.com>
Date:   Thu, 13 Dec 2012 09:50:35 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: Make CP0 config registers readable via sysfs.
References: <1355388824-7655-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1355388824-7655-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12/13/2012 12:53 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>

Thanks Steven,

> Allow reading of CP0 config registers via sysfs for each core
> in the system. The registers will show up in sysfs at the path:
>
>     /sys/devices/system/cpu/cpuX/configX
>
> Only CP0 config registers 0 through 7 are currently supported.

That's not really a limitation, as those are the only ones that exist.


>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

One small change below, but otherwise,

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/kernel/Makefile |    1 +
>   arch/mips/kernel/sysfs.c  |   68 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
>   create mode 100644 arch/mips/kernel/sysfs.c
>
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index cc5eec6..0c3eb97 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
>   obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_mipsxx.o
>
>   obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
> +obj-y				+= sysfs.o
>
>   ifeq ($(CONFIG_CPU_MIPS32), y)
>   #
> diff --git a/arch/mips/kernel/sysfs.c b/arch/mips/kernel/sysfs.c
> new file mode 100644
> index 0000000..4f26349
> --- /dev/null
> +++ b/arch/mips/kernel/sysfs.c
> @@ -0,0 +1,68 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> + */
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/cpu.h>
> +#include <linux/percpu.h>
> +
> +#include <asm/page.h>
> +
> +/* Convenience macro */
> +#define read_c0_config0()	read_c0_config()
> +
> +#define __BUILD_CP0_SYSFS(reg)					\
> +static ssize_t show_config##reg(struct device *dev,		\
> +		struct device_attribute *attr, char *buf)	\
> +{								\
> +	int n = snprintf(buf, PAGE_SIZE-2, "%x\n",		\
> +		read_c0_config##reg());				\
> +	return n;						\
> +}								\
> +static DEVICE_ATTR(config##reg, 0444, show_config##reg, NULL);

s/0444/S_IRUGO/


[...]

> +late_initcall(mips_sysfs_registers);
>

Why late_initcall?  I don't really have an objection, but unless there 
is a good reason, why not device_initcall?
