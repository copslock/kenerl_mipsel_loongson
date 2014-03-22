Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2014 23:41:59 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:47015 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816877AbaCVWlvyr1Qw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Mar 2014 23:41:51 +0100
Received: by mail-lb0-f181.google.com with SMTP id c11so2670370lbj.12
        for <linux-mips@linux-mips.org>; Sat, 22 Mar 2014 15:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jfqS3HrlVWnHU2IDtsY0UKMW7ylYrRZSoElKBTjIK00=;
        b=Zvbp+wEmXqI2FXeglvF95RgsozxaMaOgp5gVeMI2GSFdoyyV6bA1z3nuPO6Hkc5zKk
         NqneO0p5H7NgYAkigxuszbCr+yfGkEyuCPJunthdD+CUk8QD/2gM8rVDthOWTLx9xYX1
         fbf/kQlhgxUMRa2I1iIizv+nqOhs+ygpNgZhjHFkr7z97ktcsqDr15VhHp9TwgFsrs+2
         MWoqxkU+q3SyAMtVbTGCgFjaXiopujwnU6cHR5h84dQ+R/lMtGtvBzcAUCNFUYyFmz6h
         cpeqVIE2cfOsZU7x/MUW5sLH0rjJLeDkyL9dfLa9S2IG+o1n/dnor2yjcZylSlW0oFZu
         txsQ==
X-Gm-Message-State: ALoCoQkDWV1DbqEDHKxpjrCjXVS0iETowNs6M8BnV24ExobjNNCdfOdzU+M2qBVHsFfHAKcDjp/w
X-Received: by 10.112.160.200 with SMTP id xm8mr37220014lbb.24.1395528106281;
        Sat, 22 Mar 2014 15:41:46 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-60-105.pppoe.mtu-net.ru. [83.237.60.105])
        by mx.google.com with ESMTPSA id u4sm8835261laj.2.2014.03.22.15.41.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Mar 2014 15:41:45 -0700 (PDT)
Message-ID: <532E1FB1.9000606@cogentembedded.com>
Date:   Sun, 23 Mar 2014 02:41:37 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sanjay Lal <sanjayl@kymasys.com>,
        John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: export icache_flush_range
References: <20140322154720.GA23863@www.outflux.net>    <532E0486.3010702@cogentembedded.com>   <532E053C.90007@cogentembedded.com>     <532E0699.2080303@cogentembedded.com> <CAGXu5jLUueSb2u_Ki+nEL1CaBzyZyT1+7rhCB-0ZGB0nD5cT4g@mail.gmail.com>
In-Reply-To: <CAGXu5jLUueSb2u_Ki+nEL1CaBzyZyT1+7rhCB-0ZGB0nD5cT4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39555
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

On 03/23/2014 12:05 AM, Kees Cook wrote:

>>>>> The lkdtm module performs tests against executable memory ranges, so
>>>>> it needs to flush the icache for proper behaviors. Other architectures
>>>>> already export this, so do the same for MIPS.

>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>> This is currently untested! I'm building a MIPS cross-compiler now...
>>>>> If someone can validate this fixes the build when lkdtm is a module,
>>>>> that would be appreciated. :)
>>>>> ---
>>>>>    arch/mips/mm/cache.c |    1 +
>>>>>    1 file changed, 1 insertion(+)

>>>>> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
>>>>> index fde7e56d13fe..b3f1df13d9f6 100644
>>>>> --- a/arch/mips/mm/cache.c
>>>>> +++ b/arch/mips/mm/cache.c
>>>>> @@ -38,6 +38,7 @@ void (*__flush_kernel_vmap_range)(unsigned long vaddr,
>>>>> int
>>>>> size);
>>>>>    void (*__invalidate_kernel_vmap_range)(unsigned long vaddr, int size);
>>>>>
>>>>>    EXPORT_SYMBOL_GPL(__flush_kernel_vmap_range);
>>>>> +EXPORT_SYMBOL_GPL(flush_icache_range);

>>>>      Have you run this thru scripts/checkpatch.pl? It would have told you
>>>> that
>>>> an export should immediately follow the corresponding function body,
>>>> AFAIK.

>>>      Hm, it doesn't now but definitely used to...

>>     Decided to check Documentation/CodingStyle, and it still codifies this:

>> In source files, separate functions with one blank line.  If the function is
>> exported, the EXPORT* macro for it should follow immediately after the
>> closing
>> function brace line.  E.g.:

>> int system_is_up(void)
>> {
>>          return system_state == SYSTEM_RUNNING;
>> }
>> EXPORT_SYMBOL(system_is_up);

> Yup, thanks. I know the style, but it seemed from the source file that
> the style was to declare the function pointers in bulk, and then
> explicitly export them in the next section, so I continued that style.
> For example:

> void (*flush_cache_sigtramp)(unsigned long addr);
> void (*local_flush_data_cache_page)(void * addr);
> void (*flush_data_cache_page)(unsigned long addr);
> void (*flush_icache_all)(void);

> EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
> EXPORT_SYMBOL(flush_data_cache_page);
> EXPORT_SYMBOL(flush_icache_all);

> Regardless, I'm happy to stick it in the middle of the function
> pointers if that's preferred.

    Ah, that's a variable! I didn't realize that. Looking into checkpatch.pl, 
it should warn about variables as well though... but it doesn't.

> -Kees

WBR, Sergei
