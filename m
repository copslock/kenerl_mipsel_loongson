Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2017 16:49:07 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33228 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdDDOs7wjgMp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2017 16:48:59 +0200
Received: by mail-oi0-f68.google.com with SMTP id f193so25131579oib.0;
        Tue, 04 Apr 2017 07:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2NLT1Clw/XCeDN8eH+uwRj8pjCbFvhMlM/VlM7y3pw=;
        b=ossuPSOT+uo7A4zEqODLQtz/FcnKE1LISKHtK2Xkd98HfbKXfw2v0Ax5lCYTH//FpI
         2zhJWptNFiEHc3os6CjOXKTvSanBVSMUrl4lZBdo45EOnQG3ySMUbYn7vIi7NucIjN8L
         7pQrIqBUgX0Bw34zhsI5q9Kd0kQouExSbmLvN9rSCkH3Ohz9oef//PSceArcgW7gxYpy
         SvS6DMHdWgP33a3LGiAXmSc4OlyI9t63Cjf3sKpK+ksdOv3q7a0UWCKLX9Q+/VgFcQO9
         rA5NjYAN1O5aKQIAlp4zWkQuvwBQJawh4ZZtnTJYWuNPKS62pqbdAj9z7Sq187W6dHzf
         UDJw==
X-Gm-Message-State: AFeK/H2TfjAsazuvcEnGByU1ZXbsDMRCd8tMi1oNWxJJ5MiqS1wKRkccQv//YwYBTlJOkA==
X-Received: by 10.157.23.199 with SMTP id j65mr7909925otj.115.1491317332846;
        Tue, 04 Apr 2017 07:48:52 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id r7sm8341158oih.7.2017.04.04.07.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Apr 2017 07:48:52 -0700 (PDT)
Date:   Tue, 4 Apr 2017 09:48:51 -0500
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
Subject: Re: [PATCH v4 01/14] dt/bindings: Document pinctrl-ingenic
Message-ID: <20170404144851.s53lj3hfdu5mjlx5@rob-hp-laptop>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170402204244.14216-2-paul@crapouillou.net>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57559
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

On Sun, Apr 02, 2017 at 10:42:31PM +0200, Paul Cercueil wrote:
> This commit adds documentation for the devicetree bindings of the
> pinctrl-ingenic driver, which handles pin configuration and pin
> muxing of the Ingenic SoCs currently supported by the Linux kernel.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/pinctrl/ingenic,pinctrl.txt           | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt

Acked-by: Rob Herring <robh@kernel.org>
