Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2018 10:41:32 +0200 (CEST)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:54835 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994659AbeFWIlZR5CCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2018 10:41:25 +0200
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5N8erVd018899
        for <linux-mips@linux-mips.org>; Sat, 23 Jun 2018 17:40:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5N8erVd018899
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529743254;
        bh=eoVsUjrTCNVbfRDhPiyiF8cS5j9cLMlWN9SNBp4SvRE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=inwH6OMZSoIisRUzGlywshODTb6vj0P/lfbw2nQA3qtYDG3LBTMcMJGaiWIRvSxes
         iHFMiPEmtDQV+jdVuMRm5WpS3QczvoomeNI4hrBmOy98dRDCFab/1jlwM7nmOvmjSk
         A0si1XiSvO1bU61IrjTN2cCtp9RIf+JmqwveFtkRMwxJz7JMCsgE9T6RNSzauFa3kL
         qjKV56kjIgjqYhnttnv2+noij7X0FYJIbbZuLjQ0FIyqxNxsIwTGvUXcZAfUDpQ/TX
         5mV5mELRU/2ZxMlcYUgQdoe7FaqVu82nAtEnPwlYr/pjhGtbsNPDCLnnuo4j4dcXMA
         qQgIVzh/5yQqQ==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id d7-v6so5737526uam.13
        for <linux-mips@linux-mips.org>; Sat, 23 Jun 2018 01:40:54 -0700 (PDT)
X-Gm-Message-State: APt69E1FIK7X7GuuFI5M3bzoeEpMg+UFVSWBz966j+P5Sbq5VmY8e8tD
        tYBad3VYWJtTepMgko+t86gG4cNVB38TQhnIrKA=
X-Google-Smtp-Source: ADUXVKLbneVmWlz9qLuHHbq/Py7D9yIJ4hd7iRXjntCtjzeSE7YQuyE668QU/QUkt4n6gbVfkPMed3SIr8W6qQTKv8Q=
X-Received: by 2002:a9f:3d6b:: with SMTP id m43-v6mr3131588uai.17.1529743253133;
 Sat, 23 Jun 2018 01:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 01:40:12
 -0700 (PDT)
In-Reply-To: <20180619201458.4559-1-paul.burton@mips.com>
References: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop> <20180619201458.4559-1-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 23 Jun 2018 17:40:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFqH7a1ZLhp_aLQXTPxODPbctVwEZ+5SL1OMp0kRQJGQ@mail.gmail.com>
Message-ID: <CAK7LNASFqH7a1ZLhp_aLQXTPxODPbctVwEZ+5SL1OMp0kRQJGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Resolve -Wattribute-alias warnings from SYSCALL_DEFINEx()
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
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
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2018-06-20 5:14 GMT+09:00 Paul Burton <paul.burton@mips.com>:
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
> Applies cleanly atop v4.18-rc1.


Series, applied to linux-kbuild/fixes.
(since we need to fix warnings from GCC 8.1)


Thanks!



-- 
Best Regards
Masahiro Yamada
