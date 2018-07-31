Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jul 2018 16:26:30 +0200 (CEST)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:45162
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993087AbeGaO0XUX3Ch (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Jul 2018 16:26:23 +0200
Received: by mail-io0-x242.google.com with SMTP id k16-v6so13172821iom.12;
        Tue, 31 Jul 2018 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lcv7/ijN6gYHVjVHbvAVO+/gcdU9+BEB+pn28qZwMcw=;
        b=XMWhwf+MmY6sNmR43aF88udxFVrRdZe/1OpZz6JT92keZ21ZIGI5j1PkU9TtX2wl3u
         jF8oTIwelVDvDlrMwKcAraPXZ53rrblQ3EnyTperct018chXsrh6+EkXbIhmzCiggh6G
         1SjB1HLGigpw9JjF9x1p9Zk9XIHmzOE9y3voM9W9ArDOp5yweLEnf+sPYy1oX/2d35uO
         zVT+ltQWSoaz0eAkN7nQd7h4UjLj+5Xw6EkNWs7GGEPDJyTnDDQf8MsGYuGa6grlSYUQ
         CsxGCUZwQW2MsfBWMYHs++f8uAobER6STVHsSL5Hz8WMCIscIWAGym/SuvA0BCY0mJkI
         cA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lcv7/ijN6gYHVjVHbvAVO+/gcdU9+BEB+pn28qZwMcw=;
        b=n+6aq0woAGZ9LkuRissfMVPn8734Byn2eznrQwPX0fGCC2xXLe05tSqXSKz7cCgDSP
         ENr9kwwnQ53Q0FY/eZ5mKjEmyVpDoqbz1M14EbSZm7m/UM5HiwfvUzhEGDZGlJRm7VOx
         PlTa6ZcVXx7LQKcOts3G5LlXD34AV/0V1Wz+xgYynmygz8xfgNo3JMCSGfoHMbdWbvZ4
         FUdLhyL+DMI5a83Qo4g7ZyqTGpEuM5RzoRMoODi5YwWfSgr26XpyXOR7h8D2cSCxckfB
         mGGJJVNiKg/CA+ewFDyLorove3pxI2p1K+MkFg4O/dqHbSp55V2Fs0oJLXdF1fqXCf1l
         /Aaw==
X-Gm-Message-State: AOUpUlHFvOTquoaDxzNGObY4szQh4nniGuXRpQsW34PruYa/OfNNi0Uv
        KFPsK2TPnElG3frAfJoAUj8=
X-Google-Smtp-Source: AAOMgpdBd0RLrRTTfZ9pEUlrJgV5/Upti6Jisg5rWrjGoL1A0A+31+R6Qg5kr0xLgZA2yyYIWVAwyQ==
X-Received: by 2002:a6b:82da:: with SMTP id m87-v6mr16412556ioi.279.1533047177094;
        Tue, 31 Jul 2018 07:26:17 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1608004ita.21.2018.07.31.07.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:26:16 -0700 (PDT)
Subject: Re: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
To:     Alexei Colin <acolin@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
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
References: <20180730225035.28365-1-acolin@isi.edu>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <37edb8c5-a16f-ea39-5da8-312d138ce442@gmail.com>
Date:   Tue, 31 Jul 2018 10:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65311
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

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>

On 2018-07-30 06:50 PM, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfig files. This set of
> patches does two things:
> 
> 1. Move the Kconfig menu definition into the RapidIO subsystem and
> remove the duplicate definitions from arch Kconfig files.
> 
> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
> where it was not enabled before. I tested that subsystem and drivers
> build successfully for both architectures, and tested that the modules
> load on a custom arm64 Qemu model.
> 
> For all architectures, RapidIO menu should be offered when either:
> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
> 
> Prior to this patchset, different architectures used different criteria:
> * powerpc: (1) and (2)
> * mips: (1) and (2) after recent commit into next that added (2):
>    https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>    fc5d988878942e9b42a4de5204bdd452f3f1ce47
>    491ec1553e0075f345fbe476a93775eabcbc40b6
> * x86: (1)
> * arm,arm64: none (RapidIO menus never offered)
> 
> Responses to feedback from prior submission (thanks for the reviews!):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
> 
> Changelog:
>    * Moved Kconfig entry into RapidIO subsystem instead of duplicating
> 
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.
> 
> We appreciate the suggestion for also selecting the RapdiIO subsystem for
> compilation with COMPILE_TEST, but hope to address it in a separate
> patchset, localized to the subsystem, since it will need to change
> depends on all drivers, not just on the top level, and since this
> patch now spans multiple architectures.
> 
> 
> Alexei Colin (6):
>    rapidio: define top Kconfig menu in driver subtree
>    x86: factor out RapidIO Kconfig menu
>    powerpc: factor out RapidIO Kconfig menu entry
>    mips: factor out RapidIO Kconfig entry
>    arm: enable RapidIO menu in Kconfig
>    arm64: enable RapidIO menu in Kconfig
> 
>   arch/arm/Kconfig        |  2 ++
>   arch/arm64/Kconfig      |  2 ++
>   arch/mips/Kconfig       | 11 -----------
>   arch/powerpc/Kconfig    | 13 +------------
>   arch/x86/Kconfig        |  8 --------
>   drivers/rapidio/Kconfig | 15 +++++++++++++++
>   6 files changed, 20 insertions(+), 31 deletions(-)
> 
