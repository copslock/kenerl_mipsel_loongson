Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2015 17:06:41 +0100 (CET)
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35725 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011586AbbKNQGjW-rCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Nov 2015 17:06:39 +0100
Received: by vkas68 with SMTP id s68so7789382vka.2
        for <linux-mips@linux-mips.org>; Sat, 14 Nov 2015 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MqCx4Yjx9kFhh4QlCq+4HOP93F+2l4DhLkJbpTF5WEA=;
        b=nq+SteKCfPJST44ZBfGaeScH0kpXH+4gcd/fPNojqooFYhBiODvk2wiZZqLPvZe6+p
         lnl1f8FiMpV11ib+HvLAKPwhAmn5Kb43QpmfO8Whfq+KRSFjs+2+pcsEov+lPwb+d6m5
         bgVDVvJ2/C1HGE9FYLz/skxS2unwrREbGA+ddYwSfLUnX+WF3IU65i0IQFI4neyY/V/5
         7+8lB9ZEF0+QZjm3Am1a9uIPlu+AG/nYxG8M2zY4m8RSj+TGenzbY7R+6Sixu8nQ7USS
         tfK7lBSH9OxmG+ZMewnluJsfTdDHpyTU/JEVzJZHl+Yd2Lskp8uR7vmHGw+BDMqpfTtt
         Z2iQ==
MIME-Version: 1.0
X-Received: by 10.31.31.23 with SMTP id f23mr3788933vkf.23.1447517193491; Sat,
 14 Nov 2015 08:06:33 -0800 (PST)
Received: by 10.31.16.3 with HTTP; Sat, 14 Nov 2015 08:06:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511140411050.7097@tp.orcam.me.uk>
Date:   Sat, 14 Nov 2015 08:06:33 -0800
Message-ID: <CAJimCsE4GcizTpOgvyGrbPu80SanG1sW3UdmEnq2U=qzCxaW=w@mail.gmail.com>
Subject: Re: [RFC] MIPS ABI Extension for IEEE Std 754 Non-Compliant Interlinking
From:   Cary Coutant <ccoutant@gmail.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org, libc-alpha@sourceware.org,
        Binutils <binutils@sourceware.org>,
        GCC Development <gcc@gcc.gnu.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ccoutant@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ccoutant@gmail.com
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

> 3.3.2 Static Linking Object Acceptance Rules
>
>  The static linker shall follow the user selection as to the linking mode
> used, either of `strict' and `relaxed'.  The selection will be made
> according to the usual way assumed for the environment used, which may be
> a command-line option, a property setting, etc.
>
>  In the `strict' linking mode both `strict' and `legacy' objects can be
> linked together.  All shall follow the same legacy-NaN or 2008-NaN ABI, as
> denoted by the EF_MIPS_NAN2008 flag described in Section 3.1.  The value
> of the flag shall be the same across all the objects linked together.  The
> output of a link involving any `strict' objects shall be marked as
> `strict'.  No `relaxed' objects shall be allowed in the same link.
>
>  In the `relaxed' linking mode any `strict', `relaxed' and `legacy'
> objects can be linked together, regardless of the value of their
> EF_MIPS_NAN2008 flag.  If the flag has the same value across all objects
> linked, then the value shall be propagated to the binary produced.  The
> output shall be marked as `relaxed'.  It is recommended that the linker
> provides a way to warn the user whenever a `relaxed' link is made of
> `strict' and `legacy' objects only.

This paragraph first says that "If the flag has the same value across
all objects linked, then the value shall be propagated to the binary
produced", but then says the "output shall be marked as `relaxed'."
Are you missing an "Otherwise" there?

Early on in the document, you mention "this applies regardless of
whether it relies on the use of NaN data or IEEE Std 754 arithmetic in
the first place," yet your solution is only two-state. Wouldn't it be
better to have a three-state solution where objects that do not in
fact rely on the NaN representation at all can be marked as "don't
care"? Such objects could always be mixed with either strict or
relaxed objects, regardless of linking mode.

-cary
