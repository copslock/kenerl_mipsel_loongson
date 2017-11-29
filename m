Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 22:12:39 +0100 (CET)
Received: from mail-oi0-x244.google.com ([IPv6:2607:f8b0:4003:c06::244]:36926
        "EHLO mail-oi0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990482AbdK2VMcEgq18 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 22:12:32 +0100
Received: by mail-oi0-x244.google.com with SMTP id y75so3413364oie.4;
        Wed, 29 Nov 2017 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AUyPk+CBGTAXBkHAOfFHmKLYoy0rLiofpEms7rvt/JI=;
        b=ubdgiVAsVqrIGyeOjejRuwkXVMtUbae58JXKY4Li1Jmz5ZFOGXf1HqmkOaVhyyaAo4
         wYjkO1uUO4rlV3jucLK7v8ySyE75x4XZoTNcB4Li9hVlHPv7neXP9uMf9NNxp7n8Q96c
         00CzlCelSJKlC8tuu4ffbGyyMBX5qaFGqo++fC2SF6vWFOK00eFnwLku4wR89OfhoxT/
         H/qWikDhoUeZKsSWwKRnr41CkAYw8s7m1HDeJL+aZgwmPvqy0J9BCa8/jQdLvu5DGrOY
         Hu5bKlftRVLYWCJPWBNLAoIvuDBEFxCzvhH8wOh6OB7OrX8FYCsyzq7yoZM1hgtvsrW5
         wyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AUyPk+CBGTAXBkHAOfFHmKLYoy0rLiofpEms7rvt/JI=;
        b=NRBAdoOLVxMwLTyPjDBUdK3J1BxNa9ruis+4PmFZuiOM9rMkLJbJtqkYlPcVmmQUTn
         4S/GKvuywLMNewdxyVubQs7wvO0VVBKUILoPv4Pvd8/BiShNN/sorUKykEsl6DUkLOCO
         xEhDg1VDiWAlrc81NLuoCNBikU1U4OAJUslPEF4QUSTp5tilWWCGTEUW1TNHUsJBFzh8
         ce7ralWo503cosHkQBZ8jRpwuiDQ18gQcFk18vIuKvMGKW6TPX5MtDVG5Ybt2+BriLK4
         c7weTSb+vfz22KnQZO/vqYLKPUS0OoU79D8NeR4Z4zoulgIvYhX6hyIqHn/+u/OkyfKy
         rF1A==
X-Gm-Message-State: AJaThX6t2HPB999z5oGJOZ3RyEIBDbvkMxIBKkM7kwmIfvhqz5QA3FAB
        Uoz6G/Lsd8VcRSG2F+zRRo6WvLH7sUCBOd/fxkc=
X-Google-Smtp-Source: AGs4zMZy/sXOsovRHwwKI7cFJuN7WraFQ8mCE34x6yJ5h2P/O4QFdGDVJeaeXGZyLctV10q3u94/8l3RGDnvHbg8FkQ=
X-Received: by 10.202.84.142 with SMTP id i136mr3008523oib.281.1511989944312;
 Wed, 29 Nov 2017 13:12:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Wed, 29 Nov 2017 13:12:23 -0800 (PST)
In-Reply-To: <CABeXuvrtQfSsOipGTnfmONXS45Dqxy4_T7MAcfO4VajoSycW4w@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
 <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com>
 <CAK8P3a26g74UA5J5uQLwdjK3hq+htzjrdTYRKqfy_MawY7st+g@mail.gmail.com> <CABeXuvrtQfSsOipGTnfmONXS45Dqxy4_T7MAcfO4VajoSycW4w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Nov 2017 22:12:23 +0100
X-Google-Sender-Auth: DxwyxmI6OImf9nsOxubkSERkCHk
Message-ID: <CAK8P3a2ho3S3NYp4VL7kOAk-bg3bsUmLaJJVEvNfzPoEue3v3w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
        David Miller <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Nov 29, 2017 at 12:17 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Tue, Nov 28, 2017 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Nov 27, 2017 at 11:29 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Right. There are three options:
>
> 1. Use two configs to identify which syscalls need not be supported by
> new architectures.
> In this case it makes sense to say LEGACY_TIME_SYSCALLS and
> COMPAT_32BIT_TIME both need to be disabled for new architectures. And,
> I can reword the config to what you mention below.
>
> 2. Make the LEGACY_TIME_SYSCALLS eliminate non y2038 safe syscalls
> mentioned below only.
> In this case only the native and compat functions of the below
> mentioned syscalls need to be identified by the config. I like this
> option as this clearly identifies which syscalls are deprecated and do
> not have a 64 bit counterpart. Not all architectures need to support
> turning this off.
>
> 3. If we don't need either 1 or 2, then we could stick with what we
> have today in the series as CONFIG_64BIT_TIME will be deleted and they
> only need #ifdef CONFIG_64BIT.
>
> Let me know if anyone prefers something else.

I think I prefer to have both LEGACY_TIME_SYSCALLS to guard
the native deprecated syscalls (disabled on 32-bit architectures after
the conversion, and enabled on 64-bit architectures until
we merge the next one), and COMPAT_32BIT_TIME to guard the
compat versions of both the deprecated and the non-deprecated
syscalls (enabled on all existing 32-bit architectures after the
conversion, and on 64-bit architectures if they provide a compat
mode for the former).

Those two are not symmetric, but I think those are the most
common combinations, and the Kconfig symbol helps document
what they are.

There is one more category for things like io_getevents() and
rt_sigtimedwait that also need two separate compat versions,
one for 32-bit time_t and one for 64-bit time_t, but it seems better
to deal with those case-by-case rather than introducing another
Kconfig symbol.

        Arnd
