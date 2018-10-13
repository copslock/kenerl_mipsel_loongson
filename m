Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:39:56 +0200 (CEST)
Received: from mail-io1-xd42.google.com ([IPv6:2607:f8b0:4864:20::d42]:41483
        "EHLO mail-io1-xd42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994583AbeJMBjxKZFNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:39:53 +0200
Received: by mail-io1-xd42.google.com with SMTP id q4-v6so10537567iob.8
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
        b=mRAnllfVhCFMlnCIOcENVRpZ9fWtdthn5GIa/84lOa1zfYRyC7orxaopMW45sB8eGB
         ivJ95/M5otzqwf+a9a0kBxZZQSGJZfhDMo+nmJKVkyBRnP8qxtUI1xy15rJyzhFmnyt0
         8+wcDDhVwfzIxE7o4UdypM1uFOyBZO+dsZHL9V9EjcRk/t9uN1N8+jXX+FQbQNwLNM6+
         Yw/NuPi1khJ60fOVJAglTvakPu+RdegP9nyurUbv1ptWNwxhwQDL9ydwtFB3Y4wuPcbb
         mQP4MZorbCaZStz3SOglr9oedZvionoAiMgHFAr+d3BHihJaHkX9rSbjnDxfL9w+LOjP
         xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Wde0HcwExXY831MfxZDBcHjXK7XvngyeZU1X9StNjyk=;
        b=r5rd9B4owF4WcaPRRMZy79KjakthbW5b+c1MVcha1c0MJ1OLnLkUGto/QYE3uI2zNc
         HNnimdREdjlcy2mwdiw6KQ0fFRKdjNdO8MTzVrU1kztXT2YAg2DjsqKnPOmyEjEXUsGT
         tGjYhpmLoGHFuhL+bsikMcG5f/HEYH8vIMaBfKVTfa+otYaAs0jp6RP24YnF3044td44
         ZeqAcAetP4h833jep5IJ16STFmmNxZ/6FT3uThY64wFMcHrkRLfPV1VEJiGBjVST2hlp
         21coymXbn+tVuF4xOsEGNQwjpRpLIKYfxLuvn/IwrH05FmB37QKivrlLpsRIfuekJiiF
         ithQ==
X-Gm-Message-State: ABuFfoj2tAzJxWPfuWo5Gk/X28d5EFtXPHHJTifvnnzs6yJ6zSzFaN0u
        p50ReEn2SA3w151bLR9f80YcM6mll2pJcr8TSxoRrw==
X-Google-Smtp-Source: ACcGV63O+2oHow+MnmDFFN/fGr+ypIXJq0Jebw7vm8a3hwEac10cSSqcJGLdjRO5qFIM+0mJ+lFBqqSZgai2siyMk8M=
X-Received: by 2002:a6b:b249:: with SMTP id b70-v6mr5998814iof.252.1539394786418;
 Fri, 12 Oct 2018 18:39:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d604:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:39:45
 -0700 (PDT)
In-Reply-To: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 18:39:45 -0700
Message-ID: <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     David Miller <davem@davemloft.net>, kirill@shutemov.name,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Minchan Kim <minchan@kernel.org>,
        Ramon Pantin <pantin@google.com>, hughd@google.com,
        Lokesh Gidra <lokeshgidra@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        aryabinin@virtuozzo.com, luto@kernel.org, bp@alien8.de,
        catalin.marinas@arm.com, chris@zankel.net,
        dave.hansen@linux.intel.com, elfring@users.sourceforge.net,
        fenghua.yu@intel.com, geert@linux-m68k.org, gxt@pku.edu.cn,
        deller@gmx.de, mingo@redhat.com, jejb@parisc-linux.org,
        jdike@addtoit.com, jonas@southpole.se, Julia.Lawall@lip6.fr,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        lftan@altera.com, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm <linux-mm@kvack.org>, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org,
        Peter Zijlstra <peterz@infradead.org>, richard@nod.at
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dancol@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66809
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

Not 32-bit ARM?

On Fri, Oct 12, 2018 at 6:35 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
>> From: Joel Fernandes <joel@joelfernandes.org>
> [...]
>> > Also, do we not flush the caches from any path when we munmap
>> > address space?  We do call do_munmap on the old mapping from mremap
>> > after moving to the new one.
>>
>> Sparc makes sure that shared mapping have consistent colors.  Therefore
>> all that's left are private mappings and those will be initialized by
>> block stores to clear the page out or similar.
>>
>> Also, when creating new mappings, we flush the D-cache when necessary
>> in update_mmu_cache().
>>
>> We also maintain a bit in the page struct to track when a page which
>> was potentially written to on one cpu ends up mapped into another
>> address space and flush as necessary.
>>
>> The cache is write-through, which simplifies the preconditions we have
>> to maintain.
>
> Makes sense, thanks. For the moment I sent patches to enable this on arm64
> and x86. We can enable it on sparc as well at a later time as it sounds it
> could be a safe optimization to apply to that architecture as well.
>
> thanks,
>
>  - Joel
>
