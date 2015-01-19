Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:13:33 +0100 (CET)
Received: from mail-la0-f54.google.com ([209.85.215.54]:60208 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASTNbNUFlj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 20:13:31 +0100
Received: by mail-la0-f54.google.com with SMTP id pv20so30477838lab.13;
        Mon, 19 Jan 2015 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MAe22jmegcQi+lV07TkXrcazbNxAWKeXU043U1AUsnE=;
        b=f/UgoD2B4NrfBR4TdTA79c/1ItKull/G7XYw3aQATpT+mp0CfK2iPQvmXs7oSQDK5T
         aDeIvkhu/6c+ZQGVJh5BgAujCZS4GzPdIFDaT2eBI7pKFvf4JeCfLhVlfbt5bEg+eISh
         ENYbr/LFTS/Ixndcj2hZd7ZgWRAhEmSsG20pr+JZua2SaGhRdMRnNrfk+LasK25iM5qt
         /a6B1+7NZYxYLel7J/o0ZLqu2dXJtseNaUp02J3NH11ZBwLE5LD/65mtHoZj4fdff6zt
         uBo008poMmEe/+4R8EiMl7zV7IsFZUfJnuov3ysbg5ZjTs321CKWy7BqmG+fa+ZzlNoB
         V5cA==
MIME-Version: 1.0
X-Received: by 10.152.8.82 with SMTP id p18mr25219484laa.25.1421694805858;
 Mon, 19 Jan 2015 11:13:25 -0800 (PST)
Received: by 10.152.106.178 with HTTP; Mon, 19 Jan 2015 11:13:25 -0800 (PST)
In-Reply-To: <CAMuHMdXMsxhcD9C079YPc6Toxdo0e23oqM_9KeSG=NrFa4auRQ@mail.gmail.com>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
        <1415342669-30640-2-git-send-email-cernekee@gmail.com>
        <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
        <20141114163843.GH29662@linux-mips.org>
        <20141114170525.GL3698@titan.lakedaemon.net>
        <CAMuHMdXMsxhcD9C079YPc6Toxdo0e23oqM_9KeSG=NrFa4auRQ@mail.gmail.com>
Date:   Mon, 19 Jan 2015 20:13:25 +0100
X-Google-Sender-Auth: juuyVqQ0_k8Qs29_xQE0a7KeXiA
Message-ID: <CAMuHMdUpxURV4ztpa3x0TORsSWtxiKxe6_EDO5QsO_vhedip0A@mail.gmail.com>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel} accessors
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jason Cooper <jason@lakedaemon.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45327
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

Hi Jason,

On Sun, Nov 16, 2014 at 10:34 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Jason,
>
> On Fri, Nov 14, 2014 at 6:05 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>> On Fri, Nov 14, 2014 at 05:38:44PM +0100, Ralf Baechle wrote:
>>> On Mon, Nov 10, 2014 at 09:13:49AM +0100, Geert Uytterhoeven wrote:
>>>
>>> > On Fri, Nov 7, 2014 at 7:44 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>>> > > Defining these macros way down in arch/sh/.../irq.c doesn't cause
>>> > > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
>>> > > has no effect.
>>> > >
>>> > > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>> >
>>> > Compared preprocessor and asm output before and after, no difference
>>> > except for line numbers, so
>>> >
>>> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>
>>> I noticed the remainder of of this series is now in Jason Cooper's irqchip
>>> tree.  Is anybody still taking care of SH?  If not I can funnel it
>>> through the MIPS tree.
>>
>> Are the SH maintainers active?  I admit I know very little about the
>> arch.  I'm more than happy to pick it up and keep it with the rest of
>> the series, I just didn't want to step on toes...
>
> SH is orphaned, so it would be great if you could pick it up.
> Thanks!

I think you forgot to pick it up, as se7343 and se7722 are still broken:

http://kisskb.ellerman.id.au/kisskb/buildresult/12346740/
http://kisskb.ellerman.id.au/kisskb/buildresult/12346745/

Will you still do so, or shall I forward the patch to Andrew Morton?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
