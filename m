Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 18:55:22 +0200 (CEST)
Received: from mail-vk0-x244.google.com ([IPv6:2607:f8b0:400c:c05::244]:44268
        "EHLO mail-vk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992368AbeC1QzPkt9Df (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 18:55:15 +0200
Received: by mail-vk0-x244.google.com with SMTP id r184so1777782vke.11
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2018 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
        b=Lx1Vfi6yJqWrk1pgViO0DgQ285NcZoeX+UGmhSU2NqtiH3UixP0Udx+CBKPlh+YJeJ
         4O8wQLEaCJnilRvLNSPCIJSQMj8ruEnIM8+Zf/oRzJ1Va457UzxvTo4PW68JoLuN6P4P
         GNrTXMmb+tlcqPBXn/8VEcBpN3AI/WNZGCluyF0/Gf1PYLptxfEEhQvQ8TjLcXX5dTvE
         aIeMZUjVhtai7se5GoqzszeC23WbtG8N10RKDO1/GGSUEkQXtuxAaFLQjNIrtiByFSz1
         Mr/5RZb1qQXmSqcsKp7cXqxlgNer/ohpi99IJPEfpAMfdJOHWgGqHKd6qL8osrBnEGgt
         bYaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
        b=C9F023bTlqZq0HAbWOddgTbqqqsRqW8GD4IYemZscVuxFaWpbKOwZTHUS8yb+YyQg5
         2cjWnzvfiKuOWOWbzWbXuC8UeTPqi0fhSqUmcbILf2MbDc6Zj1hDVodmHq0TPGnSurn+
         /b30MfVfrexApbozsyyihNeUIXACBNGy9INjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=igUoMncjJWqGkLK9YYc5OMgjbea66b9N6X1DVXnuShw=;
        b=D4PawPyFuwRo/4u/1zkS00mMGi2Kock41a+b4O0XcVKI3aN+FMouDT1j+yzvWotT9K
         m5GB+EgaCwojizKfAJUdit2Br+v6J4QUn4jV/Oq0xkkk65fmEeGBocJjVUkltFH3P4hR
         6PKnHWsCQs4E5Y25/s2nLr2OmXxi/deoEqLKogsvbJPveVdcvl44YR8z14bCvCtkX0DH
         1RB8CLtrEvVV+tsVR+abLTkz40rDedFt/JUJaEhcQrtnoFcShLC3q/9q4RoZi+QtYit/
         aT9yp0vrEJTfYPaoNR+l2hudhyaaFWqxjBQoiLwuOWD84erbRMPCrJBGy+obTi3ayebK
         HArg==
X-Gm-Message-State: AElRT7FxwUqT9v2+in0eo5Xu+VLM6hnCAh6oDCVS73JPAoplcYmOm8yS
        yFeoID/QK91QUgAFr5zjbLCeyq33ldAxp5X/nqlegg==
X-Google-Smtp-Source: AIpwx4/AaLNWnGImizTYImMY7WTQ/KVrr96pT4C3C5y6iI+e3+5ICgEO9lC7H7JLJZic5Jr9QqExXYJ9ZLR+fu29qKM=
X-Received: by 10.31.24.149 with SMTP id 143mr2811806vky.123.1522256108393;
 Wed, 28 Mar 2018 09:55:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.129.9 with HTTP; Wed, 28 Mar 2018 09:55:07 -0700 (PDT)
In-Reply-To: <20180328152714.6103-1-shea@shealevy.com>
References: <20180325221853.10839-1-shea@shealevy.com> <20180328152714.6103-1-shea@shealevy.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 28 Mar 2018 09:55:07 -0700
X-Google-Sender-Auth: pJbrkNlGYsOjm2QGq3dxmEwoNP4
Message-ID: <CAGXu5jLioqnOQniXuuNS=PjeAgJr1=BL78Cqu0cwu_Y5e-NDZA@mail.gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Shea Levy <shea@shealevy.com>
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Landley <rob@landley.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Wed, Mar 28, 2018 at 8:26 AM, Shea Levy <shea@shealevy.com> wrote:
> Now only those architectures that have custom initrd free requirements
> need to define free_initrd_mem.
>
> Signed-off-by: Shea Levy <shea@shealevy.com>

Yay consolidation! :)

> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>         default ".lzma" if RD_LZMA
>         default ".bz2"  if RD_BZIP2
>         default ""
> +
> +config HAVE_ARCH_FREE_INITRD_MEM
> +       bool
> +       default n

If you keep the Kconfig, you can leave off "default n", and I'd
suggest adding a help section just to describe what the per-arch
responsibilities are when select-ing the config. (See
HAVE_ARCH_SECCOMP_FILTER for an example.)

-Kees

-- 
Kees Cook
Pixel Security
