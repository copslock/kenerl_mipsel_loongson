Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 11:23:32 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:37757
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLZKXXj40Gd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 11:23:23 +0100
Received: by mail-it0-x244.google.com with SMTP id d137so22423272itc.2
        for <linux-mips@linux-mips.org>; Tue, 26 Dec 2017 02:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ktfpf63jqZ/wg4QgFlPeSUkAR8Ff6TIuwyzngdyivF8=;
        b=GREoIvY+Jk5GoW5CHfDl0sWE6QjqM4N+CPX3oPU3YbtxHGuH8XRkIPN3HPSjQZEuyp
         Skb4B4r0hm8TlM15PLOz9KL50howOgldY9GtzVwX8/CPNck/gYelgmUUngogrZtMmt+f
         KR1zOumeg1W4nlVQ20q78Ic2sJwuNZgBtpcEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ktfpf63jqZ/wg4QgFlPeSUkAR8Ff6TIuwyzngdyivF8=;
        b=ZUzTQgcTHPBh15qxR5lakCKXZj1cXCPSL0lt2TUoNHOwTEFvLzDFdylxuVm2FsX5gk
         vXexQinqWKI0gj5pkI4ld9SdtNjzwS5CEoBgpBhg4dH9eXyNW6RFAYQVJP1jLF+Asykk
         jICGP7JUxbOaxMkZ6H5+7rrgFOGLUiCidEtZNSTItQBntdPS6nRpwBe2Bqc1Ysh93ncc
         WcLXgzV+JU4AgxG/MHuJ0PABtvfUt8YZWiy4UYa5cWLvMjFwJH+NJVmQXD7sEiTCFDdZ
         s1jIrwl7+2qxNanbwKk9mA5neMiS0BbsW/0Fn3juLl5Fr3Tuc+DXLHZ4kyA4p4f3+Izp
         Ii6w==
X-Gm-Message-State: AKGB3mLGJFGyT0uUW0U9ETrIDPw9qf4Jt50dNoWpaziD1oJuhUGYfDPt
        xVMkD+NohL+SHaDMWNsdqH8hqA1mwnX2ugvinYGH7g==
X-Google-Smtp-Source: ACJfBotL7QdQFZWLVnVckxJFzFENNm0jpcXWr3uelYEFRGjGQqGU83/cjfSuxykrMcw+jW9SwRneqVH7P90iDUXV+FE=
X-Received: by 10.36.219.214 with SMTP id c205mr31365678itg.65.1514283795865;
 Tue, 26 Dec 2017 02:23:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.52.14 with HTTP; Tue, 26 Dec 2017 02:23:15 -0800 (PST)
In-Reply-To: <201712261806.hJg043uc%fengguang.wu@intel.com>
References: <20171225205440.14575-7-ard.biesheuvel@linaro.org> <201712261806.hJg043uc%fengguang.wu@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 26 Dec 2017 10:23:15 +0000
Message-ID: <CAKv+Gu_9L8LDe72FJDDhWVA4G9ZWcuxQnxWRtFMKgH=AhMOiZQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] kernel/jump_label: abstract jump_entry member accessors
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 26 December 2017 at 10:19, kbuild test robot <lkp@intel.com> wrote:
> Hi Ard,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.15-rc5 next-20171222]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/add-support-for-relative-references-in-special-sections/20171226-164147
> config: s390-allmodconfig (attached as .config)
> compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=s390
>

I guess the diffstat gives it away:

>  arch/arm/include/asm/jump_label.h     | 27 ++++++++++++++
>  arch/arm64/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/mips/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/powerpc/include/asm/jump_label.h | 27 ++++++++++++++
>  arch/s390/include/asm/jump_label.h    | 20 +++++++++++
>  arch/sparc/include/asm/jump_label.h   | 27 ++++++++++++++
>  arch/tile/include/asm/jump_label.h    | 27 ++++++++++++++
>  arch/x86/include/asm/jump_label.h     | 27 ++++++++++++++

Will fix in the next revision.
