Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 May 2013 23:43:02 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:59397 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835012Ab3EQVm55-Fyb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 May 2013 23:42:57 +0200
Received: by mail-pd0-f181.google.com with SMTP id p11so3724448pdj.12
        for <multiple recipients>; Fri, 17 May 2013 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=mP14dtb7TCg9Wwd3NzfVNCMK8SL2/ZoRv1rQOJXTzmc=;
        b=Jryd3sdy7Our78Wzv49RLd8P2mWwqBfU5Ef29+y1x94yxm4EXAWX2uXySpRdZXjkU5
         keQOdkF5DJovt18qbqbfgh5QXERSCvkj9bf0BM/TiBo4IJicM5X4TvTNWAPylMZJHZ5g
         7KBdC7gAA3iaK4fdW7znVBs8IKvzlhVCa7uhN/iQh4aA81OO8QkOvKkDY1VI2BZtt9/c
         XNn98Lv7+I43vC6mbdDcaPGmFpOs8f58Y9bRNWzE9jt5V6PEbtkn6MrKJZI33hoIV8t6
         jC5E+5EtLJFcvdmzNPRTuFEDasDtFHh3wsIzknskVkBF/biGtOpfL+G9SfqP0yLfP/6a
         +TJg==
X-Received: by 10.66.159.6 with SMTP id wy6mr50638532pab.206.1368826971155;
        Fri, 17 May 2013 14:42:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id fn9sm13785547pab.2.2013.05.17.14.42.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 14:42:49 -0700 (PDT)
Message-ID: <5196A458.7080400@gmail.com>
Date:   Fri, 17 May 2013 14:42:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        ralf@linux-mips.org, gleb@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH] KVM/MIPS32: Export min_low_pfn.
References: <n> <1368824818-22503-1-git-send-email-sanjayl@kymasys.com>
In-Reply-To: <1368824818-22503-1-git-send-email-sanjayl@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36442
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

On 05/17/2013 02:06 PM, Sanjay Lal wrote:
> The KVM module uses the standard MIPS cache management routines, which use min_low_pfn.
> This creates and indirect dependency, requiring min_low_pfn to be exported.
>
> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/kernel/mips_ksyms.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
> index 6e58e97..0299472 100644
> --- a/arch/mips/kernel/mips_ksyms.c
> +++ b/arch/mips/kernel/mips_ksyms.c
> @@ -14,6 +14,7 @@
>   #include <linux/mm.h>
>   #include <asm/uaccess.h>
>   #include <asm/ftrace.h>
> +#include <linux/bootmem.h>
>
>   extern void *__bzero(void *__s, size_t __count);
>   extern long __strncpy_from_user_nocheck_asm(char *__to,
> @@ -60,3 +61,8 @@ EXPORT_SYMBOL(invalid_pte_table);
>   /* _mcount is defined in arch/mips/kernel/mcount.S */
>   EXPORT_SYMBOL(_mcount);
>   #endif
> +
> +/* The KVM module uses the standard MIPS cache functions which use
> + * min_low_pfn, requiring it to be exported.
> + */
> +EXPORT_SYMBOL(min_low_pfn);

I think I asked this before, but I don't remember the answer:

Why not put EXPORT_SYMBOL(min_low_pfn) in mm/bootmem.c adjacent to where 
the symbol is defined?

Cluttering up the kernel with multiple architectures all doing 
architecture specific exports of the same symbol is not a clean way of 
doing things.

The second time something needs to be done, it should be factored out 
into common code.

David Daney

>
