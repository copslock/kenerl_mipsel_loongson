Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 14:35:38 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36347 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007013AbcCVNfdiPz-H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 14:35:33 +0100
Received: by mail-ob0-f172.google.com with SMTP id m7so200450174obh.3
        for <linux-mips@linux-mips.org>; Tue, 22 Mar 2016 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rflGDRAKd1PL9u1Ha4K/NmkcbYTcchQ6s35tZgzBdDQ=;
        b=FpZYV78MlUQHQHznc1Po2zNeJMGe+TZWCNuFHau/qpRgxpRbL9lazLK7gcr+Ty4xAx
         y4p8VPpCoTSUwuW2KNMMoRuLsmKLYt8brgnZTHy0vDSMmcI2m2Qaz7LOdW7z7wVenCFN
         fE2oW2HU4B+UxTS/aIzfUW1CbsI8LhSqiaHOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rflGDRAKd1PL9u1Ha4K/NmkcbYTcchQ6s35tZgzBdDQ=;
        b=G/S++kR8uGKGjnyTKAOQetkY4sbGpVOpWCRGpePSR0mqlfN9dfIEvwI+r680uKqy9r
         Vdd6+NENQ4SSgt4J0XPgH4iDKdUoO4qAjecojXf1q3pGNrrnE0U8DRyiZl/bqcd8IYP0
         0vuNZJ55qNLamiKB39+XKpc6ksIn4kdNJgACpVSsuNr7XkUyFkr8dZTqwtALH3+L5+Zd
         LXqAPA+zeWgYVRkvyu8/rXpO7h3tzx74dnUNchu1/hRrA2SkHb+0w35cs2QxbJSoTAz1
         1txaNUSe7lFsVwPm0jOn4s4FizkpaivX95RY4F9/48q4I3KN9Lf/yeDUkZUAW2gcKFGv
         QkQA==
X-Gm-Message-State: AD7BkJLkOL7Cak10o0IX8ZleJ8IasdCQPyiYjPfunQqSxkCitkQpuBuldolbeM9n0mbjvA7jtBOtCTZzrKzc9ZEL
MIME-Version: 1.0
X-Received: by 10.60.117.102 with SMTP id kd6mr20407566oeb.73.1458653727579;
 Tue, 22 Mar 2016 06:35:27 -0700 (PDT)
Received: by 10.182.55.105 with HTTP; Tue, 22 Mar 2016 06:35:27 -0700 (PDT)
In-Reply-To: <1458306316.17098.0.camel@ingics.com>
References: <1458306316.17098.0.camel@ingics.com>
Date:   Tue, 22 Mar 2016 14:35:27 +0100
Message-ID: <CACRpkdYV9zZLDxyy_v1CG=Yv75uEceUOVgdkhzK2Td9v+B8R4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: octeon: Convert to use devm_ioremap_resource
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     David Daney <david.daney@cavium.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Mar 18, 2016 at 2:05 PM, Axel Lin <axel.lin@ingics.com> wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Patch applied for v4.7.

Yours,
Linus Walleij
