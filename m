Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2018 13:37:01 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:41032
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992066AbeJLLg5VcIsT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Oct 2018 13:36:57 +0200
Received: by mail-pg1-x544.google.com with SMTP id 23-v6so5728170pgc.8
        for <linux-mips@linux-mips.org>; Fri, 12 Oct 2018 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RUBKeYPll4jMLSN3Gb+udTJXKfzopX9w+dug7aYTr/k=;
        b=sLllf+hmYeVdtEKLgpvUk4uo/R65gqQ2L7zDPqofo15O4TD2lqqZ48BnJii3zNLrzj
         NyrHzrmlo5M8BFAgDiAnDSzFkH/4pCMx41PDkn9KakXzyWFHzbatjJl7tG6M3QlRWbCb
         PxniswSJvBlL+/pLj7KZtuZCCp2I33/xGPiDrmpqGjXDRkvRlkWGmyBycB9Rzb7E6Zs2
         L7OGkByZKFBctGsWJmvbk2lLkFhYwnI954eYYA9mDD2xDlJKx5AIfd14wPbV5Zu/imuW
         2GvR+0yYrS49d3VwMQPPTufF89rOzatfQb3FsyMC/zTNqHmMQ6U+r5c6uWOkB0vCTRFN
         mXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUBKeYPll4jMLSN3Gb+udTJXKfzopX9w+dug7aYTr/k=;
        b=fva9IkWpM3AHtMH3tiMpG2/PjdzCec67stPvLmtWFaysJuO7nyWIwAezSlQxqStxGp
         XnL9Y/DpbC4oUtheu4gyrlcGv6/X5iYEQhixzxMfexuunZIRqiruyexskbrIq9ldvfT+
         jtFpTCoWfNvDSXvzhyGHj+iX/Md4rDPleT6FPpTfCdkxqnRV4znv2b4JSI5QxDvywL4l
         6ife5Gp3T/KJF1JcYR4dgxswd5sE3oCPYDekiEa1yMli4DRLr1OiyoD0cBfeL5/ewRXa
         2pVtwZh6WOQJe7jIAm+TJD85soqrK6csycJ4Fi/88QpA0d0TKjl6dOUjjTQhVebpvLxm
         B8Yw==
X-Gm-Message-State: ABuFfojtkyziQiR/5edv8KwjUDj4esA+v76orkGwqvIBXPRNMcnXnIge
        uwGYpxlvhsQtO4F24Qy+Ewsahw==
X-Google-Smtp-Source: ACcGV60LchXUm+4bueEbZ+6bNEGISqX12eR/mS25M3eC4m93W+yAf1Gp0Al5g3J7F1KCwHaUiWlf2A==
X-Received: by 2002:a63:2a11:: with SMTP id q17-v6mr5201085pgq.374.1539344210379;
        Fri, 12 Oct 2018 04:36:50 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id o2-v6sm3561853pgi.62.2018.10.12.04.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:36:49 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 60154300030; Fri, 12 Oct 2018 14:36:45 +0300 (+03)
Date:   Fri, 12 Oct 2018 14:36:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        minchan@kernel.org, pantin@google.com, hughd@google.com,
        lokeshgidra@google.com, dancol@google.com, mhocko@kernel.org,
        akpm@linux-foundation.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        elfring@users.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jeff Dike <jdike@addtoit.com>, Jonas Bonn <jonas@southpole.se>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
        Ley Foon Tan <lftan@altera.com>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, Max Filippov <jcmvbkbc@gmail.com>,
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
Message-ID: <20181012113644.meqy5yb3xrxyh6lh@kshutemo-mobl1>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012113056.gxhcbrqyu7k7xnyv@kshutemo-mobl1>
User-Agent: NeoMutt/20180716
Return-Path: <kirill@shutemov.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66768
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

On Fri, Oct 12, 2018 at 02:30:56PM +0300, Kirill A. Shutemov wrote:
> On Thu, Oct 11, 2018 at 06:37:56PM -0700, Joel Fernandes (Google) wrote:
> > @@ -239,7 +287,21 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >  			split_huge_pmd(vma, old_pmd, old_addr);
> >  			if (pmd_trans_unstable(old_pmd))
> >  				continue;
> > +		} else if (extent == PMD_SIZE) {
> 
> Hm. What guarantees that new_addr is PMD_SIZE-aligned?
> It's not obvious to me.

Ignore this :)

-- 
 Kirill A. Shutemov
