Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2018 02:50:19 +0200 (CEST)
Received: from ozlabs.org ([IPv6:2401:3900:2:1::2]:45899 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994690AbeFUAuMY-we0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jun 2018 02:50:12 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41B35B2zB3z9s2L;
        Thu, 21 Jun 2018 10:50:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Build regressions/improvements in v4.18-rc1
In-Reply-To: <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
References: <20180618091729.11091-1-geert@linux-m68k.org> <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com> <87vaafxp0k.fsf@concordia.ellerman.id.au> <CAMuHMdUfHJS-ykNr-vPPUDfGLsGr62c4R=EThw33-DFNj9ZQNg@mail.gmail.com>
Date:   Thu, 21 Jun 2018 10:50:05 +1000
Message-ID: <87efh1vu82.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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
> On Tue, Jun 19, 2018 at 8:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> > On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
>> > <geert@linux-m68k.org> wrote:
>> >> Below is the list of build error/warning regressions/improvements in
>> >> v4.18-rc1[1] compared to v4.17[2].
...
>
>> Relatedly I might move all the randconfig targets from Linus' tree into
>> a separate "linus-rand" tree, so that they don't pollute the results, as
>> I've done for linux-next.
>
> Sounds look a good thing.

OK done.

See eg:
  http://kisskb.ellerman.id.au/kisskb/head/14180/


At the moment the "head" page shows the progress/successful for that
head across all branches, so the linus-rand results get counted together
with the linus results which is a bit annoying.

I'm working on a change so that you can view a head *on a branch* so
that you only see the progress/successful for that branch. I'll try and
polish that up and get it pushed RSN.

cheers
