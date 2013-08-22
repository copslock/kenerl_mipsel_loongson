Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Aug 2013 14:58:40 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:59658 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6852083Ab3HVM6dV60C4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Aug 2013 14:58:33 +0200
Received: by mail-pb0-f54.google.com with SMTP id ro12so1744613pbb.27
        for <multiple recipients>; Thu, 22 Aug 2013 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Hd3ZWeSO3/h2wYrAhVkpXIuKn5pyqCiksb9+3plKf+o=;
        b=WjWO3mG6RO7+QyXfRn4QC/QEW5DDFPdMNhSJnt7auD3AWj53ETCnm6vfJYj5fczMhK
         VMbyonzUbtrs7vyR5tSoW3ZhI96SsrGvTLciaDfthDWzcJ01ntq06P2FDX9uUSv/ocG0
         rx+MnRNfMaKeSgZtvHQWXfZ6rPCCJq+cPI3OPI0zVTaHXy8BqVz2EA312FQzzE1WTd2/
         OQNyTXllYF7yeBnGMu6QxZNORe2DkP/v7dxx/T1JxWORKsYTTu0cL5j5xoHHNuvfG9tj
         F9MRU0RwpNBH0X4Y+uMF8DFXls7Q3e1LcEZe8R4Qpg7W4NtP06Aj7ySE+KoJyyht7054
         X5HA==
MIME-Version: 1.0
X-Received: by 10.66.192.132 with SMTP id hg4mr5405323pac.84.1377176306237;
 Thu, 22 Aug 2013 05:58:26 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Thu, 22 Aug 2013 05:58:26 -0700 (PDT)
In-Reply-To: <20130821195157.GA18191@merkur.ravnborg.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
        <CAMuHMdWk-EPTNmPB1O1+F7YVQLjhQsFJznYwA3t6UCGUU1T9PQ@mail.gmail.com>
        <20130821195157.GA18191@merkur.ravnborg.org>
Date:   Thu, 22 Aug 2013 14:58:26 +0200
X-Google-Sender-Auth: DQd6oaOmPgxqVsLie5zKrdlpX8o
Message-ID: <CAMuHMdWqwQxxky7UDnh-oxN13C-sxfnxKVBuBz1GU_RtJvbf3A@mail.gmail.com>
Subject: Re: [RFC] Get rid of SUBARCH
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Michal Marek <mmarek@suse.cz>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37643
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

On Wed, Aug 21, 2013 at 9:51 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>> > The series touches also m68k, sh, mips and unicore32.
>> > These architectures magically select a cross compiler if ARCH != SUBARCH.
>> > Do really need that behavior?
>>
>> This does remove functionality.
>> It allows to build a kernel using e.g. "make ARCH=m68k".
>>
>> Perhaps this can be moved to generic code? Most (not all!) cross-toolchains
>> are called $ARCH-{unknown-,}linux{,-gnu}.
>> Exceptions are e.g. am33_2.0-linux and bfin-uclinux.
>
> Today you can specify CROSS_COMPILE in Kconfig.
> With this we should be able to remove these hacks.

The correct CROSS_COMPILE value depends on the host environment, not
on the target configuration.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
