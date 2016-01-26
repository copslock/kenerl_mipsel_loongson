Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 20:44:55 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37397 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011617AbcAZTowOmXl4 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2016 20:44:52 +0100
Received: by mail-ig0-f179.google.com with SMTP id h5so58632439igh.0;
        Tue, 26 Jan 2016 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+wIF6m1WEAefILO3uRc6NtTwynvjxsa4TvLya05yTJo=;
        b=YSoxfWnyg6wfvlopPfmKHB79eotBr104T1+1kfZSdhD5YUpekLYyFqFMub7ZpI1w9F
         2s/Q+wGSsKe/jr8BF9oE7d0ACfX9dIELytunM9I+XcvyjvdjlyIMg11EHhV7Lb1Bj6WB
         H1LC1+G7altoWknnNdOaBeMTxXtKPCre3drpU5xTdJQmO9/729QlMbKupC77PEupOiDM
         x5de9gvayO2ODNeI/N+QKnowgholPuNrCErVqS7kVHEfMYB6SZcKX01/6k7Hb4CzAjC2
         APngs3T8FcDfLqctu5Ce4WPKcmttjTgCc2Ew64FFBTucz1jTPzQYDdJgjyE+1BAuYXpn
         ODqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+wIF6m1WEAefILO3uRc6NtTwynvjxsa4TvLya05yTJo=;
        b=IG73SnEq+DO3CKmZnfSucl68V0mwjLRwtWXbW1JPGStdmkxrywnBPbMi8N2bYKXedp
         zNrliarbdlj1ukkGd4OVZaPk5Mckp9VbShqBa5qGj71F59HlVVVOtSbh76uSJWRfQQnY
         GrvNhak0lYVU8yeMd8QoRenDUXMwRI9BYN/hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+wIF6m1WEAefILO3uRc6NtTwynvjxsa4TvLya05yTJo=;
        b=Q3YRe6Fm5su8qkUnun3bLMICaiWLf9hIsMJ4GG2j/nOtX0ZW8bpIZURZuG4GhtCnad
         eSJGUpo0QxQDRSX5VmwOv/oIsPbCf27XWhGlNqdBN/Rzxq+O8W/A3QiUtST8sbbAKHae
         LcQ861E5H1ARfFrs/qFt8k2JRAT/naJCf4lOFvfkCNzfXXgLruIYLiyF3C8cN2wqHGjQ
         50ZcJCcKJWY4Z/v2LY9tNe50od2kgk8W3nSkAot8g/76az5OZizPe9ey+e1kvjbxZLWy
         3l/oDGF90HgMM1bldyUAsOeFKxaqTdp9KgzaVkxPK71pSzHT8FNuxvid3w/VD4xEpOBX
         2Plw==
X-Gm-Message-State: AG10YOSwsnCS2wcTcALDedCkxWS7h0skBPa6DmWCqWSK8kZSMxO5FRfXW1wEp4QxUVTZBafcxv/EM+Pm3IO4Eg==
MIME-Version: 1.0
X-Received: by 10.50.88.72 with SMTP id be8mr24258892igb.45.1453837486386;
 Tue, 26 Jan 2016 11:44:46 -0800 (PST)
Received: by 10.36.60.82 with HTTP; Tue, 26 Jan 2016 11:44:46 -0800 (PST)
In-Reply-To: <20160126172227.GG6357@twins.programming.kicks-ass.net>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
        <20160118081929.GA30420@gondor.apana.org.au>
        <20160118154629.GB3818@linux.vnet.ibm.com>
        <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
        <20160126172227.GG6357@twins.programming.kicks-ass.net>
Date:   Tue, 26 Jan 2016 11:44:46 -0800
X-Google-Sender-Auth: hyQD0gGx7MLms_-hw8MUE-x5u9c
Message-ID: <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        David Daney <ddaney.cavm@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-metag@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joe Perches <joe@perches.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Tue, Jan 26, 2016 at 9:22 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> This is distinct from:

That may be distinct, but:

>         struct foo *x = READ_ONCE(*ptr);
>         smp_read_barrier_depends();
>         x->bar = 5;

This case is complete BS. Stop perpetuating it. I already removed a
number of bogus cases of it, and I removed the incorrect documentation
that had this crap.

It's called "smp_READ_barrier_depends()" for a reason.

Alpha is the only one that needs it, and alpha needs it only for
dependent READS.

It's not called smp_read_write_barrier_depends(). It's not called
"smp_mb_depends()". It's a weaker form of "smp_rmb()", nothing else.

So alpha does have an implied dependency chain from a read to a
subsequent dependent write, and does not need any extra barriers.

Alpha does *not* have a dependency chain from a read to a subsequent
read, which is why we need that horrible crappy
smp_read_barrier_depends(). But it's the only reason.

This is the alpha reference manual wrt read-to-write dependency:

  5.6.1.7 Definition of Dependence Constraint

    The depends relation (DP) is defined as follows. Given u and v
issued by processor Pi, where u
    is a read or an instruction fetch and v is a write, u precedes v
in DP order (written u DP v, that
    is, v depends on u) in either of the following situations:

     • u determines the execution of v, the location accessed by v, or
the value written by v.
     • u determines the execution or address or value of another
memory access z that precedes

    v or might precede v (that is, would precede v in some execution
path depending
    on the value read by u) by processor issue constraint (see Section 5.6.1.3).

Note that the dependence barrier honors not only control flow, but
address and data values too.  This is a different syntax than we use,
but 'u' is the READ_ONCE, and 'v' is the write. Any data, address or
conditional dependency between the two implies an ordering.

So no, "smp_read_barrier_depends()" is *ONLY* about two reads, where
the second read is data-dependent on the first. Nothing else.

So if you _ever_ see a "smp_read_barrier_depends()" that isn't about a
barrier between two reads, then that is a bug.

The above code is crap.  It's exactly as much crap as

   a = READ_ONCE(x);
   smp_rmb();
   WRITE_ONCE(b, y);

because a "rmb()" simply doesn't have anything to do with
read-vs-subsequent-write ordering.

                 Linus
