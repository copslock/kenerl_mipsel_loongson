Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 11:42:41 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:41127 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903879Ab2BCKme convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Feb 2012 11:42:34 +0100
Received: by wgbdt11 with SMTP id dt11so1074375wgb.0
        for <multiple recipients>; Fri, 03 Feb 2012 02:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FVgMbIA1FVppaAdeKfcL31nWUi6EVATjhJvJRaP7aLg=;
        b=Cjo8tALm0wxf3FKmRHeEtVYOcB+0a2TEC5o2ArPfWSb1JJ8BilwOTlbF22gAKXsGIY
         xG8eHAroOPRZWVRj+He2CLbJQpdwlm2B4gm1z6vgofGjJn2IyT9ioK84iHCShB2lAzEK
         iZZygAW6CgPsTWAvslv1OUca/UVMtyfwB+USQ=
MIME-Version: 1.0
Received: by 10.180.92.226 with SMTP id cp2mr10534461wib.10.1328265749371;
 Fri, 03 Feb 2012 02:42:29 -0800 (PST)
Received: by 10.223.102.80 with HTTP; Fri, 3 Feb 2012 02:42:29 -0800 (PST)
In-Reply-To: <4F2BB715.8090803@mvista.com>
References: <1328255503-17575-1-git-send-email-xiyou.wangcong@gmail.com>
        <4F2BB715.8090803@mvista.com>
Date:   Fri, 3 Feb 2012 11:42:29 +0100
X-Google-Sender-Auth: 0VIJ_JdIqTzDV-8ukczOExntKlU
Message-ID: <CAMuHMdVU4TNg=cdmRyH1DhhHKkhaBtcdS8Q+5wtUZTyV+nRg5g@mail.gmail.com>
Subject: Re: [Patch] mips: do not redefine BUILD_BUG()
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Hillf Danton <dhillf@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Feb 3, 2012 at 11:29, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> include/linux/kernel.h:717:1: error: "BUILD_BUG" redefined
>> arch/mips/include/asm/page.h:43:1: error: this is the location of the
>> previous definition

>> --- a/arch/mips/include/asm/page.h
>> +++ b/arch/mips/include/asm/page.h
>> @@ -39,9 +39,7 @@
>>  #define HPAGE_MASK    (~(HPAGE_SIZE - 1))
>>  #define HUGETLB_PAGE_ORDER    (HPAGE_SHIFT - PAGE_SHIFT)
>>  #else /* !CONFIG_HUGETLB_PAGE */
>> -# ifndef BUILD_BUG
>
>   Not clear why we get the error if we're protected with #ifndef...

Because this is the first definition. It's redefined later.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
