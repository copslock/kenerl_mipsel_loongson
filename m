Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 00:32:36 +0200 (CEST)
Received: from mail-qa0-f48.google.com ([209.85.216.48]:43699 "EHLO
        mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860317AbaGCWcens2nO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 00:32:34 +0200
Received: by mail-qa0-f48.google.com with SMTP id x12so749835qac.35
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 15:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=pkfg0vurlq533TLeRantJVz5mTmK/QaqcBY9+wfPPxk=;
        b=h6yUtFy3Vl246QlwzZRoa/U8K2tJgJy4i33zSpZGVenodJxk3P0LZhHVeDCRLbk3EK
         3ZYbJawyDawbeMZunZJ5LIiglRWR5ypfh1ESUoNNAVrCpbwSHomc6w3+2KLQMKpnQ7I/
         x+3lsWFtAEnp9atoE/NkDtKmq4bbC0UUVvyt4jk7zG1Agyvxr9pji63TNZryn+OHQacs
         UjwLxeaXLm+PaxXR9octm4AjikSLPd3EBHphulof624pKWaEJxP6io/3WP8RuN7BfKIb
         /ddX8GkAqsDYe5q3WvAkHNKgey1jQhiYnI6Wl3zFjgzl/B2cORRmvvgd21ee9luM8bsK
         G7iQ==
X-Gm-Message-State: ALoCoQktVKJhImXVLuDNk3HYkeeh4EQZK6x/igvhRsDzuSN+19ilYrUBPv88tGtGh1eB4wpzCWx3
X-Received: by 10.224.171.195 with SMTP id i3mr12508298qaz.44.1404426748447;
 Thu, 03 Jul 2014 15:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.88.2 with HTTP; Thu, 3 Jul 2014 15:31:48 -0700 (PDT)
From:   Ed Swierk <eswierk@skyportsystems.com>
Date:   Thu, 3 Jul 2014 15:31:48 -0700
Message-ID: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay slots
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, ddaney.cavm@gmail.com,
        ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <eswierk@skyportsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eswierk@skyportsystems.com
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

On Thu, Jul 3, 2014 at 1:12 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> On Thu, Jul 03, 2014 at 10:56:10AM -0700, Ed Swierk wrote:
>> Now that Linux makes user stacks
>> non-executable by default, the current FP emulation approach is simply
>> broken.
>
> Really? I wasn't aware of any change to the default attributes of the
> stack. Do you know what changed? From a quick look at fs/binfmt_elf.c &
> arch/mips/include/asm/elf.h I can't see anything relevant having
> changed - the stack should be executable unless a non-executable
> PT_GNU_STACK header is present in the ELF. I don't suppose the issue
> is simply that such a PT_GNU_STACK header is present in your binaries?

Actually that was a completely unsupported assertion on my part. I
have no reason to believe there was a change in behavior in the kernel
or the toolchain (gcc 4.9.0, x86_64 host, mips target; binutils
2.24.51.20140425).

What I do notice is that mips-linux-gnu-gcc generates no
.note.GNU-stack section, while x86_64-linux-gnu-gcc does. In turn, ld
produces no GNU_STACK program header on the mips executable, while for
x86_64 it produces GNU_STACK with RW (no E) flags.

The toolchain behavior is the same for gccgo as for gcc. But I get a
segv on the Octeon2 target only when running a gccgo-generated
executable. A C program compiled with gcc works fine performing the
same FP operations.

And when I add the following hack to mips/include/asm/elf.h in the
kernel, the segv goes away:

   #define elf_read_implies_exec(ex, have_pt_gnu_stack) 1

So I assume gccgo or libgo is doing some extra magic that makes the
stack non-executable on mips at least.

>> I'm wondering if instead of trying to free the page
>> for the FP branch delay emuframe immediately, it would be simpler to
>> leave it around until the thread is destroyed.
>
> It's not really an issue of freeing a page - my patch mapped one page
> per-mm (per-process) and that page was left intact for the life of that
> mm (process).

Ah, I see. What if we allocate a page per thread rather than per
process? Then the bookkeeping becomes a lot simpler, as there can be
only a single emuframe in the page at one time. And we can defer
freeing the page until the thread exits.

Assuming we could tolerate the overhead of an entire page for a puny
little emuframe, do you think the approach would work?

--Ed
