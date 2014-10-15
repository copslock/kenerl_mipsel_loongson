Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 01:28:52 +0200 (CEST)
Received: from mail-qa0-f45.google.com ([209.85.216.45]:38135 "EHLO
        mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011560AbaJOX2uDjume (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 01:28:50 +0200
Received: by mail-qa0-f45.google.com with SMTP id s7so1605843qap.32
        for <linux-mips@linux-mips.org>; Wed, 15 Oct 2014 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Kwwcl8O64UeOUxAE/OHOUL2QhH3P0zt45B7J7/BEZyM=;
        b=i/1b+9szqvGiMbhfZPYNV9FsFpPXUG8rIaglexiVqoqqG5sMz/yn3bsx0V88CptEWK
         J1xYabO98ptDX+FIkhnTHIN4Pl2OyN4TGCq1XmfOUCVo5voTTmq0Kv5fQKxzJyp3kwvU
         WdXMrajPkqxLA4yiF9yzsrMZQT3Us41wbDffHVvXVKZSDbhSMbrfmjvuuzFPB5OizF8o
         vTYeoDZTuenT3RycrV2KSj9NwvMQhI1O5xKzoNhWToHOIBHxxJXhFg7TbLBRKv3o+YLV
         C7qmX81FYBOLXBKz9hLfsosFy5D0GaTUKQcSK0Xao3f2ScweJ9DSVZtLHozykmEfZAgF
         6B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Kwwcl8O64UeOUxAE/OHOUL2QhH3P0zt45B7J7/BEZyM=;
        b=CpBJ2atDgDhJHdTOU2M+GMVlnYr/xPrU4ISf0or8lhFnqNXqx8ku1t/wN/VmxSHdeP
         fv5QEMzrs2pUJkU7qrlf8eCxv9xf+eSfLzcTXg3WS5NSUuczxaifzwAngb8zw/7sZ0de
         ukh89ZYZGogNAZuMKDAxIgqDlyQZDCYxNEnFh11C5zN+cjtYxYPCUn2xzLI6KkbTOCD6
         P3Rxg5VnkIeT42lrLqyKZsOGYL+4n0JSVBIiZKrK9BtFEXCbV40vJZ0+WmNPxCPDBST0
         Eqv+NKK3N5re/sBMjU9p6XS+J3dAzzj6BfRvzub6b4RAq3WmqJKJkALvjaid5bd+8yB8
         9NvA==
X-Gm-Message-State: ALoCoQmmrToOMXGAUJbo+8gx5SFQ8hR7w6M9UvvH3UzNkXOwdtMTzQyvVbxiv29s15ub0Lu9msuq
X-Received: by 10.224.79.211 with SMTP id q19mr2979045qak.101.1413415724316;
 Wed, 15 Oct 2014 16:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.161.79 with HTTP; Wed, 15 Oct 2014 16:28:24 -0700 (PDT)
In-Reply-To: <CAErSpo7K2dhNWz7HL_JCrB6pvq5+aeOYCwD2YV1_DLtcVcAKfA@mail.gmail.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170602.4063.5577.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CAErSpo7K2dhNWz7HL_JCrB6pvq5+aeOYCwD2YV1_DLtcVcAKfA@mail.gmail.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 15 Oct 2014 17:28:24 -0600
Message-ID: <CAErSpo6KnNKz8z1dcHqKTO6450MfGRm0nLk65sTvAcnUmGqiQQ@mail.gmail.com>
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
X-archive-position: 43293
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

[+cc linux-mips for real this time.  sheesh]

On Wed, Oct 15, 2014 at 5:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc linux-mips@linux-mips.org]
>
> On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> There's only one implementation of mips_cpc_phys_base(), and it's only used
>> within the same file, so it doesn't need to be weak, and it doesn't need an
>> extern declaration.
>>
>> Remove the extern mips_cpc_phys_base() declaration and make it static.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> CC: linux-mips@linux-mips.org
>> ---
>>  arch/mips/include/asm/mips-cpc.h |   10 ----------
>>  arch/mips/kernel/mips-cpc.c      |    2 +-
>>  2 files changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mips-cpc.h b/arch/mips/include/asm/mips-cpc.h
>> index e139a534e0fd..8ff92cd74bde 100644
>> --- a/arch/mips/include/asm/mips-cpc.h
>> +++ b/arch/mips/include/asm/mips-cpc.h
>> @@ -28,16 +28,6 @@ extern void __iomem *mips_cpc_base;
>>  extern phys_t mips_cpc_default_phys_base(void);
>>
>>  /**
>> - * mips_cpc_phys_base - retrieve the physical base address of the CPC
>> - *
>> - * This function returns the physical base address of the Cluster Power
>> - * Controller memory mapped registers, or 0 if no Cluster Power Controller
>> - * is present. It may be overriden by individual platforms which determine
>> - * this address in a different way.
>> - */
>> -extern phys_t __weak mips_cpc_phys_base(void);
>> -
>> -/**
>>   * mips_cpc_probe - probe for a Cluster Power Controller
>>   *
>>   * Attempt to detect the presence of a Cluster Power Controller. Returns 0 if
>> diff --git a/arch/mips/kernel/mips-cpc.c b/arch/mips/kernel/mips-cpc.c
>> index ba473608a347..36c20ae509d8 100644
>> --- a/arch/mips/kernel/mips-cpc.c
>> +++ b/arch/mips/kernel/mips-cpc.c
>> @@ -21,7 +21,7 @@ static DEFINE_PER_CPU_ALIGNED(spinlock_t, cpc_core_lock);
>>
>>  static DEFINE_PER_CPU_ALIGNED(unsigned long, cpc_core_lock_flags);
>>
>> -phys_t __weak mips_cpc_phys_base(void)
>> +static phys_t mips_cpc_phys_base(void)
>>  {
>>         u32 cpc_base;
>>
>>
