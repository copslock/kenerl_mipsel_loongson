Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Oct 2014 02:39:21 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37095 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010649AbaJZBjSX72tI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Oct 2014 02:39:18 +0100
Received: by mail-ig0-f173.google.com with SMTP id r10so1447630igi.0
        for <multiple recipients>; Sat, 25 Oct 2014 18:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8258ABwF4SBAda53lDOS09w0SJhNJ2BaV7t09+1MqCg=;
        b=soMhnoJGK/8DOY6tjGKDhYT6rSrrD8n+K6TarWVVc4Nu+MHUlZNwrhyMBZeW5VSw/9
         jG4SSfKQNxwutw6D7yQga2CL2dgYmkTC3uoz8uRepIMKDTWV7IH85pXaBN89Q6LmFaYg
         opIjoRdzFMya2p8Xnao5PsZ6y5yzjlZLX52soTiI5ySPkdBaSKpKcNVaUTFu62itBn4f
         u/pSDIshseD6KhmaN8FkDkp6uG6zTE4UAXY+0L+HucyOsVbNlL4Tp+IV+c3LFzOGPbvL
         Y/KdDrQIuL4d7ktxHkoUDqkgNhRPaIBO+Hk3xnorRoAa6L2geyxdlUlKJGTpmJ4tLrmH
         LcEA==
MIME-Version: 1.0
X-Received: by 10.42.184.6 with SMTP id ci6mr11342894icb.33.1414287552258;
 Sat, 25 Oct 2014 18:39:12 -0700 (PDT)
Received: by 10.64.128.167 with HTTP; Sat, 25 Oct 2014 18:39:12 -0700 (PDT)
In-Reply-To: <540042D9.1050208@imgtec.com>
References: <1409283416-16926-1-git-send-email-chenhc@lemote.com>
        <540042D9.1050208@imgtec.com>
Date:   Sun, 26 Oct 2014 09:39:12 +0800
Message-ID: <CAAhV-H7UR4L5F21QLhaAUcsNO0ow_6zcSSLsYMXCW_jWWhf3QQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson: Fix the write-combine CCA value setting
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Ralf,

Can this patch be merged in 3.18?

Huacai

On Fri, Aug 29, 2014 at 5:07 PM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 08/29/2014 04:36 AM, Huacai Chen wrote:
>> All Loongson-2/3 processors support _CACHE_UNCACHED_ACCELERATED, not
>> only Loongson-3A.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
> Hi,
>
> Thanks for the patch.
>
> Ralf, perhaps you can merge it with
>
> http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commit;h=2ac2118deca510649c15b0ba6ce433c37bba345c
>
> Thanks in advance.
>
> --
> markos
>
