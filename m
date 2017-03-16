Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 16:03:57 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991172AbdCPPDu0I8A0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 16:03:50 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A117620219;
        Thu, 16 Mar 2017 15:03:47 +0000 (UTC)
Received: from jouet.infradead.org (unknown [179.97.44.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80AD2022D;
        Thu, 16 Mar 2017 15:03:42 +0000 (UTC)
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id BAF091444C7; Thu, 16 Mar 2017 12:03:38 -0300 (BRT)
Date:   Thu, 16 Mar 2017 12:03:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org, linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: stable build: 203 builds: 4 failed, 199 passed, 5 errors, 41
 warnings (v4.10.1)
Message-ID: <20170316150338.GV12825@kernel.org>
References: <58b2dc6f.cf4d2e0a.f521.74b3@mx.google.com>
 <CAK8P3a32nbd6Wv9wCjmUX+E3gpnWkAWwKurP9dkuwyf_oegCgg@mail.gmail.com>
 <20170315072204.GB26837@kroah.com>
 <CAK8P3a2hmA_f8YZKB=fqpcmeP0wRaq9aEORhVF1kLUWtd0nx6Q@mail.gmail.com>
 <20170316122907.GS12825@kernel.org>
 <20170316124958.GA3620@krava>
 <CAK8P3a1a3uUCQu=FX5n_cLG+wL-LhreNF8fUyavTn5a-87gXLQ@mail.gmail.com>
 <20170316135959.GC3620@krava>
 <CAK8P3a0VCjbVp2Aynq0madWyJ8GCNQD93Fi-M_oy6SkADqKNfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0VCjbVp2Aynq0madWyJ8GCNQD93Fi-M_oy6SkADqKNfQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <acme@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acme@kernel.org
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

Em Thu, Mar 16, 2017 at 03:39:36PM +0100, Arnd Bergmann escreveu:
> On Thu, Mar 16, 2017 at 2:59 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Thu, Mar 16, 2017 at 02:44:45PM +0100, Arnd Bergmann wrote:
> >> On Thu, Mar 16, 2017 at 1:49 PM, Jiri Olsa <jolsa@redhat.com> wrote:
> >> > On Thu, Mar 16, 2017 at 09:29:07AM -0300, Arnaldo Carvalho de Melo wrote:
> >> >> Em Wed, Mar 15, 2017 at 02:15:22PM +0100, Arnd Bergmann escreveu:
> >> >> > On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> >> >> > >
> >> >> > > All now queued up in the stable trees, thanks.
> >> >> >
> >> >> > Like 4.9.y it builds clean except for a couple of stack frame size warnings
> >> >> > and this one that continues to puzzle me.
> >> >> >
> >> >> > /bin/sh: 1: /home/buildslave/workspace/kernel-builder/arch/x86/defconfig/allmodconfig+CONFIG_OF=n/label/builder/next/build-x86/tools/objtool//fixdep:
> >> >> > Permission denied
> >> >>
> >> >> Jiri? Josh?
> >> >
> >> > hum, looks like it imight be related to this fix we did for perf:
> >> >   abb26210a395 perf tools: Force fixdep compilation at the start of the build
> >> >
> >> > it's forcing fixdep to be build as first.. having it as a simple dependency
> >> > (which AFAICS is objtool case), the make -jX occasionaly raced on high cpu
> >> > servers, and executed unfinished binary, hence the permission fail
> >>
> >> It's probably another variation of this bug, but the commit you cite got merged
> >> into 4.10-rc1, while the problem still persists in mainline (4.11-rc2+).
> >
> > the problem is in objtool build right? the fix was for perf build
> 
> Ah, got it. Yes, that must be it then. I supposed we coul duplicate what you
> did for perf in objtool, but a cleaner way would be to generalize it for all of
> tools/, right?

Humm, can't we have just one fixdep?

- Arnaldo
