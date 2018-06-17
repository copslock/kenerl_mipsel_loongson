Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2018 03:12:10 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:44498
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeFQBMDecdNX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jun 2018 03:12:03 +0200
Received: by mail-pf0-x244.google.com with SMTP id h12-v6so6524294pfk.11
        for <linux-mips@linux-mips.org>; Sat, 16 Jun 2018 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2W2Gm7K4ZAUFtmPdhaToCIfjNpot7ZNt+wV5jYJsThU=;
        b=r/ZyMo9QhC4wKgo9MZicBRk8Pch+hGXZoQNkOU5taSZy/k9pNA0rZ4re5eEWWfGUVm
         dfqKOtAItBjctRvk2KIFtt10+nKccOTuv8E1HMZHGVE+TGs7Zq1brei84Rsh6kBD0iIv
         w8ECUnemkKejVWKWFqtt23AiZpiUKcFPjsD6S3Q9rNF5QkNuIQMigZpfZiZVONl3T50K
         YUcuywhz0dlfz5TO/Rc4GmVgjHbj9DT4BGMwYTQhMVOt+vm6kQ3UsRyUBYKY67WCEC7R
         VJI2BjzNt+AcKzSqWLFJndtmQd65sz9FwHzgFtgAiee+ey2QSiiqVh0zxaNWcSKDCbj9
         P8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2W2Gm7K4ZAUFtmPdhaToCIfjNpot7ZNt+wV5jYJsThU=;
        b=SAp/KnTrDMlZC5cWEY4r+6vlP7+OoaYBSjbv4j0wY8WTxtoa243CJ35OGNSqFwlFEW
         vxTd81rrJUIwDOmzvTBr/MH94NYSCR4kMj0adFDS9RTH2++RxL86F0nT+n1IWtcAxDMx
         DKV2mxZaYoMBfR/0s8KQj2HpYbmjg5wU11GQLIm3/iXpst795nMdsTsDh8dxPguaVYlR
         qxVY0NlckdRBdHQ0N2Ttb28vx7dkO01kWReJXK+5v0WlsF5GAkSu1XHvhfPDyAOfOQjY
         bPJ9uj2UwTATxohb3MCZmgAEdxlLzH2T4Fe7z6L66TmAYOmD71WpcbW8WwH66ivSvsBA
         7i1g==
X-Gm-Message-State: APt69E04YVw2OKAlut1To3GQZuE6EB9NGCTPDLbop3vSTdnlhRi37DLv
        a8x/ASsnFnUR/0Hbi31sR0o=
X-Google-Smtp-Source: ADUXVKKCIo4xyWw6htseAoC56FNbqqPNn7oLLwJEf5PYyHGI6aue7NHIJG10lc9n/lDe9GhTwAOwjg==
X-Received: by 2002:a63:7b1e:: with SMTP id w30-v6mr6238478pgc.402.1529197916277;
        Sat, 16 Jun 2018 18:11:56 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id h8-v6sm13207119pgq.35.2018.06.16.18.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 18:11:55 -0700 (PDT)
Date:   Sun, 17 Jun 2018 10:11:53 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-kbuild@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Resolve -Wattribute-alias warnings from
 SYSCALL_DEFINEx()
Message-ID: <20180617011153.GA24595@lianli.shorne-pla.net>
References: <20180616005323.7938-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616005323.7938-1-paul.burton@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <shorne@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shorne@gmail.com
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

On Fri, Jun 15, 2018 at 05:53:19PM -0700, Paul Burton wrote:
> This series introduces infrastructure allowing compiler diagnostics to
> be disabled or their severity modified for specific pieces of code, with
> suitable abstractions to prevent that code from becoming tied to a
> specific compiler.
> 
> This infrastructure is then used to disable the -Wattribute-alias
> warning around syscall definitions, which rely on type mismatches to
> sanitize arguments.
> 
> Finally PowerPC-specific #pragma's are removed now that the generic code
> is handling this.
> 
> The series takes Arnd's RFC patches & addresses the review comments they
> received. The most notable effect of this series to to avoid warnings &
> build failures caused by -Wattribute-alias when compiling the kernel
> with GCC 8.
> 
> Applies cleanly atop master as of 9215310cf13b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> 
> Thanks,
>     Paul
> 
> Arnd Bergmann (2):
>   kbuild: add macro for controlling warnings to linux/compiler.h
>   disable -Wattribute-alias warning for SYSCALL_DEFINEx()
> 
> Paul Burton (1):
>   Revert "powerpc: fix build failure by disabling attribute-alias
>     warning in pci_32"
> 
>  arch/powerpc/kernel/pci_32.c   |  4 ---
>  include/linux/compat.h         |  8 ++++-
>  include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>  include/linux/compiler_types.h | 18 ++++++++++
>  include/linux/syscalls.h       |  4 +++
>  5 files changed, 95 insertions(+), 5 deletions(-)

Hello Paul,

I tested the series out with the new OpenRISC 9.0.0 port and the
-Wattribute-alias warnings are gone.  Thank you.

Using toolchain binaries from:
  https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180613

For the series:

Tested-by: Stafford Horne <shorne@gmail.com>

-Stafford
