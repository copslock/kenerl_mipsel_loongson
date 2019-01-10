Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E81C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A6F206B7
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfAJSmU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:42:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33938 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSmU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 13:42:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so5714973pfg.1
        for <linux-mips@vger.kernel.org>; Thu, 10 Jan 2019 10:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGasrVzvEskVALjTN+U9OyTmUnvOkaob82Q5yxrG+Eo=;
        b=qEXOY5czLyJl7uCyOvoTKUVJa9tdAcyNEw063u3UqAUgpn0FMpiX3f+H0hsGzFBZv+
         +zEFq8B/eFxHYG6Ie8q5fhcBIphXgOoK/iSAoo+6JBTdW0lcj9OJx3ZyDYIGDYYptig8
         c3XrC1Ku+kviDIjDt0IFU46Rrd+G5CbGioarU5a0JxW/joIv1Ug5j1cx8phJXt7Rxzre
         I/IXgmZi6Wics2fAsei39Jt14Or8lhek7JXOyjAMtDWy3w4OcLMw45e6Osmgd0rGzwAC
         Fnp83kkXRYljQS0WyNYsWGL2/8fEcAZgN0OnlrjaZ3Xfcm1H2mwyUGGuQlVtGLNspiT5
         5C7g==
X-Gm-Message-State: AJcUukfw2I77x3GWNP+110a+81LszBnO5wUGGA6XX8Z8ON2WGCDyxtN3
        AIA1D0M+IrK0+WX87UvOIZf8G1mpAQ6TvHv1x+4=
X-Google-Smtp-Source: ALg8bN5hWbqgqQyiVKaA24wHWgC5lIkpmsKhC9vu3q3UGU4ycjqSWO9oHKmDfA7k2UulfMLD31l3uduxA0K6eUsAyy8=
X-Received: by 2002:a62:c42:: with SMTP id u63mr11091782pfi.73.1547145739224;
 Thu, 10 Jan 2019 10:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20190105150037.30261-1-syq@debian.org> <20190109220844.qk5ufkzjmfwxe5aq@pburton-laptop>
 <723B8029-77BE-4DF8-A9FB-74E59F8AA6F8@wavecomp.com> <20190110173552.aeghk2rjiqcglgh6@pburton-laptop>
In-Reply-To: <20190110173552.aeghk2rjiqcglgh6@pburton-laptop>
From:   YunQiang Su <syq@debian.org>
Date:   Fri, 11 Jan 2019 02:42:07 +0800
Message-ID: <CAKcpw6WnON7HcKN1JuPS827amtoYvs8w6Hx2kfaua5Ay9_R0eQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson, add sync before target of branch
 between llsc
To:     Paul Burton <paul.burton@mips.com>
Cc:     Yunqiang Su <ysu@wavecomp.com>,
        "paul.hua.gm@gmail.com" <paul.hua.gm@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "chehc@lemote.com" <chehc@lemote.com>,
        "zhangfx@lemote.com" <zhangfx@lemote.com>,
        "wuzhangjin@gmail.com" <wuzhangjin@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Paul Burton <paul.burton@mips.com> 于2019年1月11日周五 上午1:35写道：
>
> Hi Yunqiang,
>
> On Wed, Jan 09, 2019 at 05:59:07PM -0800, Yunqiang Su wrote:
> > > 在 2019年1月10日，上午6:08，Paul Burton <pburton@wavecomp.com> 写道：
> > > On Sat, Jan 05, 2019 at 11:00:36PM +0800, YunQiang Su wrote:
> > >> Loongson 2G/2H/3A/3B is quite weak sync'ed. If there is a branch,
> > >> and the target is not in the scope of ll/sc or lld/scd, a sync is
> > >> needed at the postion of target.
> > >
> > > OK, so is this the same issue that the second patch in the series is
> > > working around or a different one?
> > >
> > > I'm pretty confused at this point about what the actual bugs are in
> > > these various Loongson CPUs. Could someone provide an actual errata
> > > writeup describing the bugs in detail?
> > >
> > > What does "in the scope of ll/sc" mean?
> >
> > Loongson 3 series has some version, called, 1000, 2000, and 3000.
> >
> > There are 2 bugs all about LL/SC. Let’s call them bug-1 and bug-2.
> >
> > BUG-1:  a `sync’ is needed before LL or LLD instruction.
> >               This bug appears on 1000 only, and I am sure that it has been fixed in 3000.
> >
> > BUG-2: if there is an branch instruction inside LL/SC, and the branch target is outside
> >              of the scope of LL/SC, a `sync’ is needed at the branch target.
> >              Aka, the first insn of the target branch should be `sync’.
> >              Loongson said that, we don’t plan fix this problem in short time before they
> >              Designe a totally new core.
> >
> >
> > > What happens if a branch target is not "in the scope of ll/sc”?
> >
> > At least they said that there won’t be a problem
>
> You still didn't define what "in the scope of ll/sc" means - I'm
> guessing that you're referring to a branch target as "in scope" if it is
> in between the ll & sc instructions (inclusive?). But this is just a
> guess & clarity from people who actually know would be helpful.
>

Yes. your guess is correct. It is between.

> And there must be a problem. The whole point of this is that there's a
> bug, right? If there's no problem then we don't need to do anything :)
>

Sure. It is a problem.
Some Loongson guys seem no dare to say out their CPU is buggy.

> From a look at the GCC patch it talks about placing a sync at a branch
> target if it *is* in between an ll & sc [1], which I just can't
> reconcile with the phrase "outside of the scope of LL/SC". Is the
> problem when a branch target *is* in between an ll & sc, or when it *is
> not* between an ll & sc?

This problem happens when:
    the branch insn like `beq' is between ll and sc
      AND
    the target of the branch insn is not between ll/sc

