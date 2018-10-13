Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Oct 2018 03:44:44 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:35597
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993973AbeJMBoilnvCy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Oct 2018 03:44:38 +0200
Received: by mail-pg1-x542.google.com with SMTP id v133-v6so6616693pgb.2
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOwbPFoajGZi3/uQe5h542M6UYdoOEkmWBYBoXp9OV8=;
        b=TX0jPv1mV+ruD3G3qgqRA9UMXe+0i0YS6UXGUy6KTVLywoPyxQGhhjXFi4dn2iQI3x
         x/BukZ3beT2AFdW61n55JqI5ANyPOWfr1rNKfv8VAcertpXgkQEbv+tQZOTO68qVwDHs
         51gxQI0b3N3xdtlX+SiDVTyY2dpjIIcZ8JErQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOwbPFoajGZi3/uQe5h542M6UYdoOEkmWBYBoXp9OV8=;
        b=PBjT8iMIc0pslLpYxbDRxcXYSWNUqFqs/dCnPKfA+2VSqIRs67I6sSdavwaBeiv8PN
         awMAqvpacR968kwlz8PtS1R6RCoh7nFhymh3eXp/UhDGDkYlsciue+XxIZrVIUyLWOtj
         3KTHSNjP9QcOHlKAKYpbxXmmrC1W4Opnuco3ciei9h4+aYyK0AiqYPU/h5k17lZRQuLX
         r0IzkDwh8ryPYteaOLXKTnc2yG2v+iIdeQdSD7NaXLtROUIxAIpLIoTJQLzbysXjewZB
         elv+prNxnnuDyZEDzmPgQGlZ45+lE61ZwacT5NMn/fFb91GLKHYnF5KPD1dEhknSUKyP
         d9lg==
X-Gm-Message-State: ABuFfohSTovMjiATGCoAG5ImR58fAf9N4EcNY5Kqb2so+NVRNYODiRi/
        oB5gJi75FvIl0sxhBZs3lmidBA==
X-Google-Smtp-Source: ACcGV63XxXW9pGHxVnF8xzzLyeXhR7XaYBjfw87dDDQ+CF+OqnNRmShTWlj1H1kUQbwXg/j2G4ghiQ==
X-Received: by 2002:a62:968a:: with SMTP id s10-v6mr8356398pfk.191.1539395071806;
        Fri, 12 Oct 2018 18:44:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id r81-v6sm6155322pfa.110.2018.10.12.18.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 18:44:30 -0700 (PDT)
Date:   Fri, 12 Oct 2018 18:44:29 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181013014429.GB207108@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
 <20181012125046.GA170912@joelaf.mtv.corp.google.com>
 <20181012.111836.1569129998592378186.davem@davemloft.net>
 <20181013013540.GA207108@joelaf.mtv.corp.google.com>
 <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueuNvWvn18vffJWpbpg7h-uScT8gXrrudTB2pnT4M2HJ_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66810
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

On Fri, Oct 12, 2018 at 06:39:45PM -0700, Daniel Colascione wrote:
> Not 32-bit ARM?

Well, I didn't want to enable every possible architecture we could in a
single go. Certainly arm32 can be a follow on enablement as can be other
architectures. The point of this series is to upstream this feature and
enable a hand-picked few architectures as a first step.

thanks,

 - Joel
