Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 13:46:35 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54052 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2FSLqY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 13:46:24 +0200
Received: by lbbgg6 with SMTP id gg6so5938017lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S10exSWCC1hqq4FXOq2cp4XzPCuM9JOG3w2k9UItOEE=;
        b=hx+KQn+G5F/BMF353XucjKJTqVuv6HTExlSXPOlEFF8LWBF/+GL0rlzuN5iv3KxXc/
         I/WZ3xcMwElhjiBn7gJ40MxA+29B886AjD7nSRN7BOl7GE57eaF2chQ8GXgdqw4zTAK9
         o+H4c6q2Fqrb0JY6inSFROgRvv7eMoeh9qgr+Pe76JxIYd1v+RFqNP1/594dlUKgkc5y
         k275MJkiyj3/wKNp3gIrE5wumgYBKdkH9VrbZfsGBwoilqzzC/Xox6ueJjCOX0NO6CTY
         xdWRoxu8v76uMLCLQg1EDOrdn9pi43osk+z9BlDHuc7ZYHAhcA230B2HdrXaykDCMigM
         CytQ==
MIME-Version: 1.0
Received: by 10.152.46.6 with SMTP id r6mr18229672lam.7.1340106379418; Tue, 19
 Jun 2012 04:46:19 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 04:46:19 -0700 (PDT)
In-Reply-To: <4FE05DAB.2070406@mvista.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-4-git-send-email-chenhc@lemote.com>
        <4FE05DAB.2070406@mvista.com>
Date:   Tue, 19 Jun 2012 19:46:19 +0800
Message-ID: <CAAhV-H65y8PEpf7ZU+jEH-ZRHwr_GARPYHDgVamMmjPnF-yfag@mail.gmail.com>
Subject: Re: [PATCH V2 03/16] MIPS: Loongson 3: Add Lemote-3A machtypes definition.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33721
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
Return-Path: <linux-mips-bounce@linux-mips.org>

OK, I will do this later.
Thanks.

On Tue, Jun 19, 2012 at 7:08 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 19-06-2012 10:50, Huacai Chen wrote:
>
>> Add three Loongson 3 based machine types:
>> MACH_LEMOTE_A1004 is laptop;
>> MACH_LEMOTE_A1101 is mini-itx;
>> MACH_LEMOTE_A1205 is all-in-one machine.
>
>
>> The most significant differrent between A1004 and A1101/A1205 is
>> the laptop has EC but others don't.
>
>
>> Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> Signed-off-by: Hua Yan<yanh@lemote.com>
>
> [...]
>
>
>> diff --git a/arch/mips/loongson/common/machtype.c
>> b/arch/mips/loongson/common/machtype.c
>> index 2efd5d9..e377b44 100644
>> --- a/arch/mips/loongson/common/machtype.c
>> +++ b/arch/mips/loongson/common/machtype.c
>> @@ -25,8 +25,11 @@ static const char *system_types[] = {
>>        [MACH_LEMOTE_ML2F7]             "lemote-mengloong-2f-7inches",
>>        [MACH_LEMOTE_YL2F89]            "lemote-yeeloong-2f-8.9inches",
>>        [MACH_DEXXON_GDIUM2F10]         "dexxon-gdium-2f",
>> -       [MACH_LEMOTE_NAS]               "lemote-nas-2f",
>> +       [MACH_LEMOTE_NAS]               "lemote-nas-2f",
>>        [MACH_LEMOTE_LL2F]              "lemote-lynloong-2f",
>> +       [MACH_LEMOTE_A1004]             "lemote-3a-notebook-a1004",
>> +       [MACH_LEMOTE_A1101]             "lemote-3a-itx-a1101",
>> +       [MACH_LEMOTE_A1205]             "lemote-2gq-aio-a1205",
>>        [MACH_LOONGSON_END]             NULL,
>
>
>   It's preferred that indentation is done with tabs, not spaces.
>
> WBR, Sergei
