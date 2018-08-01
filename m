Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 15:16:11 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:36321
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbeHANQH2nC9O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2018 15:16:07 +0200
Received: by mail-it0-x243.google.com with SMTP id p81-v6so9256739itp.1
        for <linux-mips@linux-mips.org>; Wed, 01 Aug 2018 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QRwr3HK7nt0hGQKlW4/QGEnnlhLebhT7hwSbjCz6vh4=;
        b=dKPWpRLewCctKBhIttr1QfDzsKcsCU0zg+NuzxJYqUtJf6MiU8Eg8BHnqJFHoVaST1
         PU2ToXuTUrgNfuuZ+te4D/NROVLpcNGv/Gx9F4OqhRy8QdqH/Acsc+20MsBNaOPEvZIK
         AIkqJvjC7m5DEYt9na5ddnMgswoL32EIscetle05S4cHYOaW7cVaFsbQqxC5y6OMcZ2h
         ovnI9206Wvma/v4DLcQrJr1MPviL9plg0pdrCbzwpfXiXaCsKxVBeqtJ0cag0pyYGnQj
         saLNNLsGPJEu1rXMK5qMNjPlG2olktPh0VY1ermoMniu5QkSaLVBfkNNXRzMGm/51SXa
         iVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRwr3HK7nt0hGQKlW4/QGEnnlhLebhT7hwSbjCz6vh4=;
        b=EAYsMuuJ3BQsRDfFD1V8YRZudms7SDeb7qaFGuqlhmazBNbM+JL/XrGnCGBMtRNfSa
         T+E0C4Kzc8VwOtFSvEjuEyvR374dWwSddhOeKAq3Y+FOlmowKfAlgm4XqykuZC2Sqg6U
         LD/B/C3+lVMxlmEDrcyrqKpTGrNva0Fre2WbdFAS24VldlVb3fLRUDMBIIZ7WZjojC8a
         dUiNaeWjB/tIqW5vvpdnGWhbSBc4PMFH+Xnzw2fHyOM49RIn5lqu0lYxPny5WtYi7let
         VsMtXNVSaXxR7///qOree+ptBFfDrTM1RWMGNlSWIc/pLUaZV3J6kkAzTXArS0TEK/Hw
         1J0g==
X-Gm-Message-State: AOUpUlH5nzp9y6aottfEXxK/Pvp6/8PMi/qzIl5nfr6ocQTE5eYln8KP
        +S6wPFucbHIGMhjtCMz+qOk=
X-Google-Smtp-Source: AAOMgpcSAivVEyJEXin2WtTYvPcsVGH8NRW5xKI+GQvpyXnTtTXDztv2XiVnCT+nK8nUOg5XvKddew==
X-Received: by 2002:a02:b468:: with SMTP id w37-v6mr23179683jaj.18.1533129361070;
        Wed, 01 Aug 2018 06:16:01 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id i9-v6sm5194147iom.19.2018.08.01.06.15.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 06:16:00 -0700 (PDT)
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
To:     Christoph Hellwig <hch@infradead.org>,
        Alexei Colin <acolin@isi.edu>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
Date:   Wed, 1 Aug 2018 09:15:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801095404.GA17585@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.bou9@gmail.com
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

On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
>> Platforms with a PCI bus will be offered the RapidIO menu since they may
>> be want support for a RapidIO PCI device. Platforms without a PCI bus
>> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
>> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
>>
>> Tested that kernel builds for arm64 with RapidIO subsystem and
>> switch drivers enabled, also that the modules load successfully
>> on a custom Aarch64 Qemu model.
> 
> As said before, please include it from drivers/Kconfig so that _all_
> architectures supporting PCI (or other Rapidio attachements) get it
> and not some arbitrary selection of architectures.
> 
As it was replied earlier this is not a random selection of 
architectures but only ones that implement support for RapidIO as system 
bus. If other architectures choose to adopt RapidIO we will include them 
as well.

On some platforms RapidIO can be the only system bus available replacing 
PCI/PCIe or RapidIO can coexist with PCIe.

As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or 
"Bus Support" (ARMs) sub-menu and from system configuration option it 
should be kept this way.

Current location of RAPIDIO configuration option is familiar to users of 
PowerPC and x86 platforms, and is similarly available in some ARM 
manufacturers kernel code trees.

drivers/Kconfig will be used for configuring drivers for peripheral 
RapidIO devices if/when such device drivers will be published.
