Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 13:05:51 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35257
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdL1MFlYScUk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 13:05:41 +0100
Received: by mail-wm0-x242.google.com with SMTP id a79so4603829wma.0;
        Thu, 28 Dec 2017 04:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8ThJi7Z19P8NCi218uOeC+PtbUEzzH9qTe4znqO9Jc=;
        b=OBLVxxbO8+Vx5UEpGux2MC8vFl4nwwfoRSJ52dKsoEiYzjd071J8LvFSYi7qNbwt6a
         NEuxZgCirVw7bw9ys3ISv3R3ffHJBRQpcBrpGE5i3syKHdM8H3/qDzj/+f6fE2LkWECG
         mlleRlqATnkBXP0QU0m2Uj42/JaMAi+qefSZorrBQKm3vlqt5Muq1aiS7ja7p0EZ/ocu
         tw4t8tgWAbm08elPVXHUFEhiCb8MiDAqN/xZ12TPFeF+qOszjXao9s6b9h27ObBCfjnP
         MyLFWcI6iGAFrrZ/LNpFht7axUJpypFaswfrBRrsC/AGjfUIThlJzXQeBFu5zptVJAQM
         ZR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8ThJi7Z19P8NCi218uOeC+PtbUEzzH9qTe4znqO9Jc=;
        b=HJ3lJ/nm4i2l89+zQnq9j9PpnlyVhfSCmZ8rFrNQAPHhU1VJF3QvMlm6F9+po4mbdL
         Nz2MWkRnMC30nvp+jgBz42+vgYcuvYkNSE4vBp3nJZgLQ3vdkgO58uh20RR1VqxJWiu0
         2DwTEYzsYC8Z5WYX6mLGqMK1057EL8kXhiFaNvsubBHc8jfpKghATlqFWM53AYt/S20v
         x+fCUZEc0T6S8YfVoDh45/TQXhfb2AuhXZ65LpqezxnfTNdPSF93wmG3rgKhWHLaeMcs
         37fMCCP0dNrGp4UQdJtB7ZM9BwTsZ93vRIouXvaTV8hog4JdlYdlvY/1dBC0EBZhN2tB
         tFMA==
X-Gm-Message-State: AKGB3mKcqY6B2toGszAtxsGXblKH/p7h2wmrvbc/FOQTzZ1U+C890ok4
        V5EnGLbX7bafYXGfeb7aaoE=
X-Google-Smtp-Source: ACJfBotJpPO8iFRJRqPXsv7ofnZU0DTEWym92+efYtf+s1GF4Y1ls6Zy5zJ3rwj22nrQ149ypIdbUQ==
X-Received: by 10.28.207.130 with SMTP id f124mr23621528wmg.132.1514462735083;
        Thu, 28 Dec 2017 04:05:35 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l17sm35171860wrl.9.2017.12.28.04.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 04:05:34 -0800 (PST)
Date:   Thu, 28 Dec 2017 13:05:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mips <linux-mips@linux-mips.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab
 entries
Message-ID: <20171228120531.xhcb4dg2qu2z5ssp@gmail.com>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
 <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
 <CA+55aFzygF6P3v5VxyBucZfn-tg58jeV6qwt0y7QGmmNiKYghQ@mail.gmail.com>
 <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-wRtfnGfrEjuxR5YkCpZM-nQHZShROEdbcEh=fSiWf5A@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> Annoyingly, we need this because there is a single instance of a
> special section that ends up in the EFI stub code: we build lib/sort.c
> again as a EFI libstub object, and given that sort() is exported, we
> end up with a ksymtab section in the EFI stub. The sort() thing has
> caused issues before [0], so perhaps I should just clone sort.c into
> drivers/firmware/efi/libstub and get rid of that hack.
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=29f9007b3182ab3f328a31da13e6b1c9072f7a95

If the root problem is early bootstrap code randomly using generic facility that 
isn't __init, then we should definitely improve tooling to at least detect these 
problems.

As bootstrap code gets improved (KASLR, more complex decompression, etc. etc.) we 
keep using new bits of generic facilities...

So this should definitely not be hidden by open coding that function (which has 
various other disadvantages as well), but should be turned from silent breakage 
either into non-breakage (and do so not only for sort() but for other generic 
functions as well), or should be turned into a build failure.

Thanks,

	Ingo
