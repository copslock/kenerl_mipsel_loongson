Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 23:35:42 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35104 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011133AbbGMVfkoIwW9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 23:35:40 +0200
Received: by wiga1 with SMTP id a1so81638808wig.0
        for <linux-mips@linux-mips.org>; Mon, 13 Jul 2015 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kTYwKPwWYHg010zXkaoYVATFe8CVUXJR5PTrXTnGCw4=;
        b=JbunO+YayBS0FphltieOIFL9MH9JieiLfMQR6H0ggC+k8n/0Xkdm08oEgJc2XDNA/F
         qFkLtnrLUhlAdib3Q5jFNx/haKLleM9c0bdK6dFj8tdLf1ozukYsRIquh+7JwT0tyqe6
         VLhVoN5PEFiEhzetIaAzF/8lZe09h7HBMoE1eurcW7OdFp94iM3O69phaZPwOkcqDBaY
         ZeDabQu7ffCtzVBO5QXEUngLXpYfBAbSAL4JHo2Vdp6/z0IFY8fKd6AtGnNO+CjHSRwH
         ldgWs9b31wP+NPZUNjaOJce5Cv3raeuvgERAuK068VxT7XMvRdwNtF1ZtRhZDtxF++Y9
         aZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=kTYwKPwWYHg010zXkaoYVATFe8CVUXJR5PTrXTnGCw4=;
        b=QP49waXdrB/2L7qVScrpjulRnU4O+QI2i9VZj8MxLqXvdE+wxMJFqIqarFGutvoF0K
         OD1xHUelIs1aa3ioQUWgkyCB3O3Ooh7Yo9JRXVQtxOQkLTHUIaQxQ34pAXJuu2Uag4Pm
         V5B08EthIMdYqoyewXnH+GKSofXyEai9ghuXHDrlBg/SDdARLCk+97mj7Pt0qam3XV5C
         eGWDiiWlTuMlax91X885oYy3jQrg2yQKd8apGK1yjbY8ezwIvrK0B1va0Lq891Kg2QPK
         sbypyJXjvYZebTpS4El0rAdsqlOlSnMfS2AgLPOd7ccG2s47wdcY6DONjllKJx3O4AX2
         7InA==
X-Gm-Message-State: ALoCoQn7K+OCELC1PqoF0uumQ08YAm1rOafsnqdFMuNkdPSLWfuJ9NP2eAxe6CG3kl1QTowbavZ/
X-Received: by 10.194.87.102 with SMTP id w6mr13610185wjz.111.1436823335468;
 Mon, 13 Jul 2015 14:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.210.74 with HTTP; Mon, 13 Jul 2015 14:35:15 -0700 (PDT)
In-Reply-To: <55A392AB.9030702@imgtec.com>
References: <20150712230402.11177.11848.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150712231120.11177.53145.stgit@bhelgaas-glaptop2.roam.corp.google.com> <55A392AB.9030702@imgtec.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 13 Jul 2015 16:35:15 -0500
Message-ID: <CAErSpo5Z0M2gEBhqGkz7sqyKwjaWV+pAP8QDxSjuh9mk5_jWLw@mail.gmail.com>
Subject: Re: [PATCH 4/9] MIPS: MT: Remove "weak" from vpe_run() declaration
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48248
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

On Mon, Jul 13, 2015 at 5:27 AM, James Hogan <james.hogan@imgtec.com> wrote:
> On 13/07/15 00:11, Bjorn Helgaas wrote:
>> Weak header file declarations are error-prone because they make every
>> definition weak, and the linker chooses one based on link order (see
>> 10629d711ed7 ("PCI: Remove __weak annotation from pcibios_get_phb_of_node
>> decl")).
>>
>> That's not a problem for vpe_run() because Kconfig ensures there's never
>> more than one definition:
>>
>>   - vpe_run() is defined in arch/mips/kernel/vpe-mt.c if
>>     CONFIG_MIPS_VPE_LOADER_MT=y
>>
>>   - vpe_run() is defined in arch/mips/mti-malta/malta-amon.c if
>>     CONFIG_MIPS_CMP=y
>>
>>   - CONFIG_MIPS_VPE_LOADER_MT cannot be set if CONFIG_MIPS_CMP=y
>>
>> But it's simpler to verify correctness if we remove "weak" from the picture
>> and test the config symbols directly.
>>
>> Remove "weak" from the vpe_run() declaration and use #if to test whether a
>> definition should be present.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/mips/include/asm/vpe.h |    2 +-
>>  arch/mips/kernel/vpe.c      |   10 +++++-----
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
>> index 7849f39..80e70db 100644
>> --- a/arch/mips/include/asm/vpe.h
>> +++ b/arch/mips/include/asm/vpe.h
>> @@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
>>  void *alloc_progmem(unsigned long len);
>>  void release_progmem(void *ptr);
>>
>> -int __weak vpe_run(struct vpe *v);
>> +int vpe_run(struct vpe *v);
>>  void cleanup_tc(struct tc *tc);
>>
>>  int __init vpe_module_init(void);
>> diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
>> index 72cae9f..04539d6 100644
>> --- a/arch/mips/kernel/vpe.c
>> +++ b/arch/mips/kernel/vpe.c
>> @@ -817,15 +817,11 @@ static int vpe_open(struct inode *inode, struct file *filp)
>>
>>  static int vpe_release(struct inode *inode, struct file *filp)
>>  {
>> +#if defined(CONFIG_MIPS_VPE_LOADER_MT) || defined(CONFIG_MIPS_CMP)
>
> That should be CONFIG_MIPS_VPE_LOADER_CMP, in which case the error case
> in the #else bit is always dead code. This file is built only if
> CONFIG_MIPS_VPE_LOADER, and the other ones are defined without prompts:
>
> config MIPS_VPE_LOADER_CMP
>         bool
>         default "y"
>         depends on MIPS_VPE_LOADER && MIPS_CMP
>
> config MIPS_VPE_LOADER_MT
>         bool
>         default "y"
>         depends on MIPS_VPE_LOADER && !MIPS_CMP
>
> I.e. one xor the other must be "y" when MIPS_VPE_LOADER=y.
>
> Maybe its worth just removing the weak and the vpe_run check?

Yes, thanks a lot for clearing up my Kconfig confusion!

>>       struct vpe *v;
>>       Elf_Ehdr *hdr;
>>       int ret = 0;
>>
>> -     if (!vpe_run) {
>> -             pr_warn("VPE loader: ELF load failed.\n");
>> -             return -ENOEXEC;
>> -     }
>> -
>>       v = get_vpe(aprp_cpu_index());
>>       if (v == NULL)
>>               return -ENODEV;
>> @@ -855,6 +851,10 @@ static int vpe_release(struct inode *inode, struct file *filp)
>>       v->plen = 0;
>>
>>       return ret;
>> +#else
>> +     pr_warn("VPE loader: ELF load failed.\n");
>> +     return -ENOEXEC;
>> +#endif
>>  }
>>
>>  static ssize_t vpe_write(struct file *file, const char __user *buffer,
>>
>