>
> Reading this kernel patch doesn't make it any clearer - for example the
> sync it emits in build_loongson3_tlb_refill_handler() is nowhere near an
> ll or sc instruction. Something doesn't add up here.
>

Loongson guys told me that, there is a branch insn between ll and sc
may jump here.
In fact I don't know where is the insn.

> > > How does the sync help?
> > >
> > > Are jumps affected, or just branches?
> >
> > I am not sure, so CC a Loongson people.
> > @Paul Hua
>
> Hi Paul - any help obtaining a detailed description of these bugs would
> be much appreciated. Even if you only have something in Chinese I can
> probably get someone to help translate.
>
> > > Does this affect userland as well as the kernel?
> >
> > There is few place can trigger these 2 bugs in kernel.
> > In user land we have to workaround in binutils:
> >    https://www.sourceware.org/ml/binutils/2019-01/msg00025.html
> >
> > In fact the kernel is the easiest since we can have a flavor build for Loongson.
>
> My concern with regards to userland is that there's talk of a "deadlock"
> - if userland can hit this & the CPU actually stalls then the system is
> hopelessly vulnerable to denial of service from a malicious or buggy
> userland program, or simply an innocent program unaware of the errata.
>

I have an Loongson 3A 3000 laptop.
If without any workaround, the whole system hangs very frequently.
With this patch, the whole system hangs rarely.

Since the bug effects the userland, applications still hangs
frequently, for example `tmux'.

In Debian, we have a list packages that can build on Cavium while
cannot on Loongson 1000.
       bcftools botch casacore ceres-solver chemps2 clippoly cpl-plugin-giraf
       cpl-plugin-xshoo dolfin freeipa git golang-1.11 graphicsmagick
igraph libminc knot-resolver nodejs
       octave-ltfat prodigal pypy redis ruby2.3 ghc yade
Most of them fail due to hangs.
I tested them on Loongson 3K, some of them can build successfully now,
and some of them cannot
build still.

I guess the reason is that we also need some workaround in userland,
like libc etc.

> > > ...and probably more questions depending upon the answers to these ones.
> > >
> > >> Loongson doesn't plan to fix this problem in future, so we add the
> > >> sync here for any condition.
> > >
> > > So are you saying that future Loongson CPUs will all be buggy too, and
> > > someone there has said that they consider this to be OK..? I really
> > > really hope that is not true.
> >
> > Bug is bug. It is not OK.
> > I blame these Loongson guys here.
> > Some Loongson guys is not so normal people.
> > Anyway they are a little more normal now, and anyway again, still abnormal.
> >
> > > If hardware people say they're not going to fix their bugs then working
> > > around them is definitely not going to be a priority. It's one thing if
> > > a CPU designer says "oops, my bad, work around this & I'll fix it next
> > > time". It's quite another for them to say they're not interested in
> > > fixing their bugs at all.
> >
> > They have interests, while I guess the true reason is that they have no enough
> > people and money to desgin a core, while this bug is quilt hard to fix.
>
> I'm not sure I fully understand what you're saying above, but
> essentially I want to know that Loongson care about fixing their CPU
> bugs. If they don't, and the bugs are as bad as they sound, then in my
> view working around them will only reinforce that producing CPUs with
> such serious bugs is a good idea.
>

Yes, you are correct. (some bad words here.

> So if anyone from Loongson is reading, I'd really like to hear that the
> above is a miscommunication & that you're not intending to knowingly
> design any further CPUs with these bugs.
>

In fact I told with them lots of  times face to face.
The only improve of them is that finally they can say out this is a
bug not features.

> Thanks,
>     Paul
>
> [1] https://gcc.gnu.org/ml/gcc-patches/2018-12/msg01064.html
>     ("Loongson3 need a sync before branch target that between ll and sc.")
