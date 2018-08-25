Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2018 23:03:05 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:33880
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994561AbeHYVDBbbhpV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Aug 2018 23:03:01 +0200
Received: by mail-io0-x243.google.com with SMTP id c22-v6so9860492iob.1;
        Sat, 25 Aug 2018 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJE4B6eA+W3iZhwqnRGz2FAQ/QDMOA2EZwNKQJzar6g=;
        b=evDel4DiMe2DRvSNssNFeZiN0LSsFD0TCJaQq0lyprQ3Ac3ljg3/uzk/PrSWhb6wSm
         jgCPEBxdp9nSAehEGexGM9u+FAB8Yf+/kEWcm9n8816uHzIIcqz8E8fDtlSeB4JmxMng
         9O7FKBtuY87vfVQCmDcI0Up0jlgIM8A3SwDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJE4B6eA+W3iZhwqnRGz2FAQ/QDMOA2EZwNKQJzar6g=;
        b=kSxRtUw6DgHJw9l2G/DrpWTmeu+iz6vh6SkqIGlxzlyKamn8dtepCN1dGHGcwjwTLZ
         6jOLgGItiuzle5bT7L1Th4TdNvUEnZvKtFG4WhaNGIi4KVEO5TNdhNzTShw9O3R5CB8r
         Fn18XpHUolwMc1sDhrXnrozF53otDXF6U7tO6oOpA6WrwlnLrZy7rWDxQ/HXsduR71WD
         +YU63EBdXYBW+PxTtCkC5IbP40lzpks8fHm5qwARGseau+wT5n8aYWSEouGMNn7E3TUb
         d2a0TiRtyWI2iY2OMXNHNpK4UUDOHHCLB2irIl1KnsXh8ip/3vXeo/JhyjLmZems8HzA
         QJIw==
X-Gm-Message-State: APzg51AYpI3frdAUlRqwE960rq8UEl2rCnIMYHqt2xkeSxQJ7EW4pKR7
        Orj0Qv2+Ct7JHbeK+WpQAHdvkFrauMMMOYMzBLA=
X-Google-Smtp-Source: ANB0VdZsz/LlDcNWTotprzqO/Dp/NYFQ+O2JkLsawy4Lm6L1X37lCqxuTtoOCx68NEk0xSoN1razF6gqj32hb4tSLmA=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr5881201ioh.203.1535230974881;
 Sat, 25 Aug 2018 14:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
 <20180821202900.208417-1-ndesaulniers@google.com>
In-Reply-To: <20180821202900.208417-1-ndesaulniers@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Aug 2018 14:02:43 -0700
Message-ID: <CA+55aFxL-u3uvGGv0GOoHhEwV8fy=BCN1yScxKQiVMPoHtg=Wg@mail.gmail.com>
Subject: Re: [PATCH] treewide: remove current_text_addr
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Simon Horman <horms@verge.net.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>, jacquiot.aurelien@gmail.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greentime Hu <green.hu@gmail.com>, deanbo422@gmail.com,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>, gxt@pku.edu.cn,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>, noamc@ezchip.com,
        mickael.guene@st.com, Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, alex.bennee@linaro.org,
        Laura Abbott <labbott@redhat.com>, ynorov@caviumnetworks.com,
        Mark Rutland <mark.rutland@arm.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        sukadev@linux.vnet.ibm.com, Nick Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>,
        felix@linux.vnet.ibm.com, Ram Pai <linuxram@us.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cornelia Huck <cohuck@redhat.com>, gor@linux.vnet.ibm.com,
        nick.alcock@oracle.com, shannon.nelson@oracle.com,
        nagarathnam.muthusamy@oracle.com,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65729
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Tue, Aug 21, 2018 at 1:31 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I suspect that current_text_addr predated GNU C extensions for statement
> expressions and/or taking the address of a label, then the macro was
> reimplemented for every new archs include/asm/processor.h, even though
> there were very few call sites, and none required an assembly
> implementation vs the C implementation.

I actually have this very dim memory that we had some compiler issues
where a label in the code resulted in gcc generating worse code
elsewhere in that same function.

But current_text_addr() predates both the git and the BK history, so
it's all shrouded in antiquity, and even if my dim recollection is
true, it may not be true any more. There aren't so many call sites
that it is likely to matter anyway.

             Linus
