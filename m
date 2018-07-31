Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 20:22:09 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:33680
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993081AbeGaSWFUb8qL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 20:22:05 +0200
Received: by mail-io0-x241.google.com with SMTP id z20-v6so13873629iol.0;
        Tue, 31 Jul 2018 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2HMehfdDkjGDNTUdHCh9ypmEMD7butM7h2R8hS34Vn4=;
        b=hmLqGjGqFk/iKk7sPZW3zGnqc+tJYas8rYykhicDd/OpFTiybuqIBF5wSaLEgCQbNC
         HhbEHjsQzTfjcWN7sCk5zan4RNCoGOo2SC4285VM17BUnhT6eXuCfe2B0cDp7TUsedWh
         svaoxAjHvNMBAlYfPwexYgMpjNZ2mpiOKqCb31nSlzxR/UMZ9Fo0OMdyaqb8+QAgibo2
         yoltEjRb2dBAUEaoe8CAr6IO/UT2XBu3hwGXVikyC0ltSkMccdUOiISFSPhmVwIusZcp
         sCWzWjaicu30uJxUpyWTCWDzMyEBfKeUR4zlyzpo+Na6jfWv3EaMf0bhwN/yHyTD9Ujb
         vApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2HMehfdDkjGDNTUdHCh9ypmEMD7butM7h2R8hS34Vn4=;
        b=NimZ+vRQnotOfBFy2kI3/3T+PtVX/aAz9fduluaEAOJb7Zc4nNEGJuyYPnr2uZ0sp9
         Fb0/AtLYLJQz+yGPwfQfCsYtaV4XzNz104yb6+XXIo7dCE+oQQEMugyqpLO3KQwh65qF
         gdgcr+hXxNKe87CeTAtw/s2WbgX3GmlIYXc8aTsh2X5GoPvbYJk+GOGFBm2pOMTBv0bt
         tvuxr+Sg47JzDa1p4hEQHBswx5RVZUioV+llMOGUYfvhMJz6lk5bck3bo1zksKahssKv
         PLj81fDPw6sxHtnkCVqxtelKJIAj1nBQ+UBMiTJHZiHzhx9wbqfMynzXnmvTUGhW1nQ2
         zgRA==
X-Gm-Message-State: AOUpUlGyTR4CAl9nozB9gkK9lHjwgvhMYQu38/RKONK5MdRJjqyMBxSr
        HYLhNVImXxkZn+ejrswapG0=
X-Google-Smtp-Source: AAOMgpenyIpJJ4WLkuAjFEil4rvMrJGOTh98VqLDHS+C8Cps6IV4zAGWIC59n3zjo0HYgFShWmDf1A==
X-Received: by 2002:a6b:bbc1:: with SMTP id l184-v6mr686897iof.83.1533061318844;
        Tue, 31 Jul 2018 11:21:58 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id i3-v6sm1727831iti.40.2018.07.31.11.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:21:58 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/6] rapidio: move Kconfig menu definition to
 subsystem
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Alexei Colin <acolin@isi.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731155909.GO17271@n2100.armlinux.org.uk>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <1f427e4c-3fb8-769a-efb6-db64afd4617a@gmail.com>
Date:   Tue, 31 Jul 2018 14:21:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731155909.GO17271@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65334
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



On 2018-07-31 11:59 AM, Russell King - ARM Linux wrote:
> For the thread associated with this patch set, a review of a previous
> patch for ARM posted last Tuesday on this subject asked a series of
> questions about the PCI-nature of this.  The review has not been
> responded to.

We are dealing with this now. More appropriate to do it this time than 
before having reworked set.

> If it is inappropriate to offer RapidIO for any architecture that
> happens to has PCI, then it is inappropriate to offer it for any
> ARM machine that happens to have PCI.

It is completely appropriate to use RapidIO on any architecture that has 
PCI/PCIe using existing PCIe-to-SRIO host bridges. Works well with 
Marvell and NVIDIA boards.

Confusion here is caused by the fact that there are ARM and non-ARM 
devices that offer on-chip RapidIO host controllers as well as PCIe. 
E.g. TI Keystone/KeystoneII, FSL 85xx/86xx, Xilinx and Altera FPGAs with 
ARM cores, Cavium on MIPS. In most cases external buses are configurable 
and we have to address possible combinations.

I already posted some explanation in response to your earlier comment.

> In light of the lack of explanation on this point so far, I'm naking
> the ARM part of this series for now.
> 

Explanations posted.

