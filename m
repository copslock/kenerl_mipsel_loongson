Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2015 08:35:00 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40719 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006779AbbCCHezY4lJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Mar 2015 08:34:55 +0100
Received: by iebtr6 with SMTP id tr6so54798681ieb.7;
        Mon, 02 Mar 2015 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ev1Yd06LnGIbLcLW66iS1H7BHYdcbIfSocSCAtQWf3Q=;
        b=Z6lErnNLKpcoD7uDGbK1RSOPhYyNirdIGz4W+d+HK/b1MVBaqQjjT23RqNr+EQ1iDt
         sP+YNnq0lwSwXYYAsVkMDCFSoxhSZDIZxZfN1w+pvpSs50vYhBBC6Y0D9lXHIqEzxRV+
         sbpm4+P/ccm4p/wRRh1KIZ+DiuGGeCtUbvcBa8qqVQvDn4IvQrJwTWHh52s+p8EKrjBV
         nZuzPsA9vfwowZAnKSEHpZ9qeRlg6znw0+y/BmxmG9KNzZexZ4L2nksoUFo0i3WeEofV
         rWEAB3dNdQr1h3hQYvBugyOtNgsDQEiZ4z2X+SXq70Nsi3x6h41sFhwV/3/skFmC0NK+
         e+kA==
MIME-Version: 1.0
X-Received: by 10.43.171.2 with SMTP id ns2mr73584icc.26.1425368089956; Mon,
 02 Mar 2015 23:34:49 -0800 (PST)
Received: by 10.64.176.238 with HTTP; Mon, 2 Mar 2015 23:34:49 -0800 (PST)
In-Reply-To: <20150303072225.GA8339@mchandras-linux.le.imgtec.org>
References: <1425347348-12334-1-git-send-email-chenhc@lemote.com>
        <20150303072225.GA8339@mchandras-linux.le.imgtec.org>
Date:   Tue, 3 Mar 2015 15:34:49 +0800
X-Google-Sender-Auth: Zybh4ue-8c0DaMoD3CiCX09Jvo0
Message-ID: <CAAhV-H65L_xB2UJo-Zh603GgZqKTyNxpaPb47x4fvG116_6KtQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Call mips_set_personality_fp() in all O32 cases
From:   Huacai Chen <chenhc@lemote.com>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46094
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

It seems your patch is better, please ignore mine.

Huacai

On Tue, Mar 3, 2015 at 3:22 PM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> On Tue, Mar 03, 2015 at 09:49:08AM +0800, Huacai Chen wrote:
>> Commit 46490b572544f (MIPS: kernel: elf: Improve the overall ABI and
>> FPU mode checks) assumes mips_set_personality_fp() is only needed in
>> CONFIG_MIPS_O32_FP64_SUPPORT case. However, this assumption is wrong,
>> because O32 binaries always need the correct thread flags to set
>> FR/FRE, whether CONFIG_MIPS_O32_FP64_SUPPORT is configured or not.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/kernel/elf.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
>> index d2c09f6..cec5bc3 100644
>> --- a/arch/mips/kernel/elf.c
>> +++ b/arch/mips/kernel/elf.c
>> @@ -245,7 +245,7 @@ void mips_set_personality_fp(struct arch_elf_state *state)
>>        * not be worried about N32/N64 binaries.
>>        */
>>
>> -     if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT))
>> +     if (!config_enabled(CONFIG_32BIT) && !config_enabled(CONFIG_MIPS32_O32))
>>               return;
>>
>>       switch (state->overall_fp_mode) {
>> --
>> 1.7.7.3
>>
>>
>>
>>
> Hi,
>
> I have already posted a patch for this problem. Could you try that instead?
>
> http://patchwork.linux-mips.org/patch/9344/
>
> --
> markos
>
