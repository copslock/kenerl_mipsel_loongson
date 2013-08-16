Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 14:35:40 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:54234 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822956Ab3HPMfhaHSX2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 14:35:37 +0200
Received: by mail-wi0-f177.google.com with SMTP id hq12so759028wib.10
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/4vrondiS4BSd0mNOA0ZHT23Y3pEWB0mYMnaHGSoIio=;
        b=xEJFub7ka8cadyE2/v4QaREVToU+cHSaUQTX5bIN5jlK4FC///NCq548sAliJc1rqo
         8cCO6gtlMbN+FlmUYRDicE6Rb28RSs2Rsy1y9MTs1fpElyzaDhR3JMK26SbYx5E0/kQE
         p27LX2SD83zrDBKpqGRVrgDlHvNtf+zElWOxV7+T4cC6lx+NPcuYHg/QTd0Ge61OZ/zQ
         AblFgDdE5j3MygvvKQPFFEMLIVcGEjODPbH0DX+fd5VMu72+0G0wK16sBTUE3ZxFlmUg
         vXKqjB1cziKqtUmEl2Z1Jcm3nWzWZK2thVigQiwPKbg9LKBOU2Yqi5mjkjciG2MuWNcn
         NPww==
X-Received: by 10.194.120.68 with SMTP id la4mr944974wjb.33.1376656532111;
 Fri, 16 Aug 2013 05:35:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.162.168 with HTTP; Fri, 16 Aug 2013 05:34:51 -0700 (PDT)
In-Reply-To: <CAG2jQ8iUWU83xWqfYF=ev9Gfxsx6ocBK-0wLaQs8QE=d2+5NmA@mail.gmail.com>
References: <1376384478-27424-1-git-send-email-markos.chandras@imgtec.com>
 <CAOiHx==9E9m5Ds0trutySyaxM0VLJfh1+LKcxYfWFWFt-8dx1A@mail.gmail.com> <CAG2jQ8iUWU83xWqfYF=ev9Gfxsx6ocBK-0wLaQs8QE=d2+5NmA@mail.gmail.com>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Fri, 16 Aug 2013 13:34:51 +0100
Message-ID: <CAG2jQ8gkQgGYcsz4x7wgnhq18EzyK5qe64CLR3+iefqb8hGEvQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: Avoid using unitialized 'reg' variable
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@gmail.com
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

On 15 August 2013 14:42, Markos Chandras <markos.chandras@gmail.com> wrote:
> On 14 August 2013 12:12, Jonas Gorski <jogo@openwrt.org> wrote:
>> Hi,
>>
>> On Tue, Aug 13, 2013 at 11:01 AM, Markos Chandras
>> <markos.chandras@imgtec.com> wrote:
>>> Fixes the following build error:
>>> arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
>>> uninitialized in this function [-Werror=maybe-uninitialized]
>>> arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
>>> In file included from arch/mips/ath79/common.c:20:0:
>>> arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
>>> arch/mips/include/asm/mach-ath79/ath79.h:139:20:
>>> error: 'reg' may be used uninitialized in this function
>>> [-Werror=maybe-uninitialized]
>>> arch/mips/ath79/common.c:90:6: note: 'reg' was declared here
>>>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>> This patch is for the upstream-sfr/mips-for-linux-next tree
>>> ---
>>>  arch/mips/ath79/common.c | 32 ++++++++++++++++++--------------
>>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
>>> index eb3966c..6a8c00f 100644
>>> --- a/arch/mips/ath79/common.c
>>> +++ b/arch/mips/ath79/common.c
>>> @@ -62,20 +62,22 @@ void ath79_device_reset_set(u32 mask)
>>>         u32 reg;
>>>         u32 t;
>>>
>>> -       if (soc_is_ar71xx())
>>> +       if (soc_is_ar71xx()) {
>>>                 reg = AR71XX_RESET_REG_RESET_MODULE;
>>> -       else if (soc_is_ar724x())
>>> +       } else if (soc_is_ar724x()) {
>>>                 reg = AR724X_RESET_REG_RESET_MODULE;
>>> -       else if (soc_is_ar913x())
>>> +       } else if (soc_is_ar913x()) {
>>>                 reg = AR913X_RESET_REG_RESET_MODULE;
>>> -       else if (soc_is_ar933x())
>>> +       } else if (soc_is_ar933x()) {
>>>                 reg = AR933X_RESET_REG_RESET_MODULE;
>>> -       else if (soc_is_ar934x())
>>> +       } else if (soc_is_ar934x()) {
>>>                 reg = AR934X_RESET_REG_RESET_MODULE;
>>> -       else if (soc_is_qca955x())
>>> +       } else if (soc_is_qca955x()) {
>>>                 reg = QCA955X_RESET_REG_RESET_MODULE;
>>> -       else
>>> +       } else {
>>>                 BUG();
>>> +               panic("Unknown SOC!");
>>
>> Both BUG() and panic() seems to be a bit overkill, especially since
>> the panic won't be reached unless BUG is disabled - just the panic()
>> should be enough.
>>
>> Also the panic message isn't very helpful, maybe print the raw id of
>> the SoC here?
>>
>>
>
> Hi Jonas,
>
> Thank you for the review. I will submit a new patch.
>
> --
> Regards,
> Markos Chandras

Hi Jonas,

I had a look at the code again and it seems that reporting the 'id' is
not needed since an unknown SOC will cause a panic
earlier in the boot process. Look at arch/mips/ath79/setup.c, in the
plat_mem_setup function.
This one calls ath79_detect_sys_type which causes the following panic
if an unknown SOC is detected.

panic("ath79: unknown SoC, id:0x%08x", id);

This makes me think that ath79_device_reset_set and
ath79_device_reset_clear should not care about an unknown SOC at all.

-- 
Regards,
Markos Chandras
