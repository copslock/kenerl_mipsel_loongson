Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 18:02:12 +0100 (CET)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:45903
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991065AbeJaRBkz5h0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 18:01:40 +0100
Received: by mail-wr1-x443.google.com with SMTP id n5-v6so17277208wrw.12
        for <linux-mips@linux-mips.org>; Wed, 31 Oct 2018 10:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
        b=LcTmkgLaTJl5aqBKxMqvydqj6P3/DffuXvVPbAUygeibeDLzwTIQqXfR4uds2rIZYM
         XhmMGb7KngDWan146d22FCM9UQ9Ko/QDf54C0Fdt16LXoigKyLTLkNkKnhAaTuALlKv5
         25xBM+L683GMsxPWlmbZaDfh6fxO/3dRfQFIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7PRsslQ+AmlGw6ESJEAEIN3Ju+lMTMOAAXzG79p0Hk=;
        b=L1NbNI6Nsz7MZA91/mkOMnQaHazraKXDVbqJqdbACTmgeXlu+2v07Xqq2/P2d37kH8
         T3+QJFPuKlz0Q0YRb9vg/ERK7C/ZtSMeO6OQOyqwjOH+tniC/k3wGttop4ub+ZVcCOfZ
         zlYhuGjuvThp1gtkrhrVNUar8ZKfz7BeiIHoFQ8FRscKVulGiNJfltpdsxEqNaMgAhy7
         AptCcTUMka7guOrkHlshSbTcFBTAXaI4s+Bfvlg+LuHYxZoYWabfgsLkg6Q37LunIlOs
         2N17AD9+1XenPotCbn+evA3UFOT60j4+uzr53Y/uOQ9pHaAWlseS4kUEwqf5zL81OT9J
         nmCg==
X-Gm-Message-State: AGRZ1gJ5C4hrXbqvp/bVhmyw/1FmM7YSD41VurkwOOfiBTSGJrcv0b+y
        On2SJA/sxzpHVPdqmV+DOUNmJw==
X-Google-Smtp-Source: AJdET5fF9/fl4K36p+e42OouXFrTlfI2G2yyDuiZgaKxA4I7kOc22/Zb6DjVFjwUnDDuT1saAKtLCQ==
X-Received: by 2002:adf:aa05:: with SMTP id p5-v6mr3828856wrd.56.1541005300354;
        Wed, 31 Oct 2018 10:01:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id t77-v6sm39633264wme.18.2018.10.31.10.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:01:39 -0700 (PDT)
Date:   Wed, 31 Oct 2018 17:01:36 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Rich Felker <dalias@libc.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031170136.s3ids6tm4rxxlpma@holly.lan>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031134926.GB13237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Return-Path: <daniel.thompson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.thompson@linaro.org
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

On Wed, Oct 31, 2018 at 02:49:26PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > Looking closely at it, it seems like a really bad idea to be calling
> > local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> > like it could violate spinlock semantics and cause a deadlock.
> > 
> > Instead, let's use a private csd alongside
> > smp_call_function_single_async() to round up the other CPUs.  Using
> > smp_call_function_single_async() doesn't require interrupts to be
> > enabled so we can remove the offending bit of code.
> 
> You might want to mention that the only reason this isn't a deadlock
> itself is because there is a timeout on waiting for the slaves to
> check-in.

dbg_master_lock must be owned to call kgdb_roundup_cpus() so
the calls to smp_call_function_single_async() should never deadlock the
calling CPU unless there has been a previous failure to round up (e.g.
cores that cannot react to the round up signal).

When there is a failure to round up when we resume, there is a window (before
whatever locks that prevented the IPI being serviced are released) during which
the system will deadlock if the debugger is re entered.

I don't think there is any point trying to round up a CPU that did not
previously respond... it should still have an IPI pending. The deadlock
can be eliminated by getting the round up code to avoid CPUs whose csd->flags
are non-zero either by checking the flag in the kgdb code or adding something
like smp_trycall_function_single_async().


Daniel.
