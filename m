Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Nov 2018 18:48:16 +0100 (CET)
Received: from mail-vs1-xe43.google.com ([IPv6:2607:f8b0:4864:20::e43]:45979
        "EHLO mail-vs1-xe43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993961AbeK0RqzRD-oN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Nov 2018 18:46:55 +0100
Received: by mail-vs1-xe43.google.com with SMTP id v10so14292102vsv.12
        for <linux-mips@linux-mips.org>; Tue, 27 Nov 2018 09:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
        b=n8Ig5tAbA7o3/Ez/WMYwOM6FQ8Y7htlXMticvVSwbTd68NwdFgyL/WgOnsMP1ni1pW
         +STDRZ2AFIiJAy+B5Z9uUEyF+oxnMtVjLcHdm9Hmx/v9AvHS61VlBIbAUOani6h8lpAJ
         yz3zvL8AcXhbiLN04crZSzLzeHZC9ti8UKCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
        b=G8ZkTC97Xxz4aTL7J/R8gi83Tn5k2kyJhXlO6icfCTnKpcndGZs9jDZ+RhnFn1DG5z
         gOsOPvoDWzAHewPX7dB+JLknKCbyoviyVpDNeX9RFwXrWdJoPUCcrxgFC2+F4oK2Cx1i
         IOn6P00GmK6f2RzGRVTJrbHjubqLHPettkUgZ2zNKtN9QfBl8Aonpx5P3/Ev/HgPOlaV
         F62Mm4+RyUy/eSJZqEIjYccfJirk9Bpuj4+zYVh/iWT3xmbc1PAaPPh251la2iggJCmA
         dGG6R9XDIMk0AdSiiy8Vz4inAzfkSo5ErsNpo2ei6t2SVNW7uC/Tb2PAAAjeiEGFDsgp
         Ec8A==
X-Gm-Message-State: AGRZ1gLZKx4h6AFZ0tKtV7AjDuGovm7U7gVFuClMNP8UOmrvFWGKkfLh
        ZmSplM5Vir93Ib6APBntuyZ+vjvhQ4o=
X-Google-Smtp-Source: AJdET5e61Fxq/QwBjXadFfgWrKbkH9vrWrPr2qWK2Iy0fVv39tDVXmdWgzcqIRByxnGENPDNwXG0pg==
X-Received: by 2002:a67:e199:: with SMTP id e25mr14411221vsl.188.1543340814220;
        Tue, 27 Nov 2018 09:46:54 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id v79sm1348210vkv.13.2018.11.27.09.46.53
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:46:53 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id p74so14325809vsc.0
        for <linux-mips@linux-mips.org>; Tue, 27 Nov 2018 09:46:53 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr14355429vsc.149.1543340364044;
 Tue, 27 Nov 2018 09:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20181127035133.225592-3-dianders@chromium.org> <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
In-Reply-To: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 09:39:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        rkuo@codeaurora.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Hi,

On Mon, Nov 26, 2018 at 9:39 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kgdb/kgdb-next]
> [also build test ERROR on v4.20-rc4 next-20181126]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sparc64
>
> Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
> >> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
>        kgdb_info[cpu].rounding_up = false;
>                      ^

Oops, I squashed this into the wrong patch.  It should have been in
patch #3.  Sorry about that.  I'll send out a quick v6.
