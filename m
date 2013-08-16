Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Aug 2013 15:14:45 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50841 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831597Ab3HPNOjR450X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Aug 2013 15:14:39 +0200
Received: by mail-oa0-f53.google.com with SMTP id k18so2165504oag.26
        for <linux-mips@linux-mips.org>; Fri, 16 Aug 2013 06:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SYkrjt20bmjYl1+UYKGK0hLU8fDRhPFJ8LjIg4jt3w0=;
        b=HrFe/XToYjbjgvBcFhdqTbqSNJQIolADHGxAywljZKRSQ8akfceJsJGmfu15Zkd1dN
         fbzDPy0qgJOulTUhGs4R96+QbYj6t6Rn71Hiv65DopF9QMOeJB5WRgj30dKOMR/zLL8b
         /PBSb/cEwTC+LdIDjhsoelLFjjeKB8GvwgL+ynUdr0P2Pk5WjcL24nNAhplX8YANu12Y
         KiJG67H2AgYaLEXvsgIoBqcSBpw0TDXYgrfUAxrE8+4oc2cOBYzOVlqo8nRjO1nvdrW8
         mrL3Cr0t4Q7jmC9StLZ/tKfVQiq7BepLS2+FYP3gtgI3xy4eTnhzw0yPeKSMXNqx5HtA
         P5hg==
X-Gm-Message-State: ALoCoQmHRpO0UWoWPDIBwYJ4Zm/UWb1/bs8blKrkG+Ef+v3kHygOCxD6nIG4iOv+HN913kKipO4H
MIME-Version: 1.0
X-Received: by 10.60.80.8 with SMTP id n8mr1272758oex.33.1376658873245; Fri,
 16 Aug 2013 06:14:33 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Fri, 16 Aug 2013 06:14:33 -0700 (PDT)
In-Reply-To: <1375133350-18828-2-git-send-email-ddaney.cavm@gmail.com>
References: <1375133350-18828-1-git-send-email-ddaney.cavm@gmail.com>
        <1375133350-18828-2-git-send-email-ddaney.cavm@gmail.com>
Date:   Fri, 16 Aug 2013 15:14:33 +0200
Message-ID: <CACRpkdZwZyqkjmHmdawyD+mC3bRmgg9Ab_VZp1cPPSGLUfVGMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MIPS: OCTEON: Select ARCH_REQUIRE_GPIOLIB
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Alexandre Courbot <acourbot@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37572
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

On Mon, Jul 29, 2013 at 11:29 PM, David Daney <ddaney.cavm@gmail.com> wrote:

> From: David Daney <david.daney@cavium.com>
>
> ... and create asm/mach-cavium-octeon/gpio.h so that things continue
> to build.
>
> This allows us to use the existing I2C connected GPIO expanders.
>
> Signed-off-by: David Daney <david.daney@cavium.com>

I like the looks of this.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
