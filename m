Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2012 09:43:30 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:56338 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903740Ab2CWInM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2012 09:43:12 +0100
Received: by werp11 with SMTP id p11so3022278wer.36
        for <multiple recipients>; Fri, 23 Mar 2012 01:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y9/YuVmbfW6KZQKV9opavUw4Z09nAKTjX1L1hhla8KU=;
        b=mcG60m9Hvx+1R/I9lhBkReSLEWOCi6SIIl0G1RIXy0ZwT1656Y3jr4ps60okvzGBI1
         uGUvpf9Gb9oJdeoU/V6g4GSUKAfmS1FFU9oVb4lLfdivmcYgU2l35AavJ+1k7r57iqXM
         yunJqeRM5HfTjrN6SaFgBMDg4Q2Jpn1L2Yvd+7pGQ4X60DN4n/QzObhrptZ3vXi0Mhbd
         p9CoTKNsjMnHyCTqinFt1zL6EtjRMcC5gWTSVI9mepHW5meEZfa4DzfFi0WT32M0bmFi
         uQXt5jtiwK7aGGt0o1yvSe2yjRhyaWFL0pM5e9og/wNut2pSy4pR2MeWuFrBRftV9tPZ
         xkzA==
Received: by 10.180.82.136 with SMTP id i8mr4395514wiy.19.1332492187290;
        Fri, 23 Mar 2012 01:43:07 -0700 (PDT)
Received: from gmail.com (54033750.catv.pool.telekom.hu. [84.3.55.80])
        by mx.google.com with ESMTPS id ff9sm12141362wib.2.2012.03.23.01.43.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Mar 2012 01:43:06 -0700 (PDT)
Date:   Fri, 23 Mar 2012 09:43:04 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] config: simplify INLINE_SPIN_UNLOCK
Message-ID: <20120323084304.GD2886@gmail.com>
References: <20120322095502.30866.75756.sendpatchset@codeblue>
 <4F6C170A.4070305@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F6C170A.4070305@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


* Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:

> On 03/22/2012 03:25 PM, Raghavendra K T wrote:
> >From: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> >
> >Patch simplifies current INLINE_SPIN_UNLOCK. compile tested on x86_64
> >
> >Change log:
> >get rid of INLINE_SPIN_UNLOCK entirely replacing it with UNINLINE_SPIN_UNLOCK
> >instead with the reverse meaning.
> >
> >whover wants to uninline the spinlocks (like spinlock debugging, paravirt etc
> >all just do select UNINLINE_SPIN_UNLOCK
> typo:
> Whoever wants to uninline the spinlocks (like spinlock debugging,
> paravirt etc) just do select UNINLINE_SPIN_UNLOCK.
> 
> >
> >Suggested-by: Linus Torvalds<torvalds@linux-foundation.org>
> >Signed-off-by: Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>
> >---
> >  Please refer : https://lkml.org/lkml/2012/3/21/357
> 
> Linus, Please let me know if this is what you were looking for or
> Did I really mess it up :(

Looks sane to me at first sight - will process it once the merge 
window calms down a bit.

Thanks,

	Ingo
