Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 04:25:19 +0200 (CEST)
Received: from mail-ot1-x344.google.com ([IPv6:2607:f8b0:4864:20::344]:42716
        "EHLO mail-ot1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990403AbeJMCZQCSF0L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 04:25:16 +0200
Received: by mail-ot1-x344.google.com with SMTP id c23so12338169otl.9
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
        b=uV2twWkmECSPrusRnN/vXPmvBFYTjOqR8hUGj7uFIqFnja6HWyEE59/EX6URRSK7ei
         bsLQO8pq96Yj7M5G0CjsRbi5afMpRO5p6LGi6gqkF1Fsb96X2cpi7a6HzEjPHM5S5b/+
         frAsPOqLD9LWEf7OVOqxvcQcS5euFpCDZTZ4mQNwNIu+I5BIdazSX176UsMrE2WE7yqy
         vEzD1H9jpf2yN7Z39bZVobe1cuQmeBj/6yYghOi4Eg5BRvkIX/X2/Np9eIx+7MbesZ3i
         M/WKTCz0rPGomijvt/NLvxi250WzkhscHNYFINjgKIa6h6fyG7Vk/yjb5v+LZqg963lC
         Fyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AVT8yt4SB5J9DoLXgmc7fyXmf+sZ/QolyovgztLAQ10=;
        b=NScBcsO22+ngT4ZOebM783UUnxCxgpMDX6VyvfVtANK/jsRJbNfzMmZL/tmNJK5+iW
         7de3886bhwvv11d3rlA9qssq09HXPd5rVgKQQWNPNCFSg139n4rAsEdGoyXYHh+vxfEF
         cJAYqfV7pZfqiUEhtXLlidNYaTMOd/BDu1u+wiT1//F1WGJnnZRtGLt2CJIZWPshL+OV
         Qgq8/x6362vagn3qtbt69myEqaUzEb/3v0SHvsbJdBK1pbV4IDkx9Yfrn+8nNc8xVLRX
         cUNlSHW9qaprH/T+CYYPRINl63REbhZ42BZHzP2OYOAP7aMmwSA5Te7QY6LZk3ndKYw7
         UWvQ==
X-Gm-Message-State: ABuFfogHC+uePMT+5bzsPp/TtTbbzKXzpoCcR5Offt4Gb1O0vCEw3k5r
        VD92bLJcknlqOZ7caWmmgg2ElHixw5+9sTDw9A6Kaw==
X-Google-Smtp-Source: ACcGV626tmOS/hq+IOOBvcyLVHGavVFHf8rpMv7Ej7UrZuwws9AFWJei17jzLnNTEoqbyX0OG7eWDPlqeQQBpHBj980=
X-Received: by 2002:a9d:62cb:: with SMTP id z11mr5748873otk.342.1539397509267;
 Fri, 12 Oct 2018 19:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 19:25:08
 -0700 (PDT)
In-Reply-To: <20181013021057.GA213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com> <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
 <20181013021057.GA213522@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 19:25:08 -0700
Message-ID: <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>,
        Hugh Dickins <hughd@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, Chris Zankel <chris@zankel.net>,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dancol@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dancol@google.com
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

On Fri, Oct 12, 2018 at 7:10 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:54:33PM -0700, Daniel Colascione wrote:
>> I wonder whether it makes sense to expose to userspace somehow whether
>> mremap is "fast" for a particular architecture. If a feature relies on
>> fast mremap, it might be better for some userland component to disable
>> that feature entirely rather than blindly use mremap and end up
>> performing very poorly. If we're disabling fast mremap when THP is
>> enabled, the userland component can't just rely on an architecture
>> switch and some kind of runtime feature detection becomes even more
>> important.
>
> I hate to point out that its forbidden to top post on LKML :-)
> https://kernelnewbies.org/mailinglistguidelines
> So don't that Mr. Dan! :D

Guilty as charged. I really should switch back to Gnus. :-)

> But anyway, I think this runtime detection thing is not needed. THP is
> actually expected to be as fast as this anyway, so if that's available then
> we should already be as fast.

Ah, I think the commit message is confusing. (Or else I'm misreading
the patch now.) It's not quite that we're disabling the feature when
THP is enabled anywhere, but rather that we use the move_huge_pmd path
for huge PMDs and use the new code only for non-huge PMDs. (Right?) If
that's the case, the commit message shouldn't say "Incase THP is
enabled, the optimization is skipped". Even if THP is enabled on a
system generally, we might use the new PMD-moving code for mapping
types that don't support THP-ization, right?

> This is for non-THP where THP cannot be enabled
> and there is still room for some improvement. Most/all architectures will be
> just fine with this. This flag is more of a safety-net type of thing where in
> the future if there is this one or two weird architectures that don't play
> well, then they can turn it off at the architecture level by not selecting
> the flag. See my latest patches for the per-architecture compile-time
> controls. Ideally we'd like to blanket turn it on on all, but this is just
> playing it extra safe as Kirill and me were discussing on other threads.

Sure. I'm just pointing out that the 500x performance different turns
the operation into a qualitatively different feature, so if we expect
to actually ship a mainstream architecture without support for this
thing, we should make it explicit. If we're not, we shouldn't.
