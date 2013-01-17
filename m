Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 19:16:03 +0100 (CET)
Received: from mail-da0-f52.google.com ([209.85.210.52]:48033 "EHLO
        mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833223Ab3AQSP7Gb3wv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jan 2013 19:15:59 +0100
Received: by mail-da0-f52.google.com with SMTP id f10so1230877dak.39
        for <multiple recipients>; Thu, 17 Jan 2013 10:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hEY41LKmAPuTq2DlL6N1C2edmWkfzm6zyXHT0qbtKbQ=;
        b=Xsd2pylbVOiIyr8xg1bq+hGRaF498g0d58V9YZVewuuknAgNv2wLVyfV3oSj9vSL5X
         E6Gn87w5in+7ZnoQrehqnl/KUeOpDFuOyLAHpv9R3l1Yxs8atZXe7d4MkoW1vjf+P5a+
         grjiTSe34wiZD6BBtqNXqCkEbhE9/yMd+v1QSnjhIl2VMOAeVwARNDqd7g22hhhbfwI/
         qfiKqIQ7wFLJ/Q8VdymyMs1RNkS7AY3HX64PLIgUi4tsJfzk36pVw6Blskbv9U127NtL
         c7x6Jtz6zPHSoJXxWhHtIR43dj9xlYLwdqpdJ846tnXRdpqQi1gTfa968NcE81LJtBuo
         AF4g==
X-Received: by 10.68.137.131 with SMTP id qi3mr15847313pbb.114.1358446552013;
        Thu, 17 Jan 2013 10:15:52 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id oi2sm1453158pbb.62.2013.01.17.10.15.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 10:15:51 -0800 (PST)
Message-ID: <50F83FD5.2060908@gmail.com>
Date:   Thu, 17 Jan 2013 10:15:49 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
References: <1358444216-17213-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1358444216-17213-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35487
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

On 01/17/2013 09:36 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> The BRK_BUG value is used in the BUG and __BUG_ON inline macros. For
> standard MIPS cores the code in the 'tne' instruction is 10-bits long.
> In microMIPS, the 'tne' instruction is recoded and the code can only be
> 4-bits long. We use the value of 12 instead of 512 when building a
> microMIPS kernel.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
> ---
>   arch/mips/include/asm/break.h |    1 +
>   arch/mips/include/asm/bug.h   |    4 ++++
>   2 files changed, 5 insertions(+)
>
> diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
> index 9161e68..df9d090 100644
> --- a/arch/mips/include/asm/break.h
> +++ b/arch/mips/include/asm/break.h
> @@ -27,6 +27,7 @@
>   #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
>   #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
>   #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
> +#define BRK_BUG_MM	12	/* Used by BUG() in microMIPS mode */
>   #define BRK_BUG		512	/* Used by BUG() */

Can we move the CONFIG_CPU_MICROMIPS to here and just call the thing 
BRK_BUG?

Or perhaps redefining it unconditionally.  I am not sure what the 
implications of doing that would be.

That way...


>   #define BRK_KDB		513	/* Used in KDB_ENTER() */
>   #define BRK_MEMU	514	/* Used by FPU emulator */
> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 540c98a..b716fb9 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -7,6 +7,10 @@
>   #ifdef CONFIG_BUG
>
>   #include <asm/break.h>
> +#ifdef CONFIG_CPU_MICROMIPS
> +#undef BRK_BUG
> +#define BRK_BUG		BRK_BUG_MM
> +#endif
>

...We don't need this bit.   Doing an #undef risks using different 
values for BRK_BUG depending on whether or not asm/bug.h is included.

>   static inline void __noreturn BUG(void)
>   {
>
