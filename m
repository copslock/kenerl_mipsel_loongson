Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2016 19:51:16 +0200 (CEST)
Received: from mail-io0-f193.google.com ([209.85.223.193]:35790 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027725AbcD1RvMZ3Icr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Apr 2016 19:51:12 +0200
Received: by mail-io0-f193.google.com with SMTP id u185so14574722iod.2;
        Thu, 28 Apr 2016 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=IDC/Z2juvUxpC8A8fbWJYtyZOgEhS6AAXHTmxvSBt4Y=;
        b=DBFZdmBcf1VoR2mhZ8Z/KWS0p3iFp/YwbkUPJnPXYbNZhXnuTzVFAHjLRWXN9DfE7d
         lBV0jWnGrS4IhoWzwFnnrFLHsawGSXlGbr/FJjWmvBRYQdZZBT3XiGk6jmVyjZPq3NL9
         gl3XqRLLJmbx2TqCktjTyjRmlvNKUOB2ILugmmnX5Ceal/jy/xRXczZqR6laoMfpoHBb
         ETRaLzPkxtm2dlVB4GcTfpT0ErGyHXlRJFq9ZeS75Y555sj6yvt20fcxnLayBfZHQ52E
         W9LK0QCy9pSsSbLtLCdK0GMDaEpcqwR2eZh3x6wU1TzndHOjuRFvrqPEukMkrZK3X1di
         vCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IDC/Z2juvUxpC8A8fbWJYtyZOgEhS6AAXHTmxvSBt4Y=;
        b=OlpFmXSKTopxxaUdDdLaS5dyuWBCxdJGA1fUbbk8FOmHAwu8oz3fQuKOcKZrmRVIHe
         lWlZrIQyn0Kl964ehihctP09mdoe+cg5v+Afwn4ZOJAvRt9nq7hwcfeBkZxScA+jGCFm
         EJ/MHS+gcStpf7l/Do8GmQgv7WrhdBBCUMMVLaD2RBXIgYvyq1dokMeYSlHvKWNZtB2S
         +ygGdJeeVtwBlsZWmrHzedu+wG1KO9+6gzvtII/ZNAA5sMpnCL8GsJOTkGFOznGjlxcf
         5iY5vYBNEylW6eKBBBnh/bMBYwQlxTPX911WsuYnv3grYBAwjLGn28Y3kN79p7NYEacQ
         SF4g==
X-Gm-Message-State: AOPr4FXVQ0zF4AZ5HrjCVYwPTKvxoeecKAibeTZAhnWlUR9NAC+sWCSXC0RDwPf7qfyYw2XYLJKdMH67QhE79A==
MIME-Version: 1.0
X-Received: by 10.107.191.2 with SMTP id p2mr21655052iof.115.1461865866451;
 Thu, 28 Apr 2016 10:51:06 -0700 (PDT)
Received: by 10.107.31.77 with HTTP; Thu, 28 Apr 2016 10:51:06 -0700 (PDT)
In-Reply-To: <20160428164856.10120.qmail@ns.horizon.com>
References: <1461843824-19853-1-git-send-email-zengzhaoxiu@163.com>
        <20160428164856.10120.qmail@ns.horizon.com>
Date:   Thu, 28 Apr 2016 19:51:06 +0200
X-Google-Sender-Auth: im7Zsx5sgIB7Y02nUoEY_ItH_wA
Message-ID: <CAMuHMdU2e2PdwKYVaEsJ73X8Di1XHNPqnxuunr8R8bN8udazxw@mail.gmail.com>
Subject: Re: [patch V3] lib: GCD: add binary GCD algorithm
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     George Spelvin <linux@horizon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, zengzhaoxiu@163.com,
        Rich Felker <dalias@libc.org>,
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
X-archive-position: 53249
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

On Thu, Apr 28, 2016 at 6:48 PM, George Spelvin <linux@horizon.com> wrote:
> Another few comments:
>
> 1. Would ARCH_HAS_FAST_FFS involve fewer changes than CPU_NO_EFFICIENT_FFS?

No, as you want to _disable_ ARCH_HAS_FAST_FFS / _enable_
CPU_NO_EFFICIENT_FFS as soon as you're enabling support for a
CPU that doesn't support it.

Logical OR is easier in both the Kconfig and C preprocessor languages
than logical NAND.

E.g. in Kconfig, a CPU core not supporting it can just select
CPU_NO_EFFICIENT_FFS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
