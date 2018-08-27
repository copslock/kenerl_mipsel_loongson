Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 09:44:06 +0200 (CEST)
Received: from mail-pg1-x543.google.com ([IPv6:2607:f8b0:4864:20::543]:41390
        "EHLO mail-pg1-x543.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992479AbeH0HoC1mGDq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2018 09:44:02 +0200
Received: by mail-pg1-x543.google.com with SMTP id s15-v6so7033443pgv.8
        for <linux-mips@linux-mips.org>; Mon, 27 Aug 2018 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FATUuEn4ZktRkYrfHP8JXWFnuJYiqWxAAu/i4BXuczo=;
        b=mxmYkQqrEL1Q+Dm21YAWMAN6kAQOyVIumkyW1gJE4RcxIzvbiU1IV48ROMjm4JU/V3
         InpcYpaJsOi0KXVzbfPT8Az0mTEWIAQ8XwWnP1Y+Dvabcz/w+BYJ1MJFq0VlBw03Y7NR
         Gc3cWKYA9kWNaqtgUD9C7K4PqqWJh/FxZNbjR7Zt4mpu1IVY001Z+Wvy5oflgm5ep/PD
         XDaE0TtHJPnFo6D+W70t97D2FPGhpgKux17ibZi39Ya93vUP9Yjv+9K9RdwoCDgfkV15
         6nlB0SlWLqjQbPfYqiJLfqxNWRKVaBhgg03KNaNvmuUXlECafEwlbVKVcKJz39jZVogI
         uMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FATUuEn4ZktRkYrfHP8JXWFnuJYiqWxAAu/i4BXuczo=;
        b=RQtutU1z8QT6MIYtxV5voBZW7qdcYLoGqyhtnwSBIZHz2DFBmvgbXIHY1vm/Obk36u
         JZ41HFX3vlJr4r168rn2PosS31X5g6twXjkW/hTxfx7PrW2BqYlfHEhHinlYlSz76NOR
         lBM3Txqml1KJdNRPmR235+OOzfGO7js7lzHN6q3Tw0EnoJtPkkBvRn6rP45xrc0TvuZL
         Kw+q25xk5vN3wUsDlgC1EGlvHl7KbARsabvq7RiLR8qRXw0+xX1HNAdQlMyfyE5iyFCH
         sE6fMoDHzGqUa/dVio+tEFOcUnnVBJ7yC7IZmmZe+9ZPvZgm39yZYkfSe/5254t3RNE3
         1RFA==
X-Gm-Message-State: APzg51DvVfk9jHNlHnzKCbXpuv0irnWzsfhbBDqf5WQd4FcEpup+c/jW
        hwYjdaYnzC/xIsLNLKb4ngY=
X-Google-Smtp-Source: ANB0VdZmkOKZnLtrqsdn4RgYlVkLHvgY0wfTEqh9zRZb7NQFVp40wPhrJMs92Klp505EJpTH1hXSEg==
X-Received: by 2002:a63:170e:: with SMTP id x14-v6mr10871115pgl.364.1535355835926;
        Mon, 27 Aug 2018 00:43:55 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-83-192.tpgi.com.au. [59.102.83.192])
        by smtp.gmail.com with ESMTPSA id v23-v6sm18926132pfm.80.2018.08.27.00.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 00:43:55 -0700 (PDT)
Date:   Mon, 27 Aug 2018 17:43:43 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Anvin <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>, openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH] treewide: remove current_text_addr
Message-ID: <20180827161121.07aa9da6@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
References: <CAKwvOdkWL_2yTnJqM6n6R9UCPwY4iz-9BQYGN2MDAk9EzumUvA@mail.gmail.com>
        <20180821202900.208417-1-ndesaulniers@google.com>
        <207784db-4fcc-85e7-a0b2-fec26b7dab81@gmx.de>
        <c62e4e00-fb8f-19a6-f3eb-bde60118cb1a@zytor.com>
        <81141365-8168-799b-f34f-da5f92efaaf9@zytor.com>
        <7f49eeab-a5cc-867f-58fb-abd266f9c2c9@zytor.com>
        <6ca8a1d3-ff95-e9f4-f003-0a5af85bcb6f@zytor.com>
        <CA+55aFzuSCKfmgT9efHuwtan+m3+bPh4BpwbZwn5gGX_H=Thuw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <npiggin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: npiggin@gmail.com
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

[ Trimmed the cc list because my SMTP didn't accept that many
addresses. ]

On Sun, 26 Aug 2018 13:25:14 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Aug 26, 2018 at 12:32 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > Here is a full-blown (user space) test program demonstrating the whole
> > technique and how to use it.  
> 
> So while I agree that some _THIS_IP_ users might be better off being
> converted to __builtin_return_address(0) at the caller, I also think
> that the whole "notailcall" thing shows why that can easily be more
> problematic than just our currnet _THIS_IP_ solution.
> 
> Honestly, I'd suggest:
> 
>  - just do the current_text_addr() to _THIS_IP_ conversion
> 
>  - keep _THIS_IP_ and make it be the generic one, and screw the whole
> "some architectures might implement is better" issue. Nobody cares.
> 
>  - try to convince people to move away from the "we want the kernel
> instruction pointer for the call" model entirely, and consider this a
> "legacy" issue.
> 
> The whole instruction pointer is a nasty thing. We should discourage
> it and not make complex infrastructure for it.
> 
> Instead, maybe we could encourage something like
> 
>   struct kernel_loc { const char *file; const char *fn; int line; };
> 
>   #define __GEN_LOC__(n) \
>         ({ static const struct kernel_loc n = { \
>                 __FILE__, __FUNCTION__, __LINE__  \
>            }; &n; })
> 
>   #define _THIS_LOC_ __GEN_LOC__(__UNIQUE_ID(loc))
> 
> which is a hell of a lot nicer to use, and actually allows gcc to
> optimize things (try it: if you pass a _THIS_LOC_ off to an inline
> function, and that inline function uses the name and line number, gcc
> will pick them up directly, without the extra structure dereference.
> 
> Wouldn't it be much nicer to pass these kinds of "location pointer"
> around, rather than the nasty _THIS_IP_ thing?

Seems nice. Do you even need this unique ID thing? AFAIKS the name
would never really be useful.

It could perhaps go into a cold data section too, I assume the common
case is that you do not access it. Although gcc will end up putting
the file and function names into regular rodata.

Possibly we could add a printk specifier for it, pass it through to
existing BUG, etc macros that want exactly this, etc. Makes a lot of
sense.

Thanks,
Nick
