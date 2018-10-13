Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:54:44 +0200 (CEST)
Received: from mail-ot1-x344.google.com ([IPv6:2607:f8b0:4864:20::344]:42581
        "EHLO mail-ot1-x344.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994586AbeJMBylOFh7y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:54:41 +0200
Received: by mail-ot1-x344.google.com with SMTP id c23so12301608otl.9
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
        b=oO7CQBJ0o3h4W+oksCLNlcAMMdo7sg4Jtv1VCUZcuw6SrUuKQoC7/yRbVEByqVegR5
         2XakAmI6gLBq49bXmjVYz4+acBeAcuwKtUHPjj2sGXy+jzOkdhqdTL0YPcZPqB+LKt6o
         bhRful9oO7cRR8nbmHw1A7uqI9ttcB1fV31XpSXw7a9IcC+joMzcgVc8TxQKKcRQt8Re
         zoNMfZUWu+1do2+6RW0MSWVyN/9DUjKrGt5dJpbjxpWiCS22HxYleuy9uZIoJeze7/q0
         zCoyyhRBLvqgZ71FAynWB3xe4pRvB3ibgZGe60xwaYIUrVPx8bwkXyzud+F7R7U1MaXx
         /VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ruDqHADLGhUq/OqjXNRFevT5jDn0habRcwA3l0QGuG8=;
        b=gSZACsvcbeQxZ+wNWVc0DlOCBAF7U2IS/19U+OONel89o35Yokac8W/cv8NsnJ45zD
         CcxuiU89vvrXHP+mjHZ+1ln6THrOSkpV5kDUsfrPeSmKeTpzPCivXgR3x6QvUVgDUTZL
         0J5RWhYXV7rUCsCT5yRNVYHu74Tunn1fEKx1GnBzLDOFblc5kAXMoM0LkyKY+vCKp762
         GaklAuo0T+hAOfzSDCVQ/EAHfc+mUoR7ps7Hq6ZBrELu2y+21kjGPO1S56Yi7v+cQ6b+
         Zhya8hot2ytscFSvHFazmrfFRpOU7C0783OR2PQG2mKUnBqn71D86nwfMTNtiF4LcAnS
         FjGQ==
X-Gm-Message-State: ABuFfojl23vxfDo6Wz32hxnZuZmlC0S90jINoIGZzUq7UwdVVPJC11V9
        oGPq4EhHfWjdXkhioetNaIVsuQAtqSLCjbqhCIj88A==
X-Google-Smtp-Source: ACcGV61wTHJT8KA0FRbB4T8HJavFhx8DCnBEFcv7It/8YmRplkdtkLJbpEFBtddWCai0iE4efhP92rfUMrMKw3tumlM=
X-Received: by 2002:a9d:3a21:: with SMTP id j30mr2325823otc.237.1539395674440;
 Fri, 12 Oct 2018 18:54:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:56d8:0:0:0:0:0 with HTTP; Fri, 12 Oct 2018 18:54:33
 -0700 (PDT)
In-Reply-To: <20181013014429.GB207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1> <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net> <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com> <20181013014429.GB207108@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Oct 2018 18:54:33 -0700
Message-ID: <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
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
X-archive-position: 66811
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

I wonder whether it makes sense to expose to userspace somehow whether
mremap is "fast" for a particular architecture. If a feature relies on
fast mremap, it might be better for some userland component to disable
that feature entirely rather than blindly use mremap and end up
performing very poorly. If we're disabling fast mremap when THP is
enabled, the userland component can't just rely on an architecture
switch and some kind of runtime feature detection becomes even more
important.

On Fri, Oct 12, 2018 at 6:44 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Fri, Oct 12, 2018 at 06:39:45PM -0700, Daniel Colascione wrote:
>> Not 32-bit ARM?
>
> Well, I didn't want to enable every possible architecture we could in a
> single go. Certainly arm32 can be a follow on enablement as can be other
> architectures. The point of this series is to upstream this feature and
> enable a hand-picked few architectures as a first step.
>
> thanks,
>
>  - Joel
>
