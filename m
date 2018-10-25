Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2018 12:47:19 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:45957
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeJYKrPPA7xF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2018 12:47:15 +0200
Received: by mail-pl1-x643.google.com with SMTP id o19-v6so3649499pll.12
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2018 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1R3A0ycONFuPhko1Zvw9OxjeXH19x+s87tjU9oKwfSw=;
        b=uRVyPXCyFw/vFJ9ptle4zloJMrol+XisBixqDteIGc2z2oG/f4Q8NfKA0B2gilh+Rr
         i+HTajUVnTgL+59CrAsNpIQzGw2bYTsOBSPmi9WVqroK585WsKPK4zT2IIvv2C6f23dJ
         F9grKSKsJ1P0XFYJA4GEnLgn3qb5En9KpzOMyEtJi1cliFP4s9dMdLlWGK2lC/PN9h34
         PzeoJEkp3NKRxc1VVfXDgfbweJjDPzw7KTQ0g9tXmzEx6xT3/YOHh00cgteTAphadXLE
         270H2CcukCX0575S0EAUXv7rBR5pp/bl8ZyBNwBfTku8pgy4LLUWuBo4TdiLZcu1G2r6
         ZGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1R3A0ycONFuPhko1Zvw9OxjeXH19x+s87tjU9oKwfSw=;
        b=pLIDxo4kECa7G89XuaKF86bdtFByyufXB5n79r8iWmi9/NG0E+z6M2S8py8qRdKQL4
         Hlggw0YjqfbzcSMkoDLH27xq/VX+4++Ir3G+9kssOAJbEYNsAs6FLzw4c3DRGLRpCe6H
         k1Za4YbMdCtcsRf0efh+dEvwJUbgEufDW9yW6/NmTr9gDSyU5tqzuqXK9QAw80YNg6NF
         GKTXLJPoonkcP1OVbbMT1UFU82BR4LMXKjQxEQPzvL/xz9On/+74Yz8KLjXtRh6iYwgS
         u0O/oJeJDuduWJP6I8hX2jg+jyyQgqvzL1YGHryCEWc2T5flSq6ayJsYkWqqLXuJDael
         Vv4g==
X-Gm-Message-State: AGRZ1gJBZIKAo6jz/gdq6HYVG3t9OYx6KLuqwG49qu5ZsNHWkASB4vxe
        zyqo0jIXdQwbEsrYyyqGAYA3Hg==
X-Google-Smtp-Source: AJdET5fRlG7zn7SaYzZpRZ5UT8n9qs5ABGZ7gGjpA2WzJPxYDI1NTaxmusE6kiTKMEVKRP5rq9c/Gw==
X-Received: by 2002:a17:902:8c86:: with SMTP id t6-v6mr1023260plo.55.1540464428285;
        Thu, 25 Oct 2018 03:47:08 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id z22-v6sm8085935pgv.24.2018.10.25.03.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 03:47:07 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 722DF300225; Thu, 25 Oct 2018 13:47:03 +0300 (+03)
Date:   Thu, 25 Oct 2018 13:47:03 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Michal Hocko <mhocko@kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>, akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        anton.ivanov@kot-begemot.co.uk, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, dancol@google.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        hughd@google.com, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, lokeshgidra@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        nios2-dev@lists.rocketboards.org, pantin@google.com,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>, Sam Creasey <sammy@sammy.net>,
        sparclinux@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 1/4] treewide: remove unused address argument from
 pte_alloc functions (v2)
Message-ID: <20181025104703.esl6wxyg2ihe4zoc@kshutemo-mobl1>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-2-joel@joelfernandes.org>
 <20181024083716.GN3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024083716.GN3109@worktop.c.hoisthospitality.com>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kirill@shutemov.name
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

On Wed, Oct 24, 2018 at 10:37:16AM +0200, Peter Zijlstra wrote:
> On Fri, Oct 12, 2018 at 06:31:57PM -0700, Joel Fernandes (Google) wrote:
> > This series speeds up mremap(2) syscall by copying page tables at the
> > PMD level even for non-THP systems. There is concern that the extra
> > 'address' argument that mremap passes to pte_alloc may do something
> > subtle architecture related in the future that may make the scheme not
> > work.  Also we find that there is no point in passing the 'address' to
> > pte_alloc since its unused. So this patch therefore removes this
> > argument tree-wide resulting in a nice negative diff as well. Also
> > ensuring along the way that the enabled architectures do not do anything
> > funky with 'address' argument that goes unnoticed by the optimization.
> 
> Did you happen to look at the history of where that address argument
> came from? -- just being curious here. ISTR something vague about
> architectures having different paging structure for different memory
> ranges.

I see some archicetures (i.e. sparc and, I believe power) used the address
for coloring. It's not needed anymore. Page allocator and SL?B are good
enough now.

See 3c936465249f ("[SPARC64]: Kill pgtable quicklists and use SLAB.")

-- 
 Kirill A. Shutemov
