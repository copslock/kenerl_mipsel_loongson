Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 07:47:16 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:34154
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdCHGrHb3eBI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Mar 2017 07:47:07 +0100
Received: by mail-it0-x244.google.com with SMTP id r141so3535945ita.1;
        Tue, 07 Mar 2017 22:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JlKfiAQ7yJ0tDXtmzu85AS2tzireOM48EJUCL+62Fz8=;
        b=nYwF0+40y6JuqISoJz5S7KhB03F6wlLLHRBkcmN9v553jvPgwL8tVavWaJeYUAPr7b
         5K7TBpr34Gzc5nGMEvf3YNM6+1Q/4HBknXt/6uMRSMI9B9qEBxhDy2FjDcJIgxh5GH93
         DcXlo2wSvto1aiE4y88GbnqJ9IXz/n/DNInLZiP7GZL5dcjtcy7ogHu60R0dEI0f9yOQ
         hIwUxyVoi70cRnTWwSvX/IVHzaYM+dsu1Qo0/B64dPmiStc6Spx3ikakXqWpYA5Kjj0v
         XA9HZpqxogtkS8Yt/QmN23ov1WicQKjLSXzeBfKPagSwwnZziWToIu1yI2g6M43EoSm7
         TU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JlKfiAQ7yJ0tDXtmzu85AS2tzireOM48EJUCL+62Fz8=;
        b=S3mXFMkrB9Avp61IEZSdXaEMXMH2VgoYkReOfoEuOqjz6hAg/TP45WUy31NwQwlkr+
         lFs8hDbg5gcWpN0m6LQOw6ZEdojzcyzmoGieRvorF/DmXfhPYCmL9AwpwCUQwBPzilTx
         S9Qza273IA/EHvqZZfQ0RN64avmBgXc/IIMhYtXGjtGdnTJNhOu3sqlr2Odv73JyiZ7G
         Wh/kq2adWBjOg0F/8sGC2qe9qMGYg83Ix5nSJKLofBi0FhddLhnTHL0JBe1Ob/L2JV+N
         +nOtgTMcwJfUhPf796kQw5kybCfhR8WPPcO5KXua11O3dgvq2cl5ReO3I3n1NSiQBsYg
         ND+Q==
X-Gm-Message-State: AMke39kzGu6HXkR7Jqjhixqb6hVf64B6mAPKeilX2MUwi9BRF29Zxqx20D6d7NehYY31f6XbUjaqzzDsL8I4yQ==
X-Received: by 10.36.110.10 with SMTP id w10mr14175202itc.88.1488955620884;
 Tue, 07 Mar 2017 22:47:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.36.208.3 with HTTP; Tue, 7 Mar 2017 22:47:00 -0800 (PST)
In-Reply-To: <CAKcpw6V18V3pr777sPjNHRyi7gO1DVAQdp7NzP5N2XNOpW0s6A@mail.gmail.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com>
 <1479093165-625-3-git-send-email-chenhc@lemote.com> <CAKcpw6V18V3pr777sPjNHRyi7gO1DVAQdp7NzP5N2XNOpW0s6A@mail.gmail.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 8 Mar 2017 14:47:00 +0800
X-Google-Sender-Auth: ruYb_YYHJtyONdhH3ArfPeo0BQk
Message-ID: <CAAhV-H7bRAffiZ8bVxM++HK2Ch5fFfM2RVObGXCrdv9SN2B0pg@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] MIPS: Loongson: Add NMI handler support
To:     YunQiang Su <wzssyqa@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Maybe your Loongson-3A1000 has some hw problems.:)

Huacai

On Tue, Mar 7, 2017 at 9:38 PM, YunQiang Su <wzssyqa@gmail.com> wrote:
> With this patch, I met a problem on Loongson 3A 1000:
>
> kernel: [1692。089996] NMI watchdog: BUG: soft lockup - CPU#0 stuck for
> 22s! [apt-get: 9687]
>
> I will try to recomplie the kernel without this patch.
>
> It seems that it works well on Loongson 3A 3000.
>
> On Mon, Nov 14, 2016 at 11:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/loongson64/common/init.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/mips/loongson64/common/init.c b/arch/mips/loongson64/common/init.c
>> index 9b987fe..6ef1712 100644
>> --- a/arch/mips/loongson64/common/init.c
>> +++ b/arch/mips/loongson64/common/init.c
>> @@ -10,13 +10,25 @@
>>
>>  #include <linux/bootmem.h>
>>  #include <asm/bootinfo.h>
>> +#include <asm/traps.h>
>>  #include <asm/smp-ops.h>
>> +#include <asm/cacheflush.h>
>>
>>  #include <loongson.h>
>>
>>  /* Loongson CPU address windows config space base address */
>>  unsigned long __maybe_unused _loongson_addrwincfg_base;
>>
>> +static void __init mips_nmi_setup(void)
>> +{
>> +       void *base;
>> +       extern char except_vec_nmi;
>> +
>> +       base = (void *)(CAC_BASE + 0x380);
>> +       memcpy(base, &except_vec_nmi, 0x80);
>> +       flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
>> +}
>> +
>>  void __init prom_init(void)
>>  {
>>  #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
>> @@ -40,6 +52,7 @@ void __init prom_init(void)
>>         /*init the uart base address */
>>         prom_init_uart_base();
>>         register_smp_ops(&loongson3_smp_ops);
>> +       board_nmi_handler_setup = mips_nmi_setup;
>>  }
>>
>>  void __init prom_free_prom_memory(void)
>> --
>> 2.7.0
>>
>>
>>
>>
>
>
>
> --
> YunQiang Su
>
