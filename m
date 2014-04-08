Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 20:39:38 +0200 (CEST)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:51144 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817327AbaDHSjf5nME3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 20:39:35 +0200
Received: by mail-qg0-f45.google.com with SMTP id j5so1204210qga.32
        for <linux-mips@linux-mips.org>; Tue, 08 Apr 2014 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FBDpjCQaaii3JqBUAuTEQsIILnmAkzJAuB7RSPh+Szg=;
        b=G1PQUpF+8q2wUHiVPXn5Spc9McXAEARImR2mi3MTixb38RGVjNEv7Zvgvfu2xrz86G
         bHfE/LwwhGfRAPNnb+ByFmXa8+Jt6nBDfeOn3X5YUMXVjpJDEVZ+df0QFbyJFmuQBBBP
         bdbHjURv9CMouFtXnz4x6pM4n9wrvUK09r+BWGd4LOM3sZ2n6O88MgyHhH/Jo9PzPKjd
         iFbZViWppOG6gCH/s65Lzr29m7lMHtjQdrr8oia7xltD96AQjqBYNFDOQQtIUQQbpCOo
         foo61Qy1oh0IkksaQztnYsSoxKCvwVnVw8T6slUa08WPYzh5rYHsk352oSXyhDH31e4B
         4asw==
X-Received: by 10.224.47.130 with SMTP id n2mr6863110qaf.26.1396982369872;
 Tue, 08 Apr 2014 11:39:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.96.79.69 with HTTP; Tue, 8 Apr 2014 11:38:49 -0700 (PDT)
In-Reply-To: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 8 Apr 2014 11:38:49 -0700
Message-ID: <CAGVrzcZXUWmWO3iuDGPPtKaT1O5qr50LpeSPPHxFCqovkQXzag@mail.gmail.com>
Subject: Re: [PATCH 00/14] Initial BPF-JIT support for MIPS
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi,

2014-04-08 4:47 GMT-07:00 Markos Chandras <markos.chandras@imgtec.com>:
> Hi,
>
> This adds support for BPF-JIT for MIPS. Tested on mips32 LE/BE and mips64 BE
> with a few networking tools such as tcpdump and dhcp but not all opcodes have
> been tested as far as I can tell. There are a few optimizations left to be made
> (fastpath for load operations instead of calling the helper functions) but
> these can be added later on. If someone has complex network setups in place and
> would like to give it a try, that would be much appreciated.
>
> This patchset is for the upstream-sfr/mips-for-linux-next tree

You should have probably CC'd netdev@vger.kernel.org to get their
review on the specific JIT implementation.

BPF_JIT is made conditional to MIPS32/64R2 processors, I could not
spot easily in the implementation whether this is because you are
using r2-only instructions, or this is just the targets you tested. Is
there any chance to make that work on MIPS32r1 CPUs for instance?
Those are used in low-end devices which could benefit from such a
performance boost.

Thanks!

>
> Markos Chandras (14):
>   MIPS: uasm: Add u3u2u1 instruction builders
>   MIPS: uasm: Add u2u1 instruction builders
>   MIPS: uasm: Add sllv uasm instruction
>   MIPS: uasm: Add srlv uasm instruction
>   MIPS: uasm: Add divu uasm instruction
>   MIPS: uasm: Add mfhi uasm instruction
>   MIPS: uasm: Add jalr uasm instruction
>   MIPS: uasm: Add sltiu uasm instruction
>   MIPS: uasm: Add sltu uasm instruction
>   MIPS: uasm: Add wsbh uasm instruction
>   MIPS: uasm: Add lh uam instruction
>   MIPS: uasm: Add mul uasm instruction
>   MIPS: net: Add BPF JIT
>   MIPS: Enable the BPF_JIT symbol for MIPS
>
>  arch/mips/Kbuild                  |    1 +
>  arch/mips/Kconfig                 |    1 +
>  arch/mips/include/asm/uasm.h      |   16 +
>  arch/mips/include/uapi/asm/inst.h |   17 +
>  arch/mips/mm/uasm-micromips.c     |   10 +
>  arch/mips/mm/uasm-mips.c          |   10 +
>  arch/mips/mm/uasm.c               |   39 +-
>  arch/mips/net/Makefile            |    3 +
>  arch/mips/net/bpf_jit.c           | 1327 +++++++++++++++++++++++++++++++++++++
>  arch/mips/net/bpf_jit.h           |   45 ++
>  10 files changed, 1462 insertions(+), 7 deletions(-)
>  create mode 100644 arch/mips/net/Makefile
>  create mode 100644 arch/mips/net/bpf_jit.c
>  create mode 100644 arch/mips/net/bpf_jit.h
>
> --
> 1.9.1
>
>



-- 
Florian
