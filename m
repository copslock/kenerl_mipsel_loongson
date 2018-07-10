Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2018 21:13:26 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:35356
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994427AbeGJTNNV2h17 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Jul 2018 21:13:13 +0200
Received: by mail-lj1-x241.google.com with SMTP id p10-v6so12162367ljg.2;
        Tue, 10 Jul 2018 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ggW1R3iMgkA9CS8e7IhJg5iSjttFX5GWOBFUTrbHqWA=;
        b=D3TgIVLLU9kUzf8wIe4sukhJ48i1jcbphoe4gCfbNl5bU8tQXiqVejIEThR5rM36Rs
         7vwzIQBOiCKUcFl6bqDEYP0tCzIoMNs26hGXd4T94tJ0vwneG8TzqFLf9Ic5PXRKzyuJ
         wQzZJM3MeTpKQThZ5rv18DYeodtf0mTaUlD278mFnAfop0O+4EtaBJdR/gmIX735hsGY
         0LL20tFQCX4AhzbW2MsVHYpfwz//HISv2C3vaXWs5MPlzB73L2L40EOl0U0fBYzQtJCh
         h4ba7EOnwKxT5YxO6YseGwa1dB3fuVj1yfpvsGCo8bTr/IOzNwKIMKl4OkjxSftyGl1C
         mEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ggW1R3iMgkA9CS8e7IhJg5iSjttFX5GWOBFUTrbHqWA=;
        b=SYxvw4QMGFeRBC0HcChSQJaqZ60WKmve4jfk5Z6XJ5kUKTio8DmDE/b2vehiroHCN0
         oquIAjGj2T6eNjoM0HOG5wJikCqwqY5y9ycNHYmDiTJkJsA3oVdpaEkmQJTZAGSzxlwy
         56q4QZJAVo+Wgc/EkbkZRhOpYygWWPZAySrZPgVnBG1btgvzeIwGJqDFW1q2LUxXhrfq
         66Mz8Yw5m+rjrvy/+NCZi6Ikr1vYviy90prmnfIRIyKssNb/KXi6N2ernbShFKV7cGbG
         /YwTYIcanJEdzz5LJr/Emq7QLIoZNR4m1Y4eFBqmTSBEVECaA3QM9kQk7hHInOi/yml5
         QQxw==
X-Gm-Message-State: APt69E3I+hXltY4/DBa7VNvMG9FSOZgRfTpWooi1cPzmprr1khhbWOh6
        CpUA3tjY/Q3PC9VFrJfIYcM=
X-Google-Smtp-Source: AAOMgpe66n6hJzTIsXijXn6IrULUyPYwMe9FLvMX5TeVwxhkFml4pLvDrytflut8Rq05I0Jv1Nux4g==
X-Received: by 2002:a2e:9883:: with SMTP id b3-v6mr15213961ljj.80.1531249987719;
        Tue, 10 Jul 2018 12:13:07 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id p20-v6sm2875063lji.37.2018.07.10.12.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 12:13:06 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:13:54 +0300
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
Message-ID: <20180710191354.GA32182@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
 <20180710074815.GA30235@mobilestation>
 <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710175940.rbjmdcpm54gfrael@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64767
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

On Tue, Jul 10, 2018 at 10:59:40AM -0700, Paul Burton <paul.burton@mips.com> wrote:
Hello Paul,

> Hi Sergey,
> 
> On Tue, Jul 10, 2018 at 10:48:15AM +0300, Serge Semin wrote:
> > On Tue, Jul 10, 2018 at 09:15:17AM +0200, Mathieu Malaterre <malat@debian.org> wrote:
> > > On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> > > > Adaptive ioremap_wc() method is now available (see "mips: mm:
> > > > Create UCA-based ioremap_wc() method" commit). We can use it for
> > > > UCA-featured MMIO transactions in the kernel, so we don't need
> > > > it platform clone ioremap_uncached_accelerated() being declard.
> > > > Seeing it is also unused anywhere in the kernel code, lets remove
> > > > it from io.h arch-specific header then.
> > > >
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > Singed-off-by: Paul Burton <paul.burton@mips.com>
> > > 
> > > nit: 'Signed' (on both patches)
> > 
> > Good catch! Thanks. Didn't notice the typo. Should have copy-pasted
> > both the signature and the e-mail from another letter.
> > 
> > I'll fix it if there will be a second version of the patchset. Otherwise
> > I suppose it would be easier for the integrator to do this.
> 
> I've fixed this up & applied these 2 patches with minor tweaks to
> mips-next for 4.19.
> 

Great! Thanks.

> However FYI for next time - you shouldn't really add someone else's
> Signed-off-by tag anyway. The tag effectively states that a person can
> agree to the Developer's Certificate of Origin for this patch (see
> Documentation/process/submitting-patches.rst), and you can't agree that
> on behalf of someone else. Generally a maintainer should add this tag
> for themselves when they apply a patch.
> 

I'm sorry if it seemed like I added Signed-off on your behalf. I thought
the Signed-off also concerns the ones, who participated in the patch
preparation. Since you suggested the design of the change, I've decided
to put your name in the Signed-off tag. What shall I use in this way
then?

> Anyway, I think we should reserve the Singed-off-by tag for patches that
> quell fires. ;)
> 
> Thanks,
>     Paul

Regards,
-Sergey
