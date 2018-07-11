Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 10:27:03 +0200 (CEST)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:40656
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993634AbeGKI0yiWms4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 10:26:54 +0200
Received: by mail-lf0-x242.google.com with SMTP id y200-v6so20574819lfd.7;
        Wed, 11 Jul 2018 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jQ1VliKAS89519IiVVIeZY/w/9fWgZ3b4QnIXWmxZIQ=;
        b=PJVvrpR+Pu7iXlzP7TJjHZXT+Nob1u4nJNtP8hw+kiHzWj8j95Vk2kjuHEsP2ieeAA
         5DUAAsenSOehe15WMvmGc16aIlRCLznS48skbz3vk/pSCKJFfA2q8XITAiOjzMb2yPFj
         eeULzO9Q1i9n1NM7uDBji+xuboSKYlJq+Dc5M5PjwrT66d8XPs9NyjtwGsSizw+qa/ku
         T55jH9fhdbiR1C//3ccRZjoyhLM7h5CgXDYKddP40497GHJ0dmKXkSjyByZCCBu3z9wr
         i4NGIN5nxNCkbp5rxYOrNFF+oOKPac9bu2whBKcvHUsyAV2kIXan/MfsRq4J9oavzlsy
         YNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jQ1VliKAS89519IiVVIeZY/w/9fWgZ3b4QnIXWmxZIQ=;
        b=f4YlKejdLxL/5h/VFD0uBxmdE+1O1zwy8U54JXExwuDsxXJUQfwSFMRzvINv8Vuo4u
         In6ECG6q3CB6sOHHVYcq2D4Pzy77pWqyVBUSVIsAjse70WlXR5TwYJwmIhx0V29xGNcc
         wOAKRdJiWt2OSt5EJ62DiDrc5PIN5DZsWU7FGpX8A5DcsYzgFxThzBWMkL3ykAuyxbtd
         hsRRs2wyQGHr/pVSEjBib319X7BKK8GI6j5vT8FIRHVV7P1tTTUvi8UPtFuaOMR/2ALJ
         RV5wOY/5aBWhgrHWtnMWFpPpgCXyCOrlhXHSa21CmbILf9sZ6oP2g47Rd/XRf9GDQf8c
         tYcA==
X-Gm-Message-State: APt69E2bm1qvBUyqF5VvycCAryE3sqDZ9hC8/ErM3fMzzr+vVH5a23XU
        RHi1N+FAdEzgwnXdHZxCOxw=
X-Google-Smtp-Source: AAOMgpcMAX50HmuI+45mNxJXS/SiTKZkBFqhlKycOiZXJfIbiK4vPIqG6Js2V+GTHT6aQYBRPDkM+A==
X-Received: by 2002:a19:921a:: with SMTP id u26-v6mr5340489lfd.89.1531297609048;
        Wed, 11 Jul 2018 01:26:49 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g17-v6sm3008495ljg.27.2018.07.11.01.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 01:26:47 -0700 (PDT)
Date:   Wed, 11 Jul 2018 11:27:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180711082736.GA9387@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
 <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
 <20180710191354.GA32182@mobilestation>
 <20180710210415.4uqstovovdfvxfup@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710210415.4uqstovovdfvxfup@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Paul,

On Tue, Jul 10, 2018 at 02:04:15PM -0700, Paul Burton <paul.burton@mips.com> wrote:
> Hi Serge,
> 
> On Tue, Jul 10, 2018 at 10:13:54PM +0300, Serge Semin wrote:
> > On Tue, Jul 10, 2018 at 10:59:40AM -0700, Paul Burton <paul.burton@mips.com> wrote:
> > > However FYI for next time - you shouldn't really add someone else's
> > > Signed-off-by tag anyway. The tag effectively states that a person can
> > > agree to the Developer's Certificate of Origin for this patch (see
> > > Documentation/process/submitting-patches.rst), and you can't agree that
> > > on behalf of someone else. Generally a maintainer should add this tag
> > > for themselves when they apply a patch.
> > 
> > I'm sorry if it seemed like I added Signed-off on your behalf.
> 
> That's OK, I didn't think you did it maliciously :)
> 
> > I thought the Signed-off also concerns the ones, who participated in
> > the patch preparation. Since you suggested the design of the change,
> > I've decided to put your name in the Signed-off tag. What shall I use
> > in this way then?
> 
> In this case Suggested-by might have been a good choice. Reported-by is
> also commonly used if someone reported a problem which you created a fix
> for.
> 
> Section 13 of Documentation/process/submitting-patches.rst describes
> these tags along with a couple others.

I always thought of these tags as something more like a formality. In fact
this hasn't been my first patchset sent to the kernel e-mailing list.
Although all of the previous ones didn't involve someone else participating
in the changes development, except the reviewers of course. So I do aware
of all the tags mentioned in the doc. But as it turns out I didn't
fully understand their meaning. Main rule: most of the tags should not be
added without the permission, except more or less formal CC and Fixes ones.
Anyway thanks for the advice. Next time I'll be more careful with it.

Regards,
-Sergey

> 
> Thanks,
>     Paul
