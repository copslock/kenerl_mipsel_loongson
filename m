Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 01:23:15 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006585AbbIFXXMwnET2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 01:23:12 +0200
Date:   Mon, 7 Sep 2015 00:23:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Yousong Zhou <yszhou4tech@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: UAPI: Fix unrecognized opcode WSBH/DSBH/DSHD when
 using MIPS16.
In-Reply-To: <CAECwjAiyaWMeh32SOWPi8k=Zb4bQW3mNkbC6drnyy3Wtn924Ng@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1509062335060.10227@eddie.linux-mips.org>
References: <1441273665-15601-1-git-send-email-yszhou4tech@gmail.com> <alpine.LFD.2.20.1509041924220.10227@eddie.linux-mips.org> <CAECwjAihV86pXqCA1tAthZKd5WoSm0-yO6++Gj7pff4K2qGJzQ@mail.gmail.com> <alpine.LFD.2.20.1509051421020.10227@eddie.linux-mips.org>
 <CAECwjAiyaWMeh32SOWPi8k=Zb4bQW3mNkbC6drnyy3Wtn924Ng@mail.gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sun, 6 Sep 2015, Yousong Zhou wrote:

> Hi, Maciej, first of all, thank you for your time on this,
> appreciate it.

 You're welcome!

> >  The bug certainly was there, it's just your analysis and consequently the
> > fix that are wrong in the general case for some reason, maybe a buggy
> > compiler.
> >
> 
> This is the compiler "--version",
> 
>     mips-openwrt-linux-gcc (OpenWrt/Linaro GCC 4.8-2014.04 r46763) 4.8.3

 A-ha!  I've checked GCC's history and the symptom you're seeing was PR 
target/55777:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=55777

and the bug has only been fixed pretty recently (r199328), already after 
GCC 4.8 has branched.  From your troubles I infer the fix has not been 
backported to 4.8 and therefore is only available from GCC 4.9 up; of 
course either you or OpenWrt can still backport it and apply locally.

 Fortunately as I noted you need not dive into that hole as the 
reasonable choice here is to avoid the asm for MIPS16 code altogether, 
regardless of the GCC bug.

> >  Now if you stick `.set nomips16' just above WSBH, then this code will
> > happily assemble, because this single instruction only (`.set pop' reverts
> > any previous `.set' directives; I'm assuming you wrote above by hand and
> > `.pop' is a typo) will assemble in the regular MIPS instruction mode.  But
> > if this code is ever reached, then the processor will still execute the
> > machine code produced by the assembler from the WSBH instruction in the
> > MIPS16 mode.
> 
> Yes, I hand-copied it from the output of "gcc -S" just to
> show the form/pattern (the original output is too long for
> this conversation).  No, that `.pop' is not a typo (I just
> did a double-check).

 Well, please check again then as there's no such pseudo-op:

$ cat pop.s
	.pop
$ mips-mti-linux-gnu-as -o pop.o pop.s
pop.s: Assembler messages:
pop.s:1: Error: unknown pseudo-op: `.pop'
$ 

> >  No, it's your bug after all.  I think the last paragraph I wrote quoted
> > above combined with the source code in question make it clear what to do.
> 
> Okay, I will try.  Most of the time when textbooks read
> clearly/obviously/apparently, things go astray ;)

 Well, if you really find yourself stuck with it, then come back for 
more hints, however please do try figuring it out yourself first as 
it'll be a good exercise.

  Maciej
