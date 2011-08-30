Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 13:52:34 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:56615 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491800Ab1H3Lw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 13:52:29 +0200
Received: by ewy3 with SMTP id 3so3210695ewy.36
        for <multiple recipients>; Tue, 30 Aug 2011 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=99yo5/NJfa6ErovIDmskEFwD5au20Hji+EehAKiz8dU=;
        b=T2yb087E6g8Z4TbLWoc/EEAmkMQceVaBYyo7XXR95IRUBN1vM4+H9Fhj9k7hioCW1J
         gNmJIp5oRngXXnrHAspnxc52KC5WoQO+J9fTXFMDoLOf600Ar8qc9rW2A/p010xSzOIV
         PDH8QXZYzJ01Bn1ZyAknRRKVPm+O8sBcjDDJA=
Received: by 10.213.14.71 with SMTP id f7mr2412340eba.18.1314705142412;
        Tue, 30 Aug 2011 04:52:22 -0700 (PDT)
Received: from localhost ([195.60.68.148])
        by mx.google.com with ESMTPS id o16sm3544075eef.40.2011.08.30.04.52.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Aug 2011 04:52:21 -0700 (PDT)
Date:   Tue, 30 Aug 2011 13:16:03 +0200
From:   "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110830111603.GB14243@edde.se.axis.com>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
 <4E5C26D4.3000906@paralogos.com>
 <4E5C2B62.9040007@cavium.com>
 <4E5C3060.70302@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E5C3060.70302@paralogos.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31015
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edgar.iglesias@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22347

On Mon, Aug 29, 2011 at 05:35:44PM -0700, Kevin D. Kissell wrote:
> On 08/29/11 17:14, David Daney wrote:
> > On 08/29/2011 04:55 PM, Kevin D. Kissell wrote:
> >> I submitted that exact patch (David's more minimal version) in December
> >> 2010 (and I did test it).  Did it not take?
> >
> > Evidently not.  Perhaps Ralf will see fit to commit it this time.
> 
> Looking back over the exchange and thinking about the date,
> in all fairness to Ralf, when I submitted it, it was a diff -u and
> not a git diff, because I was at my brother-in-law's house for
> the holidays and had no access to my MIPS Linux git machine.
> It got picked up by patchwork.linux-mips.org ( patch/1896 ),
> but was only actually tested by Anoop a couple of days
> later.  He confirmed that it solved the problem, but also that
> there were other problems with SMTC in the then-current
> head, apparently relating to timekeeping_notify().  Those
> problems weren't resolved in the context of that email thread,
> so the patch - something along the lines of which really and
> truly is necessary - may have been ignored as a partial fix,
> even though it is a self-contained solution to a self-contained bug.

Interesting. Coincidentally, after getting pass the CP0_Status issue, I ran
into some issues related to time-keeping, but I got the impression I was
seeing a mix of problems with QEMU and possibly the kernel. I never hunted
these issues down though. Maybe I'll give it a go some other time..

It makes me wonder, what is the state of SMTC kernels? Are they widely
used and considered stable?
Or is the SMP mode (1 TC per VPE) the common choice?

Cheers
