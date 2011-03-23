Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 21:11:24 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:59816 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491880Ab1CWULW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Mar 2011 21:11:22 +0100
Received: by iwn36 with SMTP id 36so10131388iwn.36
        for <multiple recipients>; Wed, 23 Mar 2011 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=NTLpWG/VauBR+QClOF5QnzLd1LbZ88DcM9SKw1k4IAY=;
        b=oIZCvDP33AGmN8IsuXCc9vvjjL2pDeHe4RGaTKS52hDG3fWar4KKfFVPXyg/pg8rDc
         A4f1tym1TqAhpZemDVdXWzCSqCcaOFjCkjzIgSWXAODpNmtgOsTL6q5ni8PfQYol3Agg
         eAarQKEOsIhJ7Kak00YZLjgRbwyp7rIFKmLio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=TCMZIb+45YdOYjA6D/gUpxP7tmrWurRLOA7ZNfdItcLHxz8mlAe6tZvRdJZnnIG8MB
         cl+Mt/9m6TPFylc6cPMSzjnJJy4KrpvzQAW+3OZEIfL7vGV4IUZlRSrnaFDxckc+FASF
         vv6Ioo2onCm4NiQgW9ZJxfZNbjvKMRmI2hBmc=
MIME-Version: 1.0
Received: by 10.231.210.68 with SMTP id gj4mr7289856ibb.7.1300911075349; Wed,
 23 Mar 2011 13:11:15 -0700 (PDT)
Received: by 10.231.18.204 with HTTP; Wed, 23 Mar 2011 13:11:15 -0700 (PDT)
In-Reply-To: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
        <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
Date:   Wed, 23 Mar 2011 21:11:15 +0100
X-Google-Sender-Auth: vtBjnoqaKMfNyLbx3zxpSl_DoBU
Message-ID: <AANLkTikOJ4ed+ExLs1Okm2iFrE95SmR1809bT43bzm8X@mail.gmail.com>
Subject: Re: [trivial PATCH 1/2] treewide: Fix iomap resource size miscalculations
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.ml.walleij@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips

2011/3/23 Joe Perches <joe@perches.com>:

> Convert off-by-1 r->end - r->start to resource_size(r)
>
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(for ux500)

Yours,
Linus Walleij
