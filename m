Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2014 11:42:52 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:45384 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009723AbaIYJmtV8kCE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2014 11:42:49 +0200
Received: by mail-la0-f42.google.com with SMTP id hz20so12442763lab.29
        for <linux-mips@linux-mips.org>; Thu, 25 Sep 2014 02:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=j2UTzygCdflbvnWpmI0hnj/tILAbCD6P2uwqqpXBRhA=;
        b=IfNSfOfSatVCz6qAAsvzwnb+H3ktoMQ/FJAF7Gb6GbpZ5XkpBP+WvUxuttiXTd95V2
         8e/27m9ZmKv2nbwrIZ3SEH0w6Sfyp74+0f3pRxWJygopVXTkNuLGCyKx7CM6MadTlCXV
         Qd6vYKvWfuHz4VMNWZGyEVcqTJdUW93zPIoU7fKBX+h2h5C6U8kjfS4ZNj5wxpcfHWaX
         pGjvVAM/SGxtbusxgzuZeFm/3YxRQ0HCvKWnwTX77xPfJ7U7vK/V46ZN/QqkNLD5b82a
         qN4QaiOwOGaBnT2R8KBIhLNn1Jj9dUGPoYEvmGFHNGiA1cufoestn/CxoZ4zr7EdG4HZ
         THxA==
X-Gm-Message-State: ALoCoQkETjsiXPdHnP29FanQ6sK3G06+QeL96OJL24g07Ty++qZw2MgG5v+kepcMSqFCnB+IWLEK
X-Received: by 10.152.36.37 with SMTP id n5mr1779850laj.93.1411638163737;
        Thu, 25 Sep 2014 02:42:43 -0700 (PDT)
Received: from [192.168.2.5] (ppp29-116.pppoe.mtu-net.ru. [81.195.29.116])
        by mx.google.com with ESMTPSA id wj8sm648204lbb.34.2014.09.25.02.42.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2014 02:42:43 -0700 (PDT)
Message-ID: <5423E392.2070004@cogentembedded.com>
Date:   Thu, 25 Sep 2014 13:42:42 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: prevent compiler warning from cop2_{save,restore}
References: <1411637175-30010-1-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1411637175-30010-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 9/25/2014 1:26 PM, Paul Burton wrote:

> The no-op cases of cop2_save & cop2_restore lead to the following
> warnings being emitted during build with recent versions of gcc (tested
> using gcc 4.8.3 from the Mentor Sourcery CodeBench 2014.05 toolchain):

>    In file included from ./arch/mips/include/asm/switch_to.h:18:0,
>                     from kernel/sched/core.c:78:
>    kernel/sched/core.c: In function 'finish_task_switch':
>    include/asm-generic/current.h:6:45: warning: value computed is not used [-Wunused-value]
>     #define get_current() (current_thread_info()->task)
                                                 ^
>    ./arch/mips/include/asm/cop2.h:48:32: note: in definition of macro 'cop2_restore'
>     #define cop2_restore(r)  do { (r); } while (0)
>                                    ^
>    include/asm-generic/current.h:7:17: note: in expansion of macro 'get_current'
>     #define current get_current()
>                     ^
>    ./arch/mips/include/asm/switch_to.h:114:16: note: in expansion of macro 'current'
>       cop2_restore(current);     \
>                    ^
>    kernel/sched/core.c:2225:2: note: in expansion of macro 'finish_arch_switch'
>      finish_arch_switch(prev);
>      ^

> Avoid the warning by "using" the value by casting to void.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/include/asm/cop2.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/arch/mips/include/asm/cop2.h b/arch/mips/include/asm/cop2.h
> index 51f80bd..63b3468 100644
> --- a/arch/mips/include/asm/cop2.h
> +++ b/arch/mips/include/asm/cop2.h
> @@ -37,15 +37,15 @@ extern void nlm_cop2_restore(struct nlm_cop2_state *);
>
>   #define cop2_present		1
>   #define cop2_lazy_restore	1
> -#define cop2_save(r)		do { (r); } while (0)
> -#define cop2_restore(r)		do { (r); } while (0)
> +#define cop2_save(r)		do { (void)(r); } while (0)
> +#define cop2_restore(r)		do { (void)(r); } while (0)
>
>   #else
>
>   #define cop2_present		0
>   #define cop2_lazy_restore	0
> -#define cop2_save(r)		do { (r); } while (0)
> -#define cop2_restore(r)		do { (r); } while (0)
> +#define cop2_save(r)		do { (void)(r); } while (0)
> +#define cop2_restore(r)		do { (void)(r); } while (0)
>   #endif

    Looks like the definition are identical between 2 arms of #if, so why not 
move the macro definition out of #if, perhaps in later cleanup patch?

WBR, Sergei
