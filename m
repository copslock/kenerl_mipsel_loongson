Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Mar 2017 08:15:52 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:35942
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbdCHHPlO0dvI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Mar 2017 08:15:41 +0100
Received: by mail-wm0-x241.google.com with SMTP id v190so4455105wme.3;
        Tue, 07 Mar 2017 23:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FdYG/2dpz/yeF8cMNV9syVVvqVsOrnRDcPYfGy8FLxY=;
        b=SbFzDgrnZhlPlRV5mUpGzgRe/kxdd3P8EtGr0lfVG1eXKC+mi+YuaH4QRE7qkdUBnO
         Q4OFWacQdwA8YqtI+U7rYvHTUQXknJzPw8svK6t6rFXsP5fn0UIXRdI/7mpABBBFKENM
         7uJCVYmRpoIafFB+Q8/7tLUzh5SJAgWJ1WbjSSMw4xwGBgfKJoSlhL5BHMuzZJw7r5kC
         GXGg47BURw+756AADA9QE3VplYWPv/pdW82LgCTS1j5j24AzeEP0RDjnrQC2uN/qcArA
         K3ozdTl074cEewL44KU5PdGLreeTFUPpgf+2I3J3mFIL2n5Rv5YobhsAxjVgtGrilHeu
         ewNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FdYG/2dpz/yeF8cMNV9syVVvqVsOrnRDcPYfGy8FLxY=;
        b=mKgQwMTl7rEBTachTEGZz2Xxo/qkJIEobWFWTujn3JMkibeU/e+5ZFFhGMTfUTCBO3
         zveR9HPH966zKHEcVjG867gMuV/g/72JepnExZmub+TsoFRMyDTI9/Pdz97Z5kmfP6yD
         gXrejZz8OvPwpJBgMYw7aRWGYXZtPnYz7xS6p+xEWq5Eh40iEAbeEgjmkRMOM3AGQ61Q
         ljK1oLEumlm5htcdv28cl4t+FcYOe/sSxK/WvdAmiz4AyGu5IYy8YHDTdRFvELJpeaLW
         GyT/Rh5He71BcsYTCWOrn11Zjtz6NhtM8E7vE6YsxvO+NbAz2rkTeXrqtk3rUWZGDPzj
         0y0w==
X-Gm-Message-State: AMke39lAqB2YTDYEmyE3l/vFIaa3rBTHV3L1vgwAIWu6Gp7e2GhlScA+Lni1fpdJoOiOLgPPXUIrVfhhMF2e8g==
X-Received: by 10.28.35.151 with SMTP id j145mr21115779wmj.50.1488957335883;
 Tue, 07 Mar 2017 23:15:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.214 with HTTP; Tue, 7 Mar 2017 23:15:35 -0800 (PST)
In-Reply-To: <CAAhV-H7bRAffiZ8bVxM++HK2Ch5fFfM2RVObGXCrdv9SN2B0pg@mail.gmail.com>
References: <1479093165-625-1-git-send-email-chenhc@lemote.com>
 <1479093165-625-3-git-send-email-chenhc@lemote.com> <CAKcpw6V18V3pr777sPjNHRyi7gO1DVAQdp7NzP5N2XNOpW0s6A@mail.gmail.com>
 <CAAhV-H7bRAffiZ8bVxM++HK2Ch5fFfM2RVObGXCrdv9SN2B0pg@mail.gmail.com>
From:   YunQiang Su <wzssyqa@gmail.com>
Date:   Wed, 8 Mar 2017 15:15:35 +0800
Message-ID: <CAKcpw6Up2S6X+-DdtYbfaWDn6YiwCLCsgLqYS35kCyDQk5HX9A@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] MIPS: Loongson: Add NMI handler support
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

On Wed, Mar 8, 2017 at 2:47 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Maybe your Loongson-3A1000 has some hw problems.:)

Maybe so. I just run it with Debian's official kernel (4.9) without this patch,
It also hang with this problem.

While 4.7 seems working better.

>
> Huacai
>
> On Tue, Mar 7, 2017 at 9:38 PM, YunQiang Su <wzssyqa@gmail.com> wrote:
>> With this patch, I met a problem on Loongson 3A 1000:
>>
>> kernel: [1692。089996] NMI watchdog: BUG: soft lockup - CPU#0 stuck for
>> 22s! [apt-get: 9687]
>>
>> I will try to recomplie the kernel without this patch.
>>
>> It seems that it works well on Loongson 3A 3000.
>>
>> On Mon, Nov 14, 2016 at 11:12 AM, Huacai Chen <chenhc@lemote.com> wrote:
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> ---
>>>  arch/mips/loongson64/common/init.c | 13 +++++++++++++
>>>  1 file changed, 13 insertions(+)
>>>
>>> diff --git a/arch/mips/loongson64/common/init.c b/arch/mips/loongson64/common/init.c
>>> index 9b987fe..6ef1712 100644
>>> --- a/arch/mips/loongson64/common/init.c
>>> +++ b/arch/mips/loongson64/common/init.c
>>> @@ -10,13 +10,25 @@
>>>
>>>  #include <linux/bootmem.h>
>>>  #include <asm/bootinfo.h>
>>> +#include <asm/traps.h>
>>>  #include <asm/smp-ops.h>
>>> +#include <asm/cacheflush.h>
>>>
>>>  #include <loongson.h>
>>>
>>>  /* Loongson CPU address windows config space base address */
>>>  unsigned long __maybe_unused _loongson_addrwincfg_base;
>>>
>>> +static void __init mips_nmi_setup(void)
>>> +{
>>> +       void *base;
>>> +       extern char except_vec_nmi;
>>> +
>>> +       base = (void *)(CAC_BASE + 0x380);
>>> +       memcpy(base, &except_vec_nmi, 0x80);
>>> +       flush_icache_range((unsigned long)base, (unsigned long)base + 0x80);
>>> +}
>>> +
>>>  void __init prom_init(void)
>>>  {
>>>  #ifdef CONFIG_CPU_SUPPORTS_ADDRWINCFG
>>> @@ -40,6 +52,7 @@ void __init prom_init(void)
>>>         /*init the uart base address */
>>>         prom_init_uart_base();
>>>         register_smp_ops(&loongson3_smp_ops);
>>> +       board_nmi_handler_setup = mips_nmi_setup;
>>>  }
>>>
>>>  void __init prom_free_prom_memory(void)
>>> --
>>> 2.7.0
>>>
>>>
>>>
>>>
>>
>>
>>
>> --
>> YunQiang Su
>>



-- 
YunQiang Su