> I also think that the HAS_RAPIDIO thing is misleading and needs
> sorting out (as I've mentioned in other emails, including the one
> I refer to above) before rapidio becomes available more widely.
>
Highly likely it is used right now in a base station of mobile operator 
near you :)

> On Tue, Jul 31, 2018 at 10:29:48AM -0400, Alexei Colin wrote:
>> Resending the patchset from prior submission:
>> https://lkml.org/lkml/2018/7/30/911
>>
>> The only change are the Cc tags in all patches now include the mailing
>> lists for all affected architectures, and patch 1/6 (which adds the menu
>> item to RapdidIO subsystem Kconfig) is CCed to all maintainers who are
>> getting this cover letter. The cover letter has been updated with
>> explanations to points raised in the feedback.
>>
>>
>>
>> The top-level Kconfig entry for RapidIO subsystem is currently
>> duplicated in several architecture-specific Kconfig files. This set of
>> patches does two things:
>>
>> 1. Move the Kconfig menu definition into the RapidIO subsystem and
>> remove the duplicate definitions from arch Kconfig files.
>>
>> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
>> where it was not enabled before. I tested that subsystem and drivers
>> build successfully for both architectures, and tested that the modules
>> load on a custom arm64 Qemu model.
>>
>> For all architectures, RapidIO menu should be offered when either:
>> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
>> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
>> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
>> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
>>
>> Prior to this patchset, different architectures used different criteria:
>> * powerpc: (1) and (2)
>> * mips: (1) and (2) after recent commit into next that added (2):
>>    https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>>    fc5d988878942e9b42a4de5204bdd452f3f1ce47
>>    491ec1553e0075f345fbe476a93775eabcbc40b6
>> * x86: (1)
>> * arm,arm64: none (RapidIO menus never offered)
>>
>> This set of architectures are the ones that implement support for
>> RapidIO as system bus. On some platforms RapidIO can be the only system
>> bus available replacing PCI/PCIe.  As it is done now, RapidIO is
>> configured in "Bus Options" (x86/PPC) or "Bus Support" (ARMs) sub-menu
>> and from system configuration option it should be kept this way.
>> Current location of RAPIDIO configuration option is familiar to users of
>> PowerPC and x86 platforms, and is similarly available in some ARM
>> manufacturers kernel code trees. (Alex Bounine)
>>
>> HAS_RAPIDIO is not enabled unconditionally, because HAS_RAPIDIO option
>> is intended for SOCs that have built in SRIO controllers, like TI
>> KeyStoneII or FPGAs. Because RapidIO subsystem core is required during
>> RapidIO port driver initialization, having separate option allows us to
>> control available build options for RapidIO core and port driver (bool
>> vs.  tristate) and disable module option if port driver is configured as
>> built-in. (Alex Bounine)
>>
>> Responses to feedback from prior submission (thanks for the reviews!):
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
>>
>> Changelog:
>>    * Moved Kconfig entry into RapidIO subsystem instead of duplicating
>>
>> In the current patchset, I took the approach of adding '|| PCI' to the
>> depends in the subsystem. I did try the alterantive approach mentioned
>> in the reviews for v1 of this patch, where the subsystem Kconfig does
>> not add a '|| PCI' and each per-architecture Kconfig has to add a
>> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
>> 'select HAS_RAPIDIO'. This works too but requires each architecture's
>> Kconfig to add the line for RapidIO (whereas current approach does not
>> require that involvement) and also may create a false impression that
>> the dependency on PCI is strict.
>>
>> We appreciate the suggestion for also selecting the RapdiIO subsystem for
>> compilation with COMPILE_TEST, but hope to address it in a separate
>> patchset, localized to the subsystem, since it will need to change
>> depends on all drivers, not just on the top level, and since this
>> patch now spans multiple architectures.
>>
>> Alexei Colin (6):
>>    rapidio: define top Kconfig menu in driver subtree
>>    x86: factor out RapidIO Kconfig menu
>>    powerpc: factor out RapidIO Kconfig menu entry
>>    mips: factor out RapidIO Kconfig entry
>>    arm: enable RapidIO menu in Kconfig
>>    arm64: enable RapidIO menu in Kconfig
>>
>>   arch/arm/Kconfig        |  2 ++
>>   arch/arm64/Kconfig      |  2 ++
>>   arch/mips/Kconfig       | 11 -----------
>>   arch/powerpc/Kconfig    | 13 +------------
>>   arch/x86/Kconfig        |  8 --------
>>   drivers/rapidio/Kconfig | 15 +++++++++++++++
>>   6 files changed, 20 insertions(+), 31 deletions(-)
>>
>> -- 
>> 2.18.0
>>
> 
