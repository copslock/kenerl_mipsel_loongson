Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 23:15:30 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37707 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011640AbcAZWP2ZGpOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 23:15:28 +0100
Received: by mail-ig0-f173.google.com with SMTP id h5so61357509igh.0;
        Tue, 26 Jan 2016 14:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yQhex/wmTmU4n9V+/iMiQO1EEriVsrZ6SFDd6VACXCM=;
        b=zTYRZfa1NFjHa8/Jw5ZF/plxa2rkxbH7qbwbUh9Tjx0T3VnRCYpsnIY2VhQt5ZZmhg
         RkVBaNP92OxvT+oGsNIuErRxG8UMhn7/9jdFj8Wc7VA6FpLJFJQASOTERtbsqmwj8JpJ
         RZ4J5Ozuv4CegTrBRt6T6zrizokSjGHRW1ObMKwLO0G2+yOSK8+7UL8IUABXEMdnbTF6
         ckJNcifFVT9uqEXzQcZPszM/Z1nr93aIIcc71zhHdDKsD5UCGmfp9MTVAGJ0PDwQsBDX
         2/PKZOOSIBnrwdWO/VMc+4g/oxBI/1SrSOl5vcGH8pyHj/PSJARFaoYDCEhvGEkUQ66C
         5vLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=yQhex/wmTmU4n9V+/iMiQO1EEriVsrZ6SFDd6VACXCM=;
        b=JKA67Uwd1a23lT+7fMM3cDw1hjUDERe/WvE0WvKaVkcxP5nIcdPb8aN/W2qd8r5err
         RtJ8ooVwbZv2lk+E8I/F7lZhFSg3KEeszjTOZZF/94Ji4e7xvkP7MNj/h8CGMGiM9mae
         YqU3fEwhU67gskq4hj5cdq3DZijwHz3SrhEjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yQhex/wmTmU4n9V+/iMiQO1EEriVsrZ6SFDd6VACXCM=;
        b=XO8l98LMWOvkPpORtG9xYZqKwp2Xsl+Bdz3NOBuN6hJpQwvYP9RTGV6G81Iy3HUT5F
         Cg/tIMrzkVAj8UqPXPkQB7Aa1B/H6FhV9kIH1SLgoL4ridfqEbdX8kyFleeHJvLZqXpu
         D8IJnRmRr0mKML706vD2K8v17FTsN86vs4/qHb2pAk2b6hR+NcSMvLcy0iKGWqtNuZav
         FhvIsvaF58mjFyAidKwV56ZI2wiYQBwp5FQ4HaNZKmGQ5iFJJzJbek7pRvq8a++u3Kxq
         RNs2ALS4jsuewIAedQtNMQzmxbTpT9tM+45XfTBthZ2H2Dku6Ku3bEtqYq8nD90JN3vc
         b5kg==
X-Gm-Message-State: AG10YOQPDa2LGlxAOIaUwZFlsBPwNv1Umt4/O/IXpEEZrCA8Y/kVk668msPUlXZyAgFtz+7Xe5pk0AUq/MV//g==
MIME-Version: 1.0
X-Received: by 10.50.88.74 with SMTP id be10mr24127853igb.93.1453846522122;
 Tue, 26 Jan 2016 14:15:22 -0800 (PST)
Received: by 10.36.60.82 with HTTP; Tue, 26 Jan 2016 14:15:21 -0800 (PST)
In-Reply-To: <20160126201037.GU4503@linux.vnet.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
        <20160118081929.GA30420@gondor.apana.org.au>
        <20160118154629.GB3818@linux.vnet.ibm.com>
        <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
        <20160126172227.GG6357@twins.programming.kicks-ass.net>
        <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
        <20160126201037.GU4503@linux.vnet.ibm.com>
Date:   Tue, 26 Jan 2016 14:15:21 -0800
X-Google-Sender-Auth: ZoCiCh0E_TG1RQIsN68oPQU7jCk
Message-ID: <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51438
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

On Tue, Jan 26, 2016 at 12:10 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Jan 26, 2016 at 11:44:46AM -0800, Linus Torvalds wrote:
>>
>> >         struct foo *x = READ_ONCE(*ptr);
>> >         smp_read_barrier_depends();
>> >         x->bar = 5;
>>
>> This case is complete BS. Stop perpetuating it. I already removed a
>> number of bogus cases of it, and I removed the incorrect documentation
>> that had this crap.
>
> If I understand your objection correctly, you want the above pattern
> expressed either like this:
>
>         struct foo *x = rcu_dereference(*ptr);
>         x->bar = 5;
>
> Or like this:
>
>         struct foo *x = lockless_dereference(*ptr);
>         x->bar = 5;
>
> Or am I missing your point?

You are entirely missing the point.

You might as well just write it as

    struct foo x = READ_ONCE(*ptr);
    x->bar = 5;

because that "smp_read_barrier_depends()" does NOTHING wrt the second write.

So what I am saying is simple: anybody who writes that
"smp_read_barrier_depends()" in there is just ttoally and completely
WRONG, and the fact that Peter wrote it out after I removed several
instances of that bloody f*cking idiocy is disturbing.

Don't do it. It's BS. It's wrong. Don't make excuses for it.

             Linus
