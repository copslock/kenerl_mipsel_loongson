Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2015 15:22:23 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34303 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011549AbbHUNWWBXI01 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Aug 2015 15:22:22 +0200
Received: by lbbtg9 with SMTP id tg9so43705980lbb.1;
        Fri, 21 Aug 2015 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=pJ8RWNC4zgfw68BJrXKU7bw9PzaYLvKX/wq+KG22U6A=;
        b=zjeqF4Whz7D0t5+AjUZncmDdkw8sVsvSqv8xtpOKkX/NjLCXvc9+NkYhZgB04pzuiv
         ClWZrpYOzj1W9ROn65Kdc8wk2xr86HtErnwYgaO+ORowAJprnty7T6HDfKDV+3Qg/Wky
         G2kGwUSHvL8bv1KgdZ5oUApShuv7U9U3MPZancZzpEgWI0nn50eIxTMytkZRccJPmLFK
         np6X+HVghuepzsgu5sJRZfww1WbRfifboILk0llibF/NYM1x/WrAxnaidnlUxC0ep7nt
         kP+nPMkyiFgWB6bAh9Ezz9ftTqRDw/J0H9/PlO4kNLrLQxyGXNQY5a2Zoaq6e+vqie/1
         ZyqQ==
X-Received: by 10.152.120.74 with SMTP id la10mr7665987lab.37.1440163334931;
 Fri, 21 Aug 2015 06:22:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.198.212 with HTTP; Fri, 21 Aug 2015 06:21:45 -0700 (PDT)
In-Reply-To: <CAD3Xx4+C1H+8AaLXbBLOKuKNysdjge0W0pxVkuLti8zE=gNdTA@mail.gmail.com>
References: <CAD3Xx4+C1H+8AaLXbBLOKuKNysdjge0W0pxVkuLti8zE=gNdTA@mail.gmail.com>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Fri, 21 Aug 2015 15:21:45 +0200
Message-ID: <CAD3Xx4JvLHuxSVAcnJe2CXnxEU1vL8y0QxzAtXf=tVNa8RcLHA@mail.gmail.com>
Subject: Re: mips: MT: ptrace.c: undefined MIPS_MT_SMTC
To:     ralf@linux-mips.org, Paul Bolle <pebolle@tiscali.nl>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andreas Ruprecht <andreas.ruprecht@fau.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48979
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

On Fri, Jul 31, 2015 at 8:42 PM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> Hi Ralf,
>
> your commit 23c59ee7e541 ("MIPS: Add uprobes support.") is in today's
> linux-next tree (i.e., next-20150731) and it adds the following lines
> of code to arch/mips/kernel/ptrace.c:
>
> +#ifdef CONFIG_MIPS_MT_SMTC
> +       REG_OFFSET_NAME(c0_tcstatus, cp0_tcstatus),
> +#endif
>
> The Kconfig option MIPS_MT_SMTC has been removed by commit
> b633648c5ad3 ("MIPS: MT: Remove SMTC support") so that the upper
> #ifdef block cannot be compiled.  Is this intentional or can the block
> be removed or should the option be substituted to something else?
>
> I detected the issue with scripts/checkkconfigsymbols.py.
>
> Kind regards,
>  Valentin

Ping.
