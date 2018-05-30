Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 00:37:07 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:37779
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeE3Wg6CWpVQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 00:36:58 +0200
Received: by mail-it0-x244.google.com with SMTP id l6-v6so12257570iti.2
        for <linux-mips@linux-mips.org>; Wed, 30 May 2018 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgm5l5XhYV99nBDdwXztR+m6Mhkyb42YXSSjhwGnFsk=;
        b=pM/BdO6sKD3wfcSv9xvyZ9ZZCh95V7KGyxioXz7TwWqwLU9e34XtChmNbHZG4qdisG
         iKZCcD28oylehJumuvOJHI+idt/AL8JhGroW1BAiwQg9UB3e3wEwrkf6pIzOK+C+yBGA
         +ZakEAKiu3s5sZ1tD9ZhIe3pc8AsH6fazt0wGLIbSkoBf2gv4gPLfOuN/hYSAi3tzbCD
         VtKbVlzSP73VtTYMnaWNjmQmGnd/4O9HJ7ZBAvGSCtQQpErdiT6O5jw05WuhEbp28MJZ
         rbfk2fAQX2+aoTyKoPVWZCT7bXF7bjLcl9iTeoA2pSomumRaEw6MWhJxgdANM5jhlB+x
         S++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgm5l5XhYV99nBDdwXztR+m6Mhkyb42YXSSjhwGnFsk=;
        b=b4ib881eImu/pKZt54zEHdjxzCTcTfKoQJZ36r7xelKJ5K1xyrdFUmDhWokHNb0MS+
         xkywYGYoB+NTh8kHFLBUa4t4ZKUhV+ynXp1vToc5EzQCYnKAKCCiGZFnE/jn5EJ0fQA3
         kDRCmXo7RJU9ZXoHUSVAA9YhORce+kj0U829wvEX2P3z+Fd4SN/4y5e2uy9oM9LqHsRw
         ZvdhLC48N25SoZ42IhHJNYtu+vnAW/Zkk7OrgdgkErhToH78tVX4TimP1VyhldxkUSZb
         RSJ/hRYy/0gafyisRswY6G1SfMje0v1P8O2Qgz26Vbp1s4/t6jWbXqNCYGcZ09EBv+VF
         xSlQ==
X-Gm-Message-State: APt69E2dxVYHOscvtC+T2PGmu2xZziUGvmyTiEyjlF1YnQDOFdE5hGhz
        I2FwnzqEFGPVJ/HJ6Rr9qCreKw==
X-Google-Smtp-Source: ADUXVKKL8KfewnOAAaPiSaT9j8mPkM1Sf02VY3aYpFYjh1dPKTxxwV5/dXfK4M96twS9wQWUsreK8w==
X-Received: by 2002:a24:74d2:: with SMTP id o201-v6mr3708611itc.151.1527719811744;
        Wed, 30 May 2018 15:36:51 -0700 (PDT)
Received: from [192.168.42.193] ([172.58.142.210])
        by smtp.googlemail.com with ESMTPSA id 131-v6sm7194917itv.29.2018.05.30.15.36.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 15:36:50 -0700 (PDT)
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
 <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <0dd9d6dc-6cb3-157c-33ac-8c3e449a3859@landley.net>
Date:   Wed, 30 May 2018 17:36:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 05/30/2018 05:00 PM, Andreas Färber wrote:
> What about the architectures not touched by your patch that previously
> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)
> 
> You forgot to CC them on this patch.

A) He cc'd arch/sh on the previous patch earlier today, to which I replied:

https://marc.info/?l=linux-sh&m=152769132515226&w=2

B) Every change to common infrastructure should cc: every arch? Really? So like
filesystem changes and stuff to?

> Have you really checked that all their toolchains support the -m32/-m64
> flags you newly introduce for them? Apart from non-biarch architectures,
> I'm thinking of 31-bit s390 as a corner case where !64 != 32.

1) Last I heard Linux implements lp64:
   http://www.unix.org/whitepapers/64bit.html

2) it's unlikely to be worse than it was before the patch,

3) last I checked https://github.com/landley/mkroot boots to an s390 shell
prompt under qemu, although I haven't tried building with this patch. (And you
may still need to add HOST_EXTRA='lex yacc bison flex' to the command line
unless they've re-added the _shipped versions like the old kconfig had...) Point
is, shouldn't be too hard to test it. Presumably that's why we have an -rc1 and
then 6 more -rc versions each release...

Rob
