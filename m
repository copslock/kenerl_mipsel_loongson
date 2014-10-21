Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 22:04:19 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:58826 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012068AbaJUUER2q66D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 22:04:17 +0200
Received: by mail-qa0-f49.google.com with SMTP id f12so1397798qad.8
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=u+WEpeuDMHhTlbaVFQNQwK05bC3Ye9oJqDgo7N3ZDJ0=;
        b=a9seZyuQ0R7cjNGHvWEKHjDuSZCcETmokANAXgdx52ISSKxi/D4FVOQAYuy9hYuG92
         Q5SI4t7GLfCZj2QWqhFQqfo1rGBYdEMbRx81TX2ZlXhJ37L4FEsYWfBZxcfapOWrV8OU
         F1ez1dcvKkzbSUNIyaCVSjZDqjy2HLNcQWHWjNaVLR6z97E9JBuSpdlZqqWQZTBTgeGF
         W9HYmOuJPtmoiVHDk2fbFNkjvOGt7BLy1YUTsFER57twjUmC8SHCvVjIf1l+c7TPOIH2
         DxJG0FSMdQWWGBa4epAIfSvne3XkNrnTybOyWFKNXvOhqs0nVgZhUnG1ZgkYrcgNJpiW
         fu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=u+WEpeuDMHhTlbaVFQNQwK05bC3Ye9oJqDgo7N3ZDJ0=;
        b=hczk/uWF2VpKjO0DY6rn6PKZWnZnEuMM88x+p4TsbuuIT3WWOwBZMCI6ugsrTG3PL3
         fS/S2/1426FsSeCcofauQ812kzYK9zbCNQEzXgyRI6w29poLfuf/gAewTMIkasM94NTz
         MHyzhUvvS9Jl5vpFVJPSKHjc4cApz3oLMZBzkqEzJ2ZuLfW4mIk3DxqpzQvtYCPF+FLi
         kvhv7yGBLs3RdjdZI//LsMgAYE/8kp5ksdFKcvPzXe/p3dMIi7B5AjgBHWs8cVqzRpZu
         oPwgYB2I7aDqxsSqYwh3gN/xP9IBUB7VSraLh2A1DkLFk5fAqEwtZJoZBft2myBG6OeM
         2BUQ==
X-Gm-Message-State: ALoCoQks9+MA6HLskDuUPKprE3qsP4OE9Y++TXwGdlOj8KwnV2Yuk5nosmL/9uAfHUkHeZpEgQJC
X-Received: by 10.140.82.144 with SMTP id h16mr45269625qgd.40.1413921851245;
 Tue, 21 Oct 2014 13:04:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.164.210 with HTTP; Tue, 21 Oct 2014 13:03:50 -0700 (PDT)
In-Reply-To: <CAErSpo6KnNKz8z1dcHqKTO6450MfGRm0nLk65sTvAcnUmGqiQQ@mail.gmail.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170602.4063.5577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CAErSpo7K2dhNWz7HL_JCrB6pvq5+aeOYCwD2YV1_DLtcVcAKfA@mail.gmail.com> <CAErSpo6KnNKz8z1dcHqKTO6450MfGRm0nLk65sTvAcnUmGqiQQ@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 21 Oct 2014 14:03:50 -0600
Message-ID: <CAErSpo5=SH9Ld72bXx4OeTPhd46CBRUsadZtqQu3ATb=8ZOMeQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] MIPS: CPC: Make mips_cpc_phys_base() static
To:     Jason Wessel <jason.wessel@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Wed, Oct 15, 2014 at 5:28 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-mips for real this time.  sheesh]
>
> On Wed, Oct 15, 2014 at 5:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc linux-mips@linux-mips.org]
>>
>> On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> There's only one implementation of mips_cpc_phys_base(), and it's only used
>>> within the same file, so it doesn't need to be weak, and it doesn't need an
>>> extern declaration.
>>>
>>> Remove the extern mips_cpc_phys_base() declaration and make it static.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: linux-mips@linux-mips.org

I'm dropping this patch from my series because I haven't seen any
response from the MIPS folks.

>>> ---
>>>  arch/mips/include/asm/mips-cpc.h |   10 ----------
>>>  arch/mips/kernel/mips-cpc.c      |    2 +-
>>>  2 files changed, 1 insertion(+), 11 deletions(-)
>>>
>>> diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
>>> index e139a534e0fd..8ff92cd74bde 100644
>>> --- a/arch/mips/include/asm/mips-cpc.h
>>> +++ b/arch/mips/include/asm/mips-cpc.h
>>> @@ -28,16 +28,6 @@ extern void __iomem *mips_cpc_base;
>>>  extern phys_t mips_cpc_default_phys_base(void);
>>>
>>>  /**
>>> - * mips_cpc_phys_base - retrieve the physical base address of the CPC
>>> - *
>>> - * This function returns the physical base address of the Cluster Power
>>> - * Controller memory mapped registers, or 0 if no Cluster Power Controller
>>> - * is present. It may be overriden by individual platforms which determine
>>> - * this address in a different way.
>>> - */
>>> -extern phys_t __weak mips_cpc_phys_base(void);
>>> -
>>> -/**
>>>   * mips_cpc_probe - probe for a Cluster Power Controller
>>>   *
>>>   * Attempt to detect the presence of a Cluster Power Controller. Returns 0 if
>>> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
>>> index ba473608a347..36c20ae509d8 100644
>>> --- a/arch/mips/kernel/mips-cpc.c
>>> +++ b/arch/mips/kernel/mips-cpc.c
>>> @@ -21,7 +21,7 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
>>>
>>>  static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
>>>
>>> -phys_t __weak mips_cpc_phys_base(void)
>>> +static phys_t mips_cpc_phys_base(void)
>>>  {
>>>         u32 cpc_base;
>>>
>>>
