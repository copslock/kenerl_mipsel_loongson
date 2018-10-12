Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 18:46:56 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:34070
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLQqxttBxf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 18:46:53 +0200
Received: by mail-pf1-x443.google.com with SMTP id f78-v6so712505pfe.1
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Umti8berIQqjm65Zoyf/w3JloUMrJhwZUXe+Y2BsWdc=;
        b=KQEzQQFkI6jyKow9cNxsGELIJZyLx1I8uGjB/QnyLtJkOtbntdWVJwS8u0cqFmWoK2
         Zbax90aSm2shdb707DdFjVreJBouZPwsGgrwGCldaGV6mLKNDvduyzCfqgYYC5kplbyd
         Z9GrlBVjP7KcXBEbZpZjy43C4pR8q7gp8Lu8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Umti8berIQqjm65Zoyf/w3JloUMrJhwZUXe+Y2BsWdc=;
        b=ZYzAceHq41Oc5h+wENnOodr81ufBIdxpOlgM1DsKTFArSlPqiXzvAS2jNHFey9Ods2
         U0f+r7hxnQtvOjGwNufJXBDeFVedXz7hG5b5XHFj6r37lrSIfFuc01anMkUdEanKkByW
         3G0C829IwYo6Q93UBDxMCorOGxLee5teq7NjKKQ8HH0Y7R7RKNjr9R4eln6/B4lWuzTC
         gOBroJDUmUQzX6+P1o1NF6BZ1cTf/cfMFlo2w6Yy9XFOISMRZ1HN4sle8zfz6IEoq86K
         w9OzXYZwpENTmlPk+e3+i+RjAMIJyqGEd6XxHfq/XcGV48mc3PqFOc5dkyNtnkZcV4Yn
         8JOg==
X-Gm-Message-State: ABuFfohU6A5o8YijK95MLtkpzK4H2wFJu7F3yfUHPds8caIK0I4+Qoub
        mZ6RaMxdhClyPNdBGJ8voTLqXQ==
X-Google-Smtp-Source: ACcGV609gsys33zC1Yow1z87yTnxpouPc78UFZGuqi9n2/9mNvSopecla0EDsZWt+bvQnXlM2xKVdQ==
X-Received: by 2002:a63:991a:: with SMTP id d26-v6mr6276510pge.434.1539362807192;
        Fri, 12 Oct 2018 09:46:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g62-v6sm3310692pgc.22.2018.10.12.09.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:46:45 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:46:44 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        lokeshgidra@google.com, linux-riscv@lists.infradead.org,
        elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
        linux-s390@vger.kernel.org, dancol@google.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-m68k@vger.kernel.org, openrisc@lists.librecores.org,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012164644.GC223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <594fc952-5e87-3162-b2f9-963479d16eb3@kot-begemot.co.uk>
 <20181012163433.GA223066@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.20.1810121838180.4366@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1810121838180.4366@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66781
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

On Fri, Oct 12, 2018 at 06:38:57PM +0200, Julia Lawall wrote:
> > I wrote something like this as below but it failed to compile, Julia any
> > suggestions on how to express this?
> >
> > @pte_alloc_func_proto depends on patch exists@
> > type T1, T2, T3, T4;
> > identifier fn =~
> > "^(__pte_alloc|pte_alloc_one|pte_alloc|__pte_alloc_kernel|pte_alloc_one_kernel)$";
> > @@
> >
> > (
> > - T3 fn(T1, T2);
> > + T3 fn(T1);
> > |
> > - T3 fn(T1, T2, T4);
> > + T3 fn(T1, T2);
> > )
> 
> What goes wrong?  It seems fine to me.

Weird it seems working now. I could swear 5 minutes ago it wasn't and I did
give a unique rule name. Don't know what I missed.

Anyway, thank you for all the quick responses and the help!

- Joel
