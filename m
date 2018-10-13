Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 19:50:56 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:33032
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990418AbeJMRusvmAKn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 19:50:48 +0200
Received: by mail-pg1-x544.google.com with SMTP id y18-v6so7289326pge.0
        for <linux-mips@linux-mips.org>; Sat, 13 Oct 2018 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GoWsMygASIRyu7PZgD3N2dBBnQZB9nQ/7GbuLV2HYnY=;
        b=gtX/3bFKdysbo0S38lPP9ATjDdsTysp7ptOg+SsEzBQmc5jRhOODzCYik6fd+BjPNr
         xu2Vp+XyGO4o3VTbAkLtyvZfSWRtUUHxernM8wIzLOXHfZUYx/YsB2m5iu16tCWuQG1m
         dx/4Vn6wKESA5zdAVp2ssOawvrRQIiujDiDAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GoWsMygASIRyu7PZgD3N2dBBnQZB9nQ/7GbuLV2HYnY=;
        b=hUZv8Ev73Em7+q3yVjrodkNg1lcCzrDwnw5AR5MHL11RJbHsx8FA9sk5fbGuB62/9+
         QNhCLX2QJmFhibvH0k8SC4Fo7+PwHpvZui60ekiIpE55wxtR8dydjWK6gt1zkVjffky2
         Mbeub8mbB7BxhyARP8PXRXGX9iP6VKqEAQbRHzwz79hIamHmXBh2kJyuRwFH8hHQn6mx
         QBBMWR8ybrTDetiRmgJt1FS6KlpcydxZ/UwWrln6X4CozjNsSVsshu8cYh2bXS6SytPH
         5IoJuSIFauCVLyV8DOMXguHqhLrT95rg1pn1jFjtCAWuGqz+SyRR7uMksHkfFnJQsJUt
         R3HQ==
X-Gm-Message-State: ABuFfoi6Off7a1DfW5xdRJk8NxHLT0xWSkJ32uyK3KbbaVSxxB685oBP
        GT7+2ceGJsOzWUCA9/gf0x+mzQ==
X-Google-Smtp-Source: ACcGV61mIIBnEva6K1s4pwIUv1udY8Qs2DvoHn+puuc+AYRgF7l/b6wUFQE1+gRiz97iAhmfFDPhRQ==
X-Received: by 2002:a63:f64f:: with SMTP id u15-v6mr10134944pgj.258.1539453041895;
        Sat, 13 Oct 2018 10:50:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id t26-v6sm7479626pfa.158.2018.10.13.10.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 10:50:40 -0700 (PDT)
Date:   Sat, 13 Oct 2018 10:50:39 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     dancol@google.com
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
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013175039.GB213522@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
 <20181013014429.GB207108@joelaf.mtv.corp.google.com>
 <CAKOZues25aaKz3_AiyfJ=r2QBd5MghgY3ky_ptg4Z8=ST4DCgw@mail.gmail.com>
 <20181013021057.GA213522@joelaf.mtv.corp.google.com>
 <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueu2wdkeUFYLQ8qE48yJs1_uRz-9RVJRkp==CL=jp=Q8+g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@joelfernandes.org
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

On Fri, Oct 12, 2018 at 07:25:08PM -0700, Daniel Colascione wrote:
[...] 
> > But anyway, I think this runtime detection thing is not needed. THP is
> > actually expected to be as fast as this anyway, so if that's available then
> > we should already be as fast.
> 
> Ah, I think the commit message is confusing. (Or else I'm misreading
> the patch now.) It's not quite that we're disabling the feature when
> THP is enabled anywhere, but rather that we use the move_huge_pmd path
> for huge PMDs and use the new code only for non-huge PMDs. (Right?) If
> that's the case, the commit message shouldn't say "Incase THP is
> enabled, the optimization is skipped". Even if THP is enabled on a
> system generally, we might use the new PMD-moving code for mapping
> types that don't support THP-ization, right?

That is true. Ok, I guess I can update the commit message to be more accurate
about that.

> > This is for non-THP where THP cannot be enabled
> > and there is still room for some improvement. Most/all architectures will be
> > just fine with this. This flag is more of a safety-net type of thing where in
> > the future if there is this one or two weird architectures that don't play
> > well, then they can turn it off at the architecture level by not selecting
> > the flag. See my latest patches for the per-architecture compile-time
> > controls. Ideally we'd like to blanket turn it on on all, but this is just
> > playing it extra safe as Kirill and me were discussing on other threads.
> 
> Sure. I'm just pointing out that the 500x performance different turns
> the operation into a qualitatively different feature, so if we expect
> to actually ship a mainstream architecture without support for this
> thing, we should make it explicit. If we're not, we shouldn't.

We can make it explicit by enabling it in such a mainstream architecture is
my point. Also if the optimization is not doing what its supposed to, then
userspace will also just know by measuring the time.

thanks,

 - Joel
