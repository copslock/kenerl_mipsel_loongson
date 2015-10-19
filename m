Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Oct 2015 12:11:20 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.187]:55357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010247AbbJSKLSvIQE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Oct 2015 12:11:18 +0200
Received: from wuerfel.localnet ([134.3.118.24]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0MVqDE-1a3VcN2RPE-00X3I1; Mon, 19 Oct
 2015 12:11:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date:   Mon, 19 Oct 2015 12:11 +0200
Message-ID: <4345582.jiHe94XBb3@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
References: <5082760.FgB9zHNfte@wuerfel> <5152101.mD2bWzUJ2V@wuerfel> <CAMuHMdWbzEFqVctMXTWtdBn2B+guFdphQX5nXUnHPo1szQbtPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:1AZeCkeLMYImW5awHGUYAudMCiFVii6DHvCHgEXjshjDRpxcF8H
 A32EVcA/omZHEabr99KxU1k4UFTxIb/6fifgnZPLwdzKUZ5rZqHExEGg5TZBasAZOJpouy4
 ddDMQW+M8YBxnsz8/0Flg0myz3DXrxwQ4+3NmA5OzrLoitv0Y5w/Ughlr/LgUdEozOdCZUR
 /v+YPZSi5ktb6X88NhSAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nL1Zi8aHqPQ=:KlCVkURdhfGkF+Kp0noarr
 9lrV6bmG66byEJN3xdhR+1bzgiw4FS/mGshwLTSY8nDt+gHBJGFwc9umqbJDdbbgBMwGnCHsw
 RDAvWfNwfTyyEK8LBksgLUCIhMcgO1tdF2xLn5tWurHt1/JZ7AtO11KobSLCPcZiAQv4XazD+
 C96oLfHGFSK1k1yczozZBwjGynJQ14QDfhqbYkcHzpPpNMxWS6Nreos2xnY4G+mUQuMcyNE2D
 F9rkBxnXk9j6YxfbnIuCtGKVttDXRzefL13eqGhfZQVqRW761FXNFJPNcU+D0A1CghlnEYHVJ
 Ahg6H+9nkrAiG3FivsYAjlHXhn0bV6hIXX448xI6Xm8kYHYk4zlUyLxuYE8S0+Itj6A91N63b
 AicHeaD6XX1AdAW9vQXZeRl14yjti6q9c4yTzPo3RO20ztnwqdaeZ5KAdHOvDqu68lpoyIIg8
 rXIqlLbKTdf1DAOHqUaFecvdm/TzPgSglUddWhOmbEsv2ogykcX8ADpuFYc3Sf6GnztB9yiJm
 cCKZwPcXL6gdQwkOOvzJQGxYo+84oSE+6IviHu5HX7C8tY4FQzjMnM4qo0Ax3BQmW/AldSmvm
 lWqrFExg3ThBNUm6NqKad6pNQqxFEWSxzDZ4NUhbpSMHPQ7NGkwrvz/ps82BgS4LM5bYhd7Iz
 zU3EUnIl2LscCud2tKKZmTS4hADFxtxCrAbnwyaoIM2/klTS+59+p0eNE3bL1TH5+5aKhpC18
 RwtnK6GhuAm12kU1
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49597
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

On Monday 19 October 2015 09:34:15 Geert Uytterhoeven wrote:
> On Wed, Oct 7, 2015 at 1:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> >
> > which truncates the result to 32 bit.
> 
> Woops.
> 
> See also my unanswered question in "atomic64 on 32-bit vs 64-bit (was:
> Re: Add virtio gpu driver.)", which is still valid:
> https://lkml.org/lkml/2015/6/28/18
> 

Regarding your question of

> Instead of sprinkling casts, is there any good reason why atomic64_read()
> and atomic64_t aren't "long long" everywhere, cfr. u64?


I assume the answer is that some (all?) 64-bit architectures intentionally
return 'long' here, in order for atomic_long_read() to return 'long' on
all architectures, given the definitions from
include/asm-generic/atomic-long.h

We would have to either change those, or we have to pick between
atomic_long_* or atomic64_* to have a consistent return type.

	Arnd
