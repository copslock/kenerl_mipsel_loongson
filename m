Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2012 03:19:36 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:60530 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2G2BT3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jul 2012 03:19:29 +0200
Received: by vbbfo1 with SMTP id fo1so3839878vbb.36
        for <multiple recipients>; Sat, 28 Jul 2012 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w/fxVMJTjCrLL5JlIZYI4UrXwkzQUAUCVxpwEUgC4ro=;
        b=STzRT6Rez3VYdQqyUBe/Sr96OpWUbVnI12xO8bcR6TXRcKvmpJnG2IXRPzhcTM2IR2
         fszftlZUYOyD3YuaTNqCLTMDqHjniv+hsXV3L5lUCHxxOd2VtvPciq55U5BiVWLy9OF+
         QZrbqV4E6FSeB/fIS8xv2ZDGQ4UXjNKau204sz+XMolVBsIik+j4T67swp7/ageP6T1G
         UG775vOHWGeP/w9nCruE3Ij5LbQwwcADvBbdTCtbIkSeOb5/+LZMPeIArRUuOsK8acnA
         e94u8CvoNG0hgSk1BCAbZLFVTkEywfGD1me47w/kXOobI0flfSZn7If4FD32HgEH83UH
         1LSQ==
MIME-Version: 1.0
Received: by 10.220.247.148 with SMTP id mc20mr4249946vcb.50.1343524763343;
 Sat, 28 Jul 2012 18:19:23 -0700 (PDT)
Received: by 10.220.1.210 with HTTP; Sat, 28 Jul 2012 18:19:23 -0700 (PDT)
In-Reply-To: <CAJFZqHxBE6wc2hJd=mKfx9D59S73qxJZFvbfqgmLkWZvtR7f_A@mail.gmail.com>
References: <1341203670-17544-1-git-send-email-roy.qing.li@gmail.com>
        <CAJFZqHxBE6wc2hJd=mKfx9D59S73qxJZFvbfqgmLkWZvtR7f_A@mail.gmail.com>
Date:   Sun, 29 Jul 2012 09:19:23 +0800
Message-ID: <CAJd=RBD0Pd2Rx8qijj7GK8hWQBvEBXRzXFQAbtKu5X1wb9EhEQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix tc_id calculation
From:   Hillf Danton <dhillf@gmail.com>
To:     RongQing Li <roy.qing.li@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
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

On Sat, Jul 28, 2012 at 5:08 PM, RongQing Li <roy.qing.li@gmail.com> wrote:
> Any advice
>
> 2012/7/2  <roy.qing.li@gmail.com>:
>> From: RongQing.Li <roy.qing.li@gmail.com>
>>
>> Now the tc_id is:
>>   (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
>> After substitute macro:
>>   (read_c0_tcbind() >> 21) & ((0xff) << 21)
>> It should be:
>>   (read_c0_tcbind() & ((0xff)<< 21)) >>21
>>
>> Signed-off-by: RongQing.Li <roy.qing.li@gmail.com>
>> ---

Good catch ;)

Thanks,
               Hillf


>>  arch/mips/kernel/smp-cmp.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/kernel/smp-cmp.c b/arch/mips/kernel/smp-cmp.c
>> index e7e03ec..afc379c 100644
>> --- a/arch/mips/kernel/smp-cmp.c
>> +++ b/arch/mips/kernel/smp-cmp.c
>> @@ -102,7 +102,7 @@ static void cmp_init_secondary(void)
>>         c->vpe_id = (read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE;
>>  #endif
>>  #ifdef CONFIG_MIPS_MT_SMTC
>> -       c->tc_id  = (read_c0_tcbind() >> TCBIND_CURTC_SHIFT) & TCBIND_CURTC;
>> +       c->tc_id  = (read_c0_tcbind() & TCBIND_CURTC) >> TCBIND_CURTC_SHIFT;
>>  #endif
>>  }
>>
>> --
>> 1.7.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
