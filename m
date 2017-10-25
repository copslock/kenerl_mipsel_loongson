Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Oct 2017 17:00:49 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:52294
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdJYPAjT3aoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Oct 2017 17:00:39 +0200
Received: by mail-it0-x241.google.com with SMTP id j140so1377223itj.1;
        Wed, 25 Oct 2017 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GvQznkyTDCer3tiq0lxIz5tXdJaPgZDFaUa479oYYKI=;
        b=Rqp0QXEerbDS1pC4u+LSl3UKikbfBOfLW1nBougDqTONnwOG+7eC0oyuw4eCCcLIVJ
         wXoaluFZrFZrlmNOICImfCvd0FV22hCbDTbl6nLw9Zuce3FSRz4+ES1jQzZCKKbdCTmd
         4se0+R69xadKtqhdCXdNcyKHYWY3Nzs05gEUm6gy0Y0ACkOMDtPFjAiN0AU2mx2M13sv
         lffYkLi1RtbBAldLIrcXeOhbLTXNuAfn68wgpU5rZ+bK45ESgt8Y5Hn3bbrbRc+y4ugA
         17EcxSnQLgGZt5SsG3JNRJ4E8coUgwDhcNrqYAcAd6Ab5jBICRMT0ldCKtk1A5gm2KkS
         jBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GvQznkyTDCer3tiq0lxIz5tXdJaPgZDFaUa479oYYKI=;
        b=BXqrEe5sg8jgBNBHSq+KdYESMi424BMnO7kvhS557Ar2phXGE0wcu/mU43qOn6SP5V
         xz3OECfnHGNhf7gsbl3ZABJHJmi0p2c3RFSPhdtU78b1L6+Gx0gTXpja3L31yfoVegED
         mhNT7585t2KOFoQaBauOqD/14HOGKn2PXGwwc/G9hkjb3dG8jRm5lVmZKcyGptSGKHgs
         bEzsKKCRiNxN7Fwzuqm2d8EP8+JWkfBK5rx4pkxJ69IIb1HFaOv1dcwNKM5efFsBNzHv
         GuYfaGcbsVnYQg5LyKhiy00lMCGw/Q3ZWBfGK/kfFKXUUxBcAheZ5XqZnTurWpCG/fuf
         xG/Q==
X-Gm-Message-State: AMCzsaUufZ9/oO464N8M82csb2y/b/x2daoicUJgP5UhslxTqygPUYqz
        jmWeP5c6PPNlBxKJXAjQ6Nu/og2sZT73k4Pbswk=
X-Google-Smtp-Source: ABhQp+RLdNA5TUFTLmFgLBWc+J3L0GGhXDIEN5Erb+4z+vJZFumf4PkPsgRdaUN+QCWVuQfPB0YTa6RKh6VSfLteegs=
X-Received: by 10.36.17.130 with SMTP id 124mr2453720itf.81.1508943632669;
 Wed, 25 Oct 2017 08:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.47.156 with HTTP; Wed, 25 Oct 2017 08:00:32 -0700 (PDT)
In-Reply-To: <a83617d0-8506-7fe4-2870-d9dbd9ffdb3f@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-2-git-send-email-jim2101024@gmail.com> <a83617d0-8506-7fe4-2870-d9dbd9ffdb3f@gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 Oct 2017 11:00:32 -0400
Message-ID: <CANCKTBtLxAv9tmfi+92n+bYVq6x_ts0YzhH2YZ_jLnc+Dadc7g@mail.gmail.com>
Subject: Re: [PATCH 1/8] SOC: brcmstb: add memory API
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Tue, Oct 24, 2017 at 8:23 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Hi Jim,
>
> On 10/24/2017 11:15 AM, Jim Quinlan wrote:
>> +#elif defined(CONFIG_MIPS)
>> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
>> +{
>> +     /* The logic here is fairly simple and hardcoded: if pa <= 0x5000_0000,
>> +      * then this is MEMC0, else MEMC1.
>> +      *
>> +      * For systems with 2GB on MEMC0, MEMC1 starts at 9000_0000, with 1GB
>> +      * on MEMC0, MEMC1 starts at 6000_0000.
>> +      */
>> +     if (pa >= 0x50000000ULL)
>> +             return 1;
>> +     else
>> +             return 0;
>> +}
>> +#endif
>
> We may be missing an EXPORT_SYMBOL_GPL(brcmstb_memory_phys_to_addr_memc)
> here?
>
> Thanks!
> --
> Florian

Hi Florian,

I removed that EXPORT_SYMBOL_GPL() because this particular call is not
directly invoked PCIe RC driver.  It is indirectly invoked by
brcmstb_memory_memc_size(), which is exported.

Thanks, Jim
