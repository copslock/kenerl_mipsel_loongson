Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:35:52 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:40306
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994586AbeJMBftTgezy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:35:49 +0200
Received: by mail-pl1-x643.google.com with SMTP id 1-v6so6684528plv.7
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
        b=t/bdXm4ahfHUsC1W/kmIGtZM4IaaXFvhptMHyl/MsEl85wogOLcBRPLXwHtXoa2xTR
         d2M48uB6euL4d5IaKV5t6nT5ABUr0y0qRBKJlUNuiclAcNB1bktYaPSMWAk89SYK1P2v
         +doypv+PPbaJGW2yXU+EaPjAWnWnd1ZXLhamE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WNSmz6gPUWl0psy6VYdrKZKj8jjeGLoBOEaYk7PTF5E=;
        b=HC2ZcC7cJMsrBtl9RzahuzNpqlIUZXTGeYP2G9JapzgXYmLWatwPbZnuolCiDMyNft
         O7JWusowEGfGTP11n9oJf2uz8ginTRV3GDqyFXwZUTo31cyYtNbQ/mRgmqhXG29vZ90Q
         GOaHcHCkyHrtTmThaJOktO9Rf5A8LGMBmnTisoHgIpMsEVIClIxb9njZHtlt/QfAyDeE
         Be2u+hxmpDeizDui3qIkIaA0apeJky4n+BBFuGQsOfea6b2hSbKJNcbpeSyarT9RdJap
         3NV32ejDmerYtAbNPwlFWQce0l8twwD5m2YWlKQ/UjWg16QKCwghZVjoAlx4cLyWgY0h
         bWRA==
X-Gm-Message-State: ABuFfojKTrIcDkcvDxeWfDkBDK/h03cUhCwUt8PU62FjmLKo5UDtBTvm
        SUhLlrcbPnDTPoivNMANv4C/Zg==
X-Google-Smtp-Source: ACcGV63YcGHLeWFH+zMcDfPGfwOAvPK81iWmstN1Bsc/dCjm29V/T1DgWrxlTjwp6QBDN3hA/VReOg==
X-Received: by 2002:a17:902:d20a:: with SMTP id t10-v6mr8118444ply.256.1539394543039;
        Fri, 12 Oct 2018 18:35:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 20-v6sm3688934pge.77.2018.10.12.18.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 18:35:41 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:35:40 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     David Miller <davem@davemloft.net>
Cc:     kirill@shutemov.name, linux-kernel@vger.kernel.org,
        kernel-team@android.com, minchan@kernel.org, pantin@google.com,
        hughd@google.com, lokeshgidra@google.com, dancol@google.com,
        mhocko@kernel.org, akpm@linux-foundation.org,
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
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com,
        nios2-dev@lists.rocketboards.org, peterz@infradead.org,
        richard@nod.at
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013013540.GA207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012.111836.1569129998592378186.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66808
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

On Fri, Oct 12, 2018 at 11:18:36AM -0700, David Miller wrote:
> From: Joel Fernandes <joel@joelfernandes.org>
[...]
> > Also, do we not flush the caches from any path when we munmap
> > address space?  We do call do_munmap on the old mapping from mremap
> > after moving to the new one.
> 
> Sparc makes sure that shared mapping have consistent colors.  Therefore
> all that's left are private mappings and those will be initialized by
> block stores to clear the page out or similar.
> 
> Also, when creating new mappings, we flush the D-cache when necessary
> in update_mmu_cache().
> 
> We also maintain a bit in the page struct to track when a page which
> was potentially written to on one cpu ends up mapped into another
> address space and flush as necessary.
> 
> The cache is write-through, which simplifies the preconditions we have
> to maintain.

Makes sense, thanks. For the moment I sent patches to enable this on arm64
and x86. We can enable it on sparc as well at a later time as it sounds it
could be a safe optimization to apply to that architecture as well.

thanks,

 - Joel
