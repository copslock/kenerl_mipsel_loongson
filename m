Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 07:39:48 +0100 (CET)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36416 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbcJaGjkz80UV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 07:39:40 +0100
Received: by mail-oi0-f65.google.com with SMTP id 128so2478595oih.3;
        Sun, 30 Oct 2016 23:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQwDdKXLtbXHkM3vmXmTX0V09lrpYv7FYoOQ1tUscfU=;
        b=iizRCRFVlzI2aIYb/StZsk0pUjRGaG3lNxa9JVbBUwwkbFwBfix4FKTKDMmOnSUMgU
         yL7OI3UWJLTtBJhvvEE4oC7jY/6wqaad0+75/jSiuBnyQx3nj04TcrqLUg4oubpfJZNj
         yvIY2Jx4FM1ODlbp4VJ+VSkt+oLd8UH7DQgaZQx1n9RubzuZWStmqX0zv8iXXbeXnzmu
         cCFwmvJsR5crwuj4OimvDzNGEbYKIGB9b63PwnZEilaiSNxkyl4CgOX0xlHXO8qzFeu/
         0qMcIsZ2mMPaXJMIYceIuhSER7bJyYI8gq+sdhIO+jTdjHCXBs230g7sTcC/d1uNpekH
         cWTA==
X-Gm-Message-State: ABUngvfdtycpSLIUxOGj26fwCbd5oqOTWTlzvJFz25mDU/V9rMDUsVCwro6jxdwMB4lQdw==
X-Received: by 10.157.34.106 with SMTP id o97mr20987844ota.134.1477895975103;
        Sun, 30 Oct 2016 23:39:35 -0700 (PDT)
Received: from localhost ([64.134.26.173])
        by smtp.gmail.com with ESMTPSA id r126sm8179646oib.27.2016.10.30.23.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Oct 2016 23:39:34 -0700 (PDT)
Date:   Mon, 31 Oct 2016 01:39:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/7] Documentation: dt: Add binding info for
 jz4740-rtc driver
Message-ID: <20161031063933.wvsby4tgdbgc7zrp@rob-hp-laptop>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161030230247.20538-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161030230247.20538-3-paul@crapouillou.net>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55605
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

On Mon, Oct 31, 2016 at 12:02:42AM +0100, Paul Cercueil wrote:
> This commit adds documentation for the device-tree bindings of the
> jz4740-rtc driver, which supports the RTC unit present in the JZ4740 and
> JZ4780 SoCs from Ingenic.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> 
> v2:
> - Remove 'interrupt-parent' of the list of required properties
> - Add the -msec suffix for the DT entries that represent time

Sorry, I told you the wrong suffix. It should be '-ms' as documented in 
.../bindings/property-units.txt. I never can remember which is why I 
wrote the doc to begin with. With that fix,

Acked-by: Rob Herring <robh@kernel.org>
