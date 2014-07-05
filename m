Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 02:31:06 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:39714 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854767AbaGEAbCP3n-3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 02:31:02 +0200
Received: by mail-la0-f51.google.com with SMTP id mc6so1519853lab.10
        for <multiple recipients>; Fri, 04 Jul 2014 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vnIiRcxpqlM0HAQVttpQc6PwOeso+JkN5AKp4rBnc1k=;
        b=iy8MfSQiOjdmsXYSH+6QGUAmhukWwm24nwwJExwRAh+Ae/2VWjks98zQPNFOw8+rXZ
         Xq4m21ITl7r3a/0Jtv8yJiTlWHJGTvdTcSLINU9cnG3LnZlggXdiTos7s3DelWtFsuwE
         uY9uQcyZHVYdeI7PVG9wHTGYWtLVeQ0LjV4r8P8kCkwyfskdg5rafK/474tw7s76+JvI
         TD9weDtPQIQxhYL+qgUj7dMlEdmyyKLcKg0/SpmcTwwa4ccC6EkXDcUVHgs/47CPIVmD
         JiTpjVfg/XjMCiP0Wkg7LFoywelussf9pwzFwb3hlpsXMXrGAFDQuWbgAIvrGX+ZphiM
         RrEQ==
X-Received: by 10.152.4.73 with SMTP id i9mr4991602lai.50.1404520256716;
        Fri, 04 Jul 2014 17:30:56 -0700 (PDT)
Received: from lianli (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id i10sm15571522laa.46.2014.07.04.17.30.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 17:30:56 -0700 (PDT)
Date:   Sat, 5 Jul 2014 02:30:53 +0200
From:   Emil Goode <emilgoode@gmail.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix incorrect NULL check in local_flush_tlb_page()
Message-ID: <20140705003053.GB3404@lianli>
References: <1404493623-22705-1-git-send-email-emilgoode@gmail.com>
 <CAOiHx==mR0eioTk=tc457z4ANbhFR2vS2A2y3wzw119jnCi2Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==mR0eioTk=tc457z4ANbhFR2vS2A2y3wzw119jnCi2Pw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emilgoode@gmail.com
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

Hello Jonas,

On Fri, Jul 04, 2014 at 11:52:51PM +0200, Jonas Gorski wrote:
> On Fri, Jul 4, 2014 at 7:07 PM, Emil Goode <emilgoode@gmail.com> wrote:
> > We check that the struct vm_area_struct pointer vma is NULL and
> > then dereference it. The intent must have been to check that
> > vma is not NULL before we dereference it in the next condition.
> 
> Actually if it is NULL, then it will short-cut and won't dereference
> it (because !vma is true it can never become false again), so the
> condition would be fine previously.
> 
> But, looking at the code a few lines into branch:
> 
>         if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
>                 unsigned long flags;
>                 int oldpid, newpid, idx;
> 
> #ifdef DEBUG_TLB
>                 printk("[tlbpage<%lu,0x%08lx>]", cpu_context(cpu,
> vma->vm_mm), page);
> #endif
>                 newpid = cpu_context(cpu, vma->vm_mm) & ASID_MASK;
> 
> it will be then dereferenced here, so the change is actually sensible,
> even if the description isn't quite spot-on where it breaks.

Sorry, this is what I meant but failed to explain clearly.

Perhaps the following is a bit better?

We check that the struct vm_area_struct pointer vma is NULL and then
dereference it a few lines below. The intent must have been to make sure
that vma is not NULL and then to check the value from cpu_context() for the
condition to be true.

Best regards,

Emil Goode
