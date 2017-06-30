Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 09:03:35 +0200 (CEST)
Received: from mail-it0-x234.google.com ([IPv6:2607:f8b0:4001:c0b::234]:36803
        "EHLO mail-it0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992022AbdF3HD1jpCIY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 09:03:27 +0200
Received: by mail-it0-x234.google.com with SMTP id m68so56947897ith.1;
        Fri, 30 Jun 2017 00:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=m+l/7/0D++4nnqPuj/QiupX1SfxBSzP2aJAodM57xY8=;
        b=Wo1ak2jVMq36ZsCbep5IVVaB2FDKCXAF9BiV5Ona9RHAIt+HP8SaLaa2KqWZA4CKHK
         dAdMq0F5W3m4QST+RHI4GXEXdrlxHPr4wOn/rm3nHXv0aamot/gxwfntWXmIjvv8rdQP
         Or0LBUnWymC70Usy4SXZzy3ilYupywLuV8bFZ46pSMyQdF18SI+9McKRC4xdTgduToWM
         9hrkmyBK2cbh84rEFZ/qZmJYjpSax2J8xtuaC5wzBR/HzAt+cNoVVDpXDA5iNnhQBGyb
         18YFHmX3KZOSJrfcFD8dGag6vN0AGrLMq5mxOfNeJp2rApiElnLGCYypWQ0Fjj8GT4p+
         lIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=m+l/7/0D++4nnqPuj/QiupX1SfxBSzP2aJAodM57xY8=;
        b=iV/kgBvMXcEGTqkoB9/OINUC5FjoHOezgdLrcrzHSc0CAAgCaAvOLFMJeaZFiys+G6
         5sBTb2mccPDRXIhUDUEytEkfLULLi6vLmwfhE/HQC0I10kfj4H+Sy2Oxtwx82V62MjD3
         /ENzzdPwho9SOnDPPZUD/94ir/H7kL4e2PMmaQCc7ROZ72L4+QhDyfpYXFPMyG0SxgQl
         9ucrLhzZ2zyBxoEZXs+lFCwaEMJu2VmbS431HpS67/cPoi3kniHu+MkTr99/f3g4xILG
         TZePMfjb04gCy207I3yuk6U07wCzVpYJHR5Zs/bHT6TJ2aWVj8SbWcRAHkjE0v/J2Xwd
         F/kg==
X-Gm-Message-State: AKS2vOx29sTa9KVjeAmE9d4CFl+k5xcKHDJ0r8ceAdnE3jbE3+kNid6+
        9HiQ+Wwd1Zn4E4ZAjILFgAsAa5DQGg==
X-Received: by 10.36.87.147 with SMTP id u141mr17484112ita.72.1498806201861;
 Fri, 30 Jun 2017 00:03:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Fri, 30 Jun 2017 00:03:21 -0700 (PDT)
In-Reply-To: <dff97c4e-62aa-eacc-c1c9-16f824eda332@gentoo.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-3-git-send-email-chenhc@lemote.com> <20170628143005.GJ31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H7+0v0TE=V29DVYtEhxN2fUjVhh9MP9gNV96jzkq_1yrg@mail.gmail.com>
 <64E99F82-4E2B-4D53-8750-FCE90F84A29B@imgtec.com> <dff97c4e-62aa-eacc-c1c9-16f824eda332@gentoo.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Fri, 30 Jun 2017 15:03:21 +0800
X-Google-Sender-Auth: ih1bbz08bzG3nQWMYBjv2mgnR_s
Message-ID: <CAAhV-H6aJ=bh9Dc1JNs8dpeBxvWiKFn0SDrwz0PM92FnM0yWyA@mail.gmail.com>
Subject: Re: [PATCH V7 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for Loongson-3
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58938
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

What about add these lines in c-r4k.c?
#ifnde pa_to_nid
#define pa_to_nid(addr) 0
#endif

Huacai

On Thu, Jun 29, 2017 at 6:23 PM, Joshua Kinard <kumba@gentoo.org> wrote:
> On 06/29/2017 01:46, James Hogan wrote:
>> On 29 June 2017 02:33:28 BST, Huacai Chen <chenhc@lemote.com> wrote:
>>> Hi, James,
>>>
>>> Is it suitable to add this line in arch/mips/include/asm/mmzone.h?
>>> #define pa_to_nid(addr) 0
>>
>> It was basically malta_defconfig.
>>
>> OTOH when i tried including asm/mmzone.h, that tries including <mmzone.h> which it can't find.
>>
>> Cheers
>> Jamee
>>
>
> <asm/mmzone.h> is only supposed to be defined for NUMA-aware systems, as far as
> I can tell.  I believe a lot of the Loongson code derives somewhat from the
> IP27 code, as both are the only MIPS platforms that define a specific version
> of that header.
>
> It also looks like the generic mmzone.h header probably just needs the
> <mmzone.h> include removed.  pa_to_nid is only used for pfn_to_nid when
> CONFIG_DISCONTIGMEM is set, and IP27 is one of the only platforms that uses
> that memory model.
>
> --J
>
