Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 06:41:37 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35135 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007280AbcBYFlePGaXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 06:41:34 +0100
Received: by mail-wm0-f68.google.com with SMTP id g62so1566312wme.2;
        Wed, 24 Feb 2016 21:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mbOl/VkZXCroxUjsGVtZ14cmOCKO0OsQfL3XMWuAMKc=;
        b=k9w9+XguXAkuFbBnhYlT2FL6FW0ov45bJ48266SoxtPbBGHDgyQ+hVimsRfVdZQ0df
         zmFjdyxjVm/RrwJH41bZrIPdVBx0HpjWC7RlRDH6yvfRDFJY+mvg9V9QZHfovxQ4mcYM
         mt+MMzLN7U3KoTnEd2aZpCZNMoc9Dj1D1NJx2yRRLHvjhZv3xNTLFXJvk0yOombaNgU+
         0E302HD9smLrddNOmblbVvZPX8S5BrZTa9rt5pL344e4nZvUnQAhf7FYRgh2w9UUVtPf
         z1jwz3Wl8Khnnn705XMBKBDLtgWY+SQyDRVPWBMEw10u/M3fQ8WIfOV6UHdRRYRCkNnk
         7ScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mbOl/VkZXCroxUjsGVtZ14cmOCKO0OsQfL3XMWuAMKc=;
        b=ZlvMVXsfZabIaE7OK6z7HKV5ynUN8VgsJlxcVuTw8GD1Y3yhfMR/AR0esaLRpDIp0w
         RbIf70KWqaAVwwfUG9xSM8YvkAogY4wngrnNcMXS6VQO3FN2Dm6XZgen3IrDjKYbshnG
         vEz/+MDE6Y27MFLvp+fnopm4mcvfuuxChsTR+F+iOm+cGJuSmGK4eE5JPYTeMIYox2+9
         JLz18a2jrU1GNaEAdWacMIRzHRvkmb68UgbburOeciGI0ei2RaEhMPYibRZI54tuSd0X
         6zc+NUtf3EZc5G5QuXGTEQsVf67kzFGBkse9VMS+DGxs07ipdn7+turFnxDDAIqWq1se
         7F3Q==
X-Gm-Message-State: AG10YOSxjZTLEqn16sxETVUieKXFZH0o6Wnn2KyqPdWlGn6Y9aN0siNdd4u3tu83E+x0Cal5ITYlZctOt+SD8g==
MIME-Version: 1.0
X-Received: by 10.194.220.230 with SMTP id pz6mr42582757wjc.39.1456378889051;
 Wed, 24 Feb 2016 21:41:29 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Wed, 24 Feb 2016 21:41:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-8-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk>
Date:   Thu, 25 Feb 2016 13:41:29 +0800
X-Google-Sender-Auth: bco7yfKlr3GcGtpULzLM4cjrb6Q
Message-ID: <CAAhV-H5rGWVooK5RaWxPDYV2dYBes9JetmvCisCsF1ouLWiKDA@mail.gmail.com>
Subject: Re: [PATCH V3 5/5] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52230
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

 Hi, Maciej,

Please read my explaination: New Loongson 3 has a bug that di
instruction can not save the irqflag, so arch_local_irq_save() is
modified. Since CPU_MIPSR2 is selected by
CONFIG_LOONGSON3_ENHANCEMENT, generic kernel doesn't use ei/di at all
(because old Loongson 3 doesn't support ei/di at all).

Huacai

On Thu, Feb 25, 2016 at 8:49 AM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Wed, 24 Feb 2016, Huacai Chen wrote:
>
>> This patch introduce a config option, CONFIG_LOONGSON3_ENHANCEMENT, to
>> enable those enhancements which cannot be probed at run time. If you
>> want a generic kernel to run on all Loongson 3 machines, please say 'N'
>> here. If you want a high-performance kernel to run on new Loongson 3
>> machines only, please say 'Y' here.
> [...]
>> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
>> index 65c351e..9d3610b 100644
>> --- a/arch/mips/include/asm/irqflags.h
>> +++ b/arch/mips/include/asm/irqflags.h
>> @@ -41,7 +41,12 @@ static inline unsigned long arch_local_irq_save(void)
>>       "       .set    push                                            \n"
>>       "       .set    reorder                                         \n"
>>       "       .set    noat                                            \n"
>> +#if defined(CONFIG_CPU_LOONGSON3)
>> +     "       mfc0    %[flags], $12                                   \n"
>> +     "       di                                                      \n"
>> +#else
>>       "       di      %[flags]                                        \n"
>> +#endif
>>       "       andi    %[flags], 1                                     \n"
>>       "       " __stringify(__irq_disable_hazard) "                   \n"
>>       "       .set    pop                                             \n"
>
>  This part does not appear related to CONFIG_LOONGSON3_ENHANCEMENT --
> please either fold it into one of the other changes in the set, if there's
> one it really belongs to, or make it an entirely separate change
> otherwise.
>
>   Maciej
>
