Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 14:25:57 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:43259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012081AbbD1MZz1eYaJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 14:25:55 +0200
Received: by ozlabs.org (Postfix, from userid 1011)
        id A22AE14016A; Tue, 28 Apr 2015 22:25:52 +1000 (AEST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Matthew Wilcox <willy@linux.intel.com>
Subject: Re: Build regressions/improvements in v4.1-rc1
In-Reply-To: <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org> <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com> <871tj4uara.fsf@rustcorp.com.au> <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.4.1 (x86_64-pc-linux-gnu)
Date:   Tue, 28 Apr 2015 21:54:15 +0930
Message-ID: <87pp6osaog.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <rusty@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
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

Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Can't see that one with a simple grep: can you post warning?
>
> /home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
> /home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
> passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
> type [enabled by default]
> /home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
> 'const struct cpumask *' but argument is of type 'struct nodemask_t *'

Um, I turned the cpu_isset() into cpumask_test_cpu(), but that just
showed this bug up.  The tile maintainers need to fix this one.

Thanks,
Rusty.
