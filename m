Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 18:37:37 +0200 (CEST)
Received: from mail-pl1-x642.google.com ([IPv6:2607:f8b0:4864:20::642]:39898
        "EHLO mail-pl1-x642.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLQheszvqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 18:37:34 +0200
Received: by mail-pl1-x642.google.com with SMTP id w14-v6so6176101plp.6
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VgdWRAThwj2EMLbo8sWAHSsutcajwriCEy/dGs8kimQ=;
        b=Yx6iiDOE4GgwJ3wrxDhjF1xivdsbBDEqc8xx5jdpyDJvE+qpLgMgy/KhjSsAuHRJyU
         rjgnlYO7tlrGv1G+TaKr5XDehCpd8eZLTAEwubNcKxLRAX6QLsDFm2lImHS78o7KxLhe
         EhZiy+H+FVvSEtNaG63pU9KzeTWvu1FrWLelY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VgdWRAThwj2EMLbo8sWAHSsutcajwriCEy/dGs8kimQ=;
        b=bk7FqesFCYp53c7zJ4kuDEUL+xiplL+eKRF8d4r55hcuHEj8zDe6Kmd5by6KvIZll5
         KUBMV8QCGGDgEo5lU6IUH4yFPl1PbwSdKlmJOPMFS6wN8+1fjAd6V0r6sE19h+uEQU4v
         pi7Z+jhsOUZXQ/Svg4dVmhATXqJs65BV6HS5GRLQQlB/84qs/I5IoKQA+Wstq7Bh2Vxw
         0zatvFKGHnSMWjEtgWxCkpaTJsCxRfaBTXqeTJD8sv0rQrNcSliXuVRhJZHyBYzxnXvy
         6+fdC8Lj1TF83mtgxNIskGRJnFgrI5+YriyBxoCJUeea/IcJO4XgbRSKjrWho9fHzusY
         fk3w==
X-Gm-Message-State: ABuFfojZw+pUWXU5z+wmQftcsxOwasfw/tqGCKphJfsJhaCulllH8ySj
        7sON89Ml0ff4PNKdI8NlmAl0DQ==
X-Google-Smtp-Source: ACcGV62jUKQ08v22v3vIhXoVq3Rc/sYsS1RW7mhnmQmf8WDFV0RfxpB6QhVx3k79ViRK/oHHNtygsQ==
X-Received: by 2002:a17:902:8205:: with SMTP id x5-v6mr6704330pln.55.1539362247706;
        Fri, 12 Oct 2018 09:37:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id k77-v6sm5032857pfg.1.2018.10.12.09.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 09:37:26 -0700 (PDT)
Date:   Fri, 12 Oct 2018 09:37:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        elfring@users.sourceforge.net,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
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
        linux-xtensa@linux-xtensa.org, pantin@google.com,
        lokeshgidra@google.com, Max Filippov <jcmvbkbc@gmail.com>,
        minchan@kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
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
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 1/2] treewide: remove unused address argument from
 pte_alloc functions
Message-ID: <20181012163725.GB223066@joelaf.mtv.corp.google.com>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012110906.fpfttp4nhvsr2ps7@kshutemo-mobl1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66778
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

On Fri, Oct 12, 2018 at 02:09:06PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:55PM -0700, Joel Fernandes (Google) wrote:
> > diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
> > index 12fe700632f4..4399d712f6db 100644
> > --- a/arch/m68k/include/asm/mcf_pgalloc.h
> > +++ b/arch/m68k/include/asm/mcf_pgalloc.h
> > @@ -12,8 +12,7 @@ extern inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> >  
> >  extern const char bad_pmd_string[];
> >  
> > -extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
> > -	unsigned long address)
> > +extern inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >  {
> >  	unsigned long page = __get_free_page(GFP_DMA);
> >  
> > @@ -32,8 +31,6 @@ extern inline pmd_t *pmd_alloc_kernel(pgd_t *pgd, unsigned long address)
> >  #define pmd_alloc_one_fast(mm, address) ({ BUG(); ((pmd_t *)1); })
> >  #define pmd_alloc_one(mm, address)      ({ BUG(); ((pmd_t *)2); })
> >  
> > -#define pte_alloc_one_fast(mm, addr) pte_alloc_one(mm, addr)
> > -
> 
> I believe this was one done manually, right?
> Please explicitely state everthing you did on not of sematic patch

Ok, I can update the changelog with that information next time I send it.
This is the only thing I didn't mention in the changelog since it was a
trivial unused function deletion.. but I mentioned everything else..

And sir, you are one thorough reviewer! ;-)

 - Joel

[..]
