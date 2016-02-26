Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Feb 2016 06:35:55 +0100 (CET)
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37480 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27005162AbcBZFfw34qgE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Feb 2016 06:35:52 +0100
Received: by mail-wm0-f44.google.com with SMTP id g62so55812587wme.0;
        Thu, 25 Feb 2016 21:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=S8ivwE5FKa9bijF7v50H3xwQG0CWaFUHLKvXOvUzcxg=;
        b=kdYEnZ+TENo/p8m8YxEVnjsL4LhuUnbAzHKpXh6G26cGOFxWigNoTXqmkuYqJJ3xfh
         OxwJqspI45udn7NeNxL7JCaZvIhAFsbOrQNhvbHl1xSXqROmepsmw6C1HO24c8ZkIoEI
         Jtvd2WCFL03a7PtWw7guQJg8umAPkrjOlTLs8BdmwmiWs8jikRMTqfmH5Bz2RJE4WZPR
         F1iwRU2do5OCXL108dczncbEPH5adit28LExitSYuPbRP3GR+Ma1wDrxxBylSyxJhBHZ
         AXc1LLvFInHRCtieHwgEcXJg73ZXqK7cySkiYkoFsFzqB2i8+cC1s+AFLAdabmwTO1N7
         mnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=S8ivwE5FKa9bijF7v50H3xwQG0CWaFUHLKvXOvUzcxg=;
        b=P4qjDiTAVrh5YOCoQnV0+QzdsOKURwWJG8dkiltujDBTu8rBpBZXeT/5EkqJUJmtuw
         Dhq3EBW0wCiXndXxnTzU2yF/s+02O37TyjuXhkYYF/+aTncCfjOHUBnmxAzhOHBC1dN7
         yNk7dt3Er2PvadYsqrdV9M/ROmVDQlmy8np6pH9v94ul+sVFUC6p9Vavp96AGDsNihDO
         9qN8eumKEiITaCiHlBGY32MNoryXxqJ3Esv6yELdVyr5P1LAs9KeQBgRgnU8y15fd5l8
         Hb8rFVYWD5dACJ45zBxPDlx++7bIn81igsbVmKRDUPrphf0FYqYMcKaBF3v0JZnyBBri
         ZNWg==
X-Gm-Message-State: AG10YOSDUwhyoearlFL13wEm1w3dCdGn7nFnntQeuhpva5DgxcpWqCuMQfT5gk0L48k1eczeV9QZgltFAkx/Bw==
MIME-Version: 1.0
X-Received: by 10.194.220.230 with SMTP id pz6mr48183943wjc.39.1456464947302;
 Thu, 25 Feb 2016 21:35:47 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Thu, 25 Feb 2016 21:35:47 -0800 (PST)
In-Reply-To: <CAAhV-H4nc_z1OWF2JLJ2bfwTcCkYXRZ8CTc1kh3zRs5WHQKKQw@mail.gmail.com>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-3-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250050170.15885@tp.orcam.me.uk>
        <CAAhV-H5NW7NG0C9OU-qjCzPO-CB+pWmsh0RC0ZmKKmUx0U75=Q@mail.gmail.com>
        <alpine.DEB.2.00.1602251116010.15885@tp.orcam.me.uk>
        <CAAhV-H4nc_z1OWF2JLJ2bfwTcCkYXRZ8CTc1kh3zRs5WHQKKQw@mail.gmail.com>
Date:   Fri, 26 Feb 2016 13:35:47 +0800
X-Google-Sender-Auth: pyoADL-O7CuGpW9UOn-j5nwmVTE
Message-ID: <CAAhV-H4UEJC=QsEbNaGddEb7LtQ9-ntxVRbM257OmhQbcGJDEQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Introduce cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52329
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

Not all handlers have the same prototype as cache_noop(), so what should I do?

Huacai

On Thu, Feb 25, 2016 at 8:53 PM, Huacai Chen <chenhc@lemote.com> wrote:
> OK, thanks. I will consider setting the relevant handlers to
> cache_noop in r4k_cache_init().
>
> On Thu, Feb 25, 2016 at 7:16 PM, Maciej W. Rozycki <macro@imgtec.com> wrote:
>> On Thu, 25 Feb 2016, Huacai Chen wrote:
>>
>>> Joshua Kinard suggest me to split the patch, which you can see here:
>>> https://patchwork.linux-mips.org/patch/12324/
>>> If it is better to not split, please see my V2 patchset.
>>
>>  Splitting is the correct action, however please answer my questions as
>> well.
>>
>>   Maciej
>>
