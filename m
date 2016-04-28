Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 20:11:42 +0200 (CEST)
Received: from mail-io0-f196.google.com ([209.85.223.196]:36366 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027719AbcD1SLissnbr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 20:11:38 +0200
Received: by mail-io0-f196.google.com with SMTP id k129so13014479iof.3;
        Thu, 28 Apr 2016 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=aQDScg3gUCk/Fwdsf7l8Mx4U6pRj2Jt6KhME608opWg=;
        b=ax6Oun+4EBon+SGU80Cf2shjvILFkpeyeQZcErrMo9kQ19GqohMRkJ0bkJ7x2M5QnH
         Drm35hlifQ9AU3yY0mqCO+PmuA6Kv84tqgEnf/kMMXy1s5uGPChlM1WTyliwJToN3/kW
         her9dZzopxykctwkl9FTh2B292V5ORm6LygkEwFUSGNInwhz0I+j64nMnsuMuEMGKPJN
         YFT6rvnyFKWkUu2aXn5ayfbKYcK0pQaCXcy5oMrl97vjCb7zwuxq64yW3HP7oAUeuX7G
         3u368mdOs0vqSLOE8ZhyfoFq/ynxXhRgtyLshQfXSoi9Q/5pl9dRdaxvG7UE349oy08s
         Z/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=aQDScg3gUCk/Fwdsf7l8Mx4U6pRj2Jt6KhME608opWg=;
        b=kqqmZJULwny6d1TjqhpAzn792QIxYcwpN4qSz3+SNRG3HovJPJDqOF08DcsB74UwZM
         r5dzmBDkUXAVGe7We42kJS2cJjEzzhjQfS+hlO1zCgdlBd3/Q4CzygslOrxmhyiyuqqq
         WMvjR1RXhBvBeMqqy6EoWpNn8qWCdFzDMmgqCLEXQYqL/tBJxLo349VGoZKd3zFF6UkD
         ZpV0hVrPx1j5BGlwzpvKb16FDJWVCk+urM0kzYIwnzLhMhHXPtmGBQQ23lAsNVjcRUJG
         19yisUQbMGWZpvxzThUZaVLvHOKRST+FpVbOmG9KIZwUddG7dUCnMigZppKBCuVIKZFs
         uq8A==
X-Gm-Message-State: AOPr4FUh9j8xLiMcmsvMgpkMZmQFdFoarjlDdASKJG46MuUlejp23DB7JP1TWeZXi+B0rO0wvNBXwRUuhweFPQ==
MIME-Version: 1.0
X-Received: by 10.107.191.2 with SMTP id p2mr21780105iof.115.1461867093196;
 Thu, 28 Apr 2016 11:11:33 -0700 (PDT)
Received: by 10.107.31.77 with HTTP; Thu, 28 Apr 2016 11:11:32 -0700 (PDT)
In-Reply-To: <20160428175843.GZ21636@brightrain.aerifal.cx>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
        <20160428164856.10120.qmail@ns.horizon.com>
        <CAMuHMdU2e2PdwKYVaEsJ73X8Di1XHNPqnxuunr8R8bN8udazxw@mail.gmail.com>
        <20160428175843.GZ21636@brightrain.aerifal.cx>
Date:   Thu, 28 Apr 2016 20:11:32 +0200
X-Google-Sender-Auth: aTRi6KVGPiXYVDG8MkNjxNydI9U
Message-ID: <CAMuHMdUBWqdyS4w7EKsnvQLXJVgQh624AQsjgQvxT9FRW4s_6g@mail.gmail.com>
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rich Felker <dalias@libc.org>
Cc:     George Spelvin <linux@horizon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, zengzhaoxiu@163.com,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Hogan <james.hogan@imgtec.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Jonas Bonn <jonas@southpole.se>,
        Lennox Wu <lennox.wu@gmail.com>,
        Ley Foon Tan <lftan@altera.com>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        linux <linux@lists.openrisc.net>,
        Chen Liqin <liqin.linux@gmail.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        nios2-dev@lists.rocketboards.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        zhaoxiu.zeng@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Thu, Apr 28, 2016 at 7:58 PM, Rich Felker <dalias@libc.org> wrote:
> On Thu, Apr 28, 2016 at 07:51:06PM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 28, 2016 at 6:48 PM, George Spelvin <linux@horizon.com> wrote:
>> > Another few comments:
>> >
>> > 1. Would ARCH_HAS_FAST_FFS involve fewer changes than CPU_NO_EFFICIENT_FFS?
>>
>> No, as you want to _disable_ ARCH_HAS_FAST_FFS / _enable_
>> CPU_NO_EFFICIENT_FFS as soon as you're enabling support for a
>> CPU that doesn't support it.
>>
>> Logical OR is easier in both the Kconfig and C preprocessor languages
>> than logical NAND.
>>
>> E.g. in Kconfig, a CPU core not supporting it can just select
>> CPU_NO_EFFICIENT_FFS.
>
> How does a CPU lack an efficient ffs/ctz anyway? There are all sorts
> of ways to implement it without a native insn, some of which are
> almost or just as fast as the native insn on cpus that have the
> latter. On anything with a fast multiply, the de Bruijn sequence
> approach is near-optimal, and otherwise one of the binary-search type
> approaches (possibly branchless) can be used. If the compiler doesn't
> generate an appropriate one for __builtin_ctz, that's arguably a
> compiler bug.

m68k-linux-gcc 4.6.3 generates:

        jsr __ctzsi2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
