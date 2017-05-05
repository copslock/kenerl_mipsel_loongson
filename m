Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:57:45 +0200 (CEST)
Received: from mail-io0-f194.google.com ([209.85.223.194]:34871 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993935AbdEET5bcWPjp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:57:31 +0200
Received: by mail-io0-f194.google.com with SMTP id v34so3739119iov.2;
        Fri, 05 May 2017 12:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8HQgoRiQqnSDBqglJmOzCwTysv2cmJncsjQeVhbyc6Q=;
        b=GpcqSdOIXy6TiEVjEVAQuGzk3SCD3YQ3tAIag6rXUKJ58hh2P+6CFbEuk+ROe50PYP
         1IMoMPOQeXVY3AJHcGhjtVs3rpb/19agh/26o8zw8XUV0Y7JkY4bNm3GSqXoGKnCahmx
         HQ4S7XgHDZnDRRuYdmDd3mVXxzSc+ys5eBxWRvDp7TfQl/is5hi0rgt9Ib5Wor0+w4dl
         j0vNoyCx1u67qlJ3AqDMjv93dkTcijluLo/dJo/szIh8PMUyxuoCJTAvG6hU7HoMerpc
         LkD5xvZsJ6HCssiYJVI7aZ4rrZQ9rvPR0wM6fsO354Vb3ReyVteFeVN4S50aJX46Wf/F
         ubeg==
X-Gm-Message-State: AODbwcBVZIJkrDT/rYHc1kJS2y98J5sw9+BJaDxt5sQTS4LntFJNIaJ7
        Ltv+EOzOsSh2rw==
X-Received: by 10.202.173.65 with SMTP id w62mr1687798oie.136.1494014245855;
        Fri, 05 May 2017 12:57:25 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id j34sm3007869ote.8.2017.05.05.12.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 May 2017 12:57:25 -0700 (PDT)
Date:   Fri, 5 May 2017 14:57:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>, james.hogan@imgtec.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 02/14] dt/bindings: Document gpio-ingenic
Message-ID: <20170505195724.mph4uov3vd52hscm@rob-hp-laptop>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
 <20170428200824.10906-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428200824.10906-3-paul@crapouillou.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Apr 28, 2017 at 10:08:12PM +0200, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bindings of the
> gpio-ingenic driver, which handles GPIOs of the Ingenic SoCs
> currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/gpio/ingenic,gpio.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
> 
>  v2: New patch
>  v3: No changes
>  v4: Update for the v4 version of the gpio-ingenic driver
>  v5: Remove gpio-bank-... compatible strings, and add 'reg' property

Acked-by: Rob Herring <robh@kernel.org>
