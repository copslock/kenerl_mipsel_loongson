Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 21:42:22 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:36191
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbeJLTmTZ496p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 21:42:19 +0200
Received: by mail-pf1-x443.google.com with SMTP id l81-v6so6696133pfg.3
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7HZNZsB1jLEFaholpalHaVYnkWxxqdQS2UbsT4fFuJY=;
        b=Z8gYJNm7ONxx3qybdg27wFRSoVULBn2tUUBtRitXwUvZz3AhLFXo+FQIkGmVSgFidC
         qSw7CPJOp1WJWKXTflv0xxIw2LNh5s0xIfzOfYgIhSxjNXxUmUyqLzzwB0ATx3kCdzlg
         oxaGTQ7SptXZTjdi/GmovUe6gMn7aR4yslCfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7HZNZsB1jLEFaholpalHaVYnkWxxqdQS2UbsT4fFuJY=;
        b=rGKRL6QTlKhvpRaKv+Y9l64ctFJhlf6hVo4WEtThqu4uv95RrUVMvsz8RULWb2qKi7
         zsx0bGdlUBWkM59gJPb88ufBbg8VNAROUXNp46A3YMlDVC85k5IWxI89D7b1CyCM/qI+
         T9Z0Kh3Ba9oKZf4LsYBwDDQ6/eD/cgjRMXcBCL1AkqpF9Kj7mTBpDZcWVIGekjbx02c+
         Jyh+zz//VyQrLUCiPLRVi8/26VTBXbGgfazEyJAk1F/1yKQKHk6zm8AWx7qggjWIuGHj
         KE7Kr5roYJEpwOZ3eELi3tFZQSocc/rHXrS2NTWgSMFWCZq8eoXwKuTJFbLSqh5cefu/
         r5Ew==
X-Gm-Message-State: ABuFfohPmiSYiQZ5GFKMXPGqiatD70TgvaRkR4qbNXGvYZ5YFXcyJrU7
        fQRfnIMXOEb5BFuwtXso6D17hQ==
X-Google-Smtp-Source: ACcGV62ghsr+2nsme8ztf1h/ejIwFwjRsZeeKiC6kJsMYRGK5dHID+ZMDEAPamf9Lz3JQcU3Yz/xdw==
X-Received: by 2002:a63:f922:: with SMTP id h34-v6mr6748971pgi.154.1539373332263;
        Fri, 12 Oct 2018 12:42:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id k70-v6sm3054384pfc.76.2018.10.12.12.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:42:11 -0700 (PDT)
Date:   Fri, 12 Oct 2018 12:42:10 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     SF Markus Elfring <elfring@users.sourceforge.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "James E. J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        pantin@google.com, Lokesh Gidra <lokeshgidra@google.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012194210.GA27630@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03b524f3-5f3a-baa0-2254-9c588103d2d6@users.sourceforge.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66792
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

On Fri, Oct 12, 2018 at 08:51:45PM +0200, SF Markus Elfring wrote:
> > The changes were obtained by applying the following Coccinelle script.
> 
> A bit of clarification happened for its implementation details.
> https://systeme.lip6.fr/pipermail/cocci/2018-October/005374.html
> 
> I have taken also another look at the following SmPL code.
> 
> 
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> 
> I suggest to adjust the regular expression for this constraint
> and in subsequent SmPL rules.
> "^(?:pte_alloc(?:_one(?:_kernel)?)?|__pte_alloc(?:_kernel)?)$";

Sure it looks more clever, but why? Ugh that's harder to read and confusing.

> > (
> > - T3 fn(T1 E1, T2 E2);
> > + T3 fn(T1 E1);
> > |
> > - T3 fn(T1 E1, T2 E2, T4 E4);
> > + T3 fn(T1 E1, T2 E2);
> > )
> 
> I propose to take an other SmPL disjunction into account here.
> 
>  T3 fn(T1 E1,
> (
> -      T2 E2
> |      T2 E2,
> -      T4 E4
> )      );

Again this is confusing. It makes one think that maybe the second argument
can also be removed and requires careful observation that the ");" follows.

> > (
> > - #define fn(a, b, c)@p e
> > + #define fn(a, b) e
> > |
> > - #define fn(a, b)@p e
> > + #define fn(a) e
> > )
> 
> How do you think about to omit the metavariable “position p” here?

Right, I don't need it in this case. But the script works either way.

I like to take more of a problem solving approach that makes sense, than
aiming for perfection, after all this is a useful script that we do not
need to check in once we finish with it.

 - Joel
