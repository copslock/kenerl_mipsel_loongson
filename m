Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 17:24:34 +0200 (CEST)
Received: from mail-it0-f66.google.com ([209.85.214.66]:39060 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990397AbeHMPYaYh9uL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2018 17:24:30 +0200
Received: by mail-it0-f66.google.com with SMTP id g141-v6so14581416ita.4;
        Mon, 13 Aug 2018 08:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocbgtEahqKRjgPeqHg39tIUlKOf/rjKNIllWuWkaAmY=;
        b=kfZr0/dvnEM3U/W58o+CGl2en3VW19faIl9zpeuP4uRtT3C70SVNYK7ZOdT245MKZ/
         d2NJ/euVyzihxBT76JYEw0P6M+V1JUf3QHxVHA6mwlbng5OxczIlhKsTZleZu6ZbBuNA
         6oj4MaQxK8kzvelx2RctHXgd2yQwiJAKxSuZC+71HwdFkPwlrP6u/p22PoX9UEioSoSk
         1KOMHlW0dcYSAAqSGwQt7Y8t9C/CeeGlBT/ZSvM0gUD1bAhBDFofqJQnAjte7BqhSo7P
         mTzUzTceKu38nWh2IAczbZL3ZoKbvQPOjhAMDKZumZfwvQkQ0HgX3CCtV7WQUCeYAVxM
         aE7A==
X-Gm-Message-State: AOUpUlGaX62alm7fEqHpCrCp5Dk9dKdl09cWqRoXLmvR/bafKTAYDw5Q
        0qgLLza/Szj8DudyEJAg+Q==
X-Google-Smtp-Source: AA+uWPxlHcQyHznD8zmn8GUxPhyBYhVH9xhP3V9ni/lNHx4qJsgcE1xoMZ39djlSqaEeC6Qejlx7pQ==
X-Received: by 2002:a24:3c53:: with SMTP id m80-v6mr11034591ita.86.1534173864245;
        Mon, 13 Aug 2018 08:24:24 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 14-v6sm5839462itu.20.2018.08.13.08.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 08:24:23 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:24:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 04/24] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20180813152422.GA18650@rob-hp-laptop>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-5-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65568
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

On Thu, Aug 09, 2018 at 11:43:54PM +0200, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 134 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
>  3 files changed, 134 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

Reviewed-by: Rob Herring <robh@kernel.org>
