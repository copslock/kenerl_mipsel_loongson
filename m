Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Dec 2017 13:56:05 +0100 (CET)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:39355
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdL2Mz6hLCSp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Dec 2017 13:55:58 +0100
Received: by mail-wm0-x244.google.com with SMTP id i11so47910879wmf.4
        for <linux-mips@linux-mips.org>; Fri, 29 Dec 2017 04:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GFviqF0zzvs+36TnCQahdF5QAd+zwKccDL5GJhIz96g=;
        b=UnBIRCu8WFigK+XYLhc3f1sZQHszLYXX16Z6fVOcdpl7s+/YNOe/9xuONi8ZPQhRkh
         KcdXog5IuN1+b6udzZ2eLMkI2TtZDGPZ1gNtng8Krf4VvG+aWwM7eNkw7QCxhFoNIolb
         b7mTtih+/lnL+z8FrbkgVy985DK83pxXrEtvNswK95GtWwjxlWhuLbi5HWaB+kGxH1WM
         bqiUOsNtJCb5aVMj/tg5PaHB7+Z4jK0QVoZl2twHEXqaPOONgSMtnGu4x6hXDigRT82d
         CBzSzr5qauK0u6OntxtxvvO7coou+GaUxBDjXlZzini59R27GGLlZBnbqK7U8uRelWCr
         TLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GFviqF0zzvs+36TnCQahdF5QAd+zwKccDL5GJhIz96g=;
        b=qVoA1RRuJWJgvRs1Ew1pfkZE/eNBo9vvNUuR0hnL5sse+G4SBWxXtvCClVqsdhBI+N
         hY+FtYiXffjzYL/amHOetVnFHTrd30Q9aVlS/9ikwj/WeW1vOO2/fLbGHOuYEc1+pR0K
         PL1G1cvwY+9p19725fgM2x7WrcK4cFsFjE6aDUPivIFHWN6oOW9edKCcIqjZnyykEeaL
         UILd0EWLXtY0wgYesxdUpiSy/fUvuru6Yq6JrYEJPqTYtU2PD23SlnoVsJVZvVaIfDR9
         M5w+yb5NtgN6Jb0cBTKWnWJ63hnu6c6s+I1C/kUbJN1lHBKgniMPYrbKIB5HLpVH0L13
         peHA==
X-Gm-Message-State: AKGB3mI4lXi3iuh4yMKiQaMWO8exsJlHPFisSc05rnMVioZYGOV0bYGX
        HJFT8mCQ42JLGKIL/x7ouCkvwZr6oQPLf4TgL7x2BQ==
X-Google-Smtp-Source: ACJfBotIHbpwiLgqqAIab3y0WLMWJwLmXKz+uzUfeK4yUMJVRH3Jjdj5sRLNBEJG8B1/mn9VLVp4wfdXrnyr3eLK/hg=
X-Received: by 10.28.26.139 with SMTP id a133mr685837wma.90.1514552153214;
 Fri, 29 Dec 2017 04:55:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.206 with HTTP; Fri, 29 Dec 2017 04:55:12 -0800 (PST)
In-Reply-To: <20171228135634.30000-7-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net> <20171228135634.30000-1-paul@crapouillou.net>
 <20171228135634.30000-7-paul@crapouillou.net>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Fri, 29 Dec 2017 13:55:12 +0100
Message-ID: <CAOFm3uEbEx+HTsOANchqiReuDBa96O0Y-V-igLGWPF-OxQ2jtw@mail.gmail.com>
Subject: Re: [PATCH v4 06/15] clk: Add Ingenic jz4770 CGU driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

Dear Mr Crapouillou-Cercueil-Sir,

On Thu, Dec 28, 2017 at 2:56 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> Add support for the clocks provided by the CGU in the Ingenic JZ4770
> SoC.

<snip>

> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4770-cgu.c
> @@ -0,0 +1,487 @@
> +/*
> + * JZ4770 SoC CGU driver
> + *
> + * Copyright 2017, Paul Cercueil <paul@crapouillou.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 or later
> + * as published by the Free Software Foundation.
> + */

Do you mind using a simpler one-line SPDX identifier instead of this
fine but clearly crapouillish legalese boilerplate? Unless you are
trying to turn the kernel in a legal compendium, of course ;)

This is documented in Thomas doc patches. This would apply to your
entire patch set.
Thank you for your kind consideration!
-- 
Cordially
Philippe Ombredanne
