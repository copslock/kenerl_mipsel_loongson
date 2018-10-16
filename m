Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 21:43:26 +0200 (CEST)
Received: from mail-pl1-x644.google.com ([IPv6:2607:f8b0:4864:20::644]:35297
        "EHLO mail-pl1-x644.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992960AbeJPTnXbQzB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 21:43:23 +0200
Received: by mail-pl1-x644.google.com with SMTP id f8-v6so11515105plb.2
        for <linux-mips@linux-mips.org>; Tue, 16 Oct 2018 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4E6/TYIJnb1hpwFXfznXrU9WRJfBcYMDYHXRqDEZgOg=;
        b=V9PgMDNF7CBl5+Nzjvr0iSOtDiDCQgsN/s5ihAy9noZqWII6hYc6Ts6C5GhDKx8GXO
         m7lTUaprGsEeUyTBUKqmHo3irjZ1l34Zh9xqtEP2vVvNhHYNULvRTyjfiwn/iz3OaXl0
         6o0VR9etFqC0VPLMHRowVmTVSwuMOe0dtplzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4E6/TYIJnb1hpwFXfznXrU9WRJfBcYMDYHXRqDEZgOg=;
        b=mnSOWlucfbEgIR2VjcMTPdf3aLTLdC3GTeQXCJCzcXG0R+uGx+95CiJSms1+31sfyJ
         srui8I+Ed3TiRGxgMffDa+SessVWJLK9n34PdcG7C9NSqGx1L5ynDDt4v7b/RkAZFhal
         K08/4zqZr58xStmCMYTLqXmqjQHojXpIIQDnD20NDL+JQAKTPHWNQI8iUBg98sH/PIhA
         6YK0Jf252lQ9oo+ZFJXmpRq/65qhPc+UUy7h53uztrPB3O4Kg0CwqUUjNutgY7eP1QZl
         w0igVVu/4qrIulDc/hb5hkxl2PjfWO5uD8fQ/jH/xMkLWvm8qd6UMw2TkaCTCHDtonGn
         3v2g==
X-Gm-Message-State: ABuFfogw1KB/TQfh24Mu82hgw1nF09qh2KJ6C3qfbS8MkdOumowViXju
        8zI3WALj8p04EXnJcN/7y7Q2Ug==
X-Google-Smtp-Source: ACcGV62AdBcFxDIb9TDt/mmUnedT1xOttrv1cSqMsBN5bCJGRH95gVqQWD3vO6sNA2FVCR0J+aMC2w==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr22725955pla.132.1539718996443;
        Tue, 16 Oct 2018 12:43:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id s2-v6sm15420002pgo.90.2018.10.16.12.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 12:43:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:43:13 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>, mhocko@kernel.org,
        linux-mm@kvack.org, lokeshgidra@google.com,
        linux-riscv@lists.infradead.org, elfring@users.sourceforge.net,
        Jonas Bonn <jonas@southpole.se>, kvmarm@lists.cs.columbia.edu,
        dancol@google.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
        kasan-dev@googlegroups.com, anton.ivanov@kot-begemot.co.uk,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-snps-arc@lists.infradead.org, kernel-team@android.com,
        Sam Creasey <sammy@sammy.net>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-s390@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-m68k@lists.linux-m68k.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        nios2-dev@lists.rocketboards.org, kirill@shutemov.name,
        Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>,
        Richard Weinberger <richard@nod.at>,
        linux-parisc@vger.kernel.org, pantin@google.com,
        Max Filippov <jcmvbkbc@gmail.com>, minchan@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/4] mm: speed up mremap by 500x on large regions (v2)
Message-ID: <20181016194313.GA247930@joelaf.mtv.corp.google.com>
References: <20181013013200.206928-1-joel@joelfernandes.org>
 <20181013013200.206928-3-joel@joelfernandes.org>
 <20181015094209.GA31999@infradead.org>
 <20181015223303.GA164293@joelaf.mtv.corp.google.com>
 <35b9c85a-b366-9ca3-5647-c2568c811961@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b9c85a-b366-9ca3-5647-c2568c811961@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <joel@joelfernandes.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66879
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

On Tue, Oct 16, 2018 at 01:29:52PM +0200, Vlastimil Babka wrote:
> On 10/16/18 12:33 AM, Joel Fernandes wrote:
> > On Mon, Oct 15, 2018 at 02:42:09AM -0700, Christoph Hellwig wrote:
> >> On Fri, Oct 12, 2018 at 06:31:58PM -0700, Joel Fernandes (Google) wrote:
> >>> Android needs to mremap large regions of memory during memory management
> >>> related operations.
> >>
> >> Just curious: why?
> > 
> > In Android we have a requirement of moving a large (up to a GB now, but may
> > grow bigger in future) memory range from one location to another.
> 
> I think Christoph's "why?" was about the requirement, not why it hurts
> applications. I admit I'm now also curious :)

This issue was discovered when we wanted to be able to move the physical
pages of a memory range to another location quickly so that, after the
application threads are resumed, UFFDIO_REGISTER_MODE_MISSING userfaultfd
faults can be received on the original memory range. The actual operations
performed on the memory range are beyond the scope of this discussion. The
user threads continue to refer to the old address which will now fault. The
reason we want retain the old memory range and receives faults there is to
avoid the need to fix the addresses all over the address space of the threads
after we finish with performing operations on them in the fault handlers, so
we mremap it and receive faults at the old addresses.

Does that answer your question?

thanks,

- Joel
