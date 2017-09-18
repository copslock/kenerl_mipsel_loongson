Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Sep 2017 10:36:46 +0200 (CEST)
Received: from mail-wr0-x234.google.com ([IPv6:2a00:1450:400c:c0c::234]:50051
        "EHLO mail-wr0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992800AbdIRIgiUM2kQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Sep 2017 10:36:38 +0200
Received: by mail-wr0-x234.google.com with SMTP id u96so5541699wrb.6
        for <linux-mips@linux-mips.org>; Mon, 18 Sep 2017 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HstyGEfXQC8OQ5uowO99SVT9LXS5lGU+bP+avqJvkho=;
        b=JLZhB2E+sOXsJEOZKeJ2VeRIjnmOq2axVAZGsRknBM8gppVHBtufqA2QM5WDbnM5Z5
         rWoeVRHsYty+07EU956A6zOA+uSPocIqVm+FHJEKLx9/hKgkWkLq06/18qbcJRyzX1X/
         JgKTu6HxK2+mfISL3yAWipl9pOWYomM8gcWu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HstyGEfXQC8OQ5uowO99SVT9LXS5lGU+bP+avqJvkho=;
        b=qEZHeH+fsUa2naajC1ySZd1r13QLoEuuk00OZLNrR3VlIMNQ8CErlT46mRRyG563xL
         Sytl27Ys1EuLA+sdk3AERo4RnJd0TSBo5uM4byegDIStgoW/oCyWeyxHlVJHmjK5YzHG
         RhqfkAgsb+saQZPyh8EJS3boEQ32gf4qKAc58fkOeRKeUzvf1OGnRj+8OQuSlpGKig2l
         BeoRmN2wgW6Ceb3xEDBEpu0ngxA2UdVq/wkYcc4ME2SugVyj34aj86vQ4DW300sDtgwu
         vj2zgfhk++kvSEct/BWocodFpOGPEeqXzMkmIw1kHni3mx2F1eNxwbNqQzB5kaGOEL1f
         JvEQ==
X-Gm-Message-State: AHPjjUj80GSBM7R+ShKxUbBS2istHigU17evrRCVf6sCO/ERiieAlbkw
        9p6WQsKNfiLJcy9r
X-Google-Smtp-Source: ADKCNb46KVzRCH0ZDlSgOoPdhuC0HUFD1XIZsZpQKX3DWKHyrmgXK0HYvEkj/8vHbwf/jHf5SZ2IFQ==
X-Received: by 10.223.195.144 with SMTP id p16mr30841274wrf.123.1505723792017;
        Mon, 18 Sep 2017 01:36:32 -0700 (PDT)
Received: from dell ([2.27.167.120])
        by smtp.gmail.com with ESMTPSA id f5sm4929078wmg.10.2017.09.18.01.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Sep 2017 01:36:31 -0700 (PDT)
Date:   Mon, 18 Sep 2017 09:36:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/7] i2c: gpio: Convert to use descriptors
Message-ID: <20170918083629.qn4dlrmk7ffipfsz@dell>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170917093906.16325-2-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Sun, 17 Sep 2017, Linus Walleij wrote:

> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:

[STUFF]

> - The MFD Silicon Motion SM501 is a special case. It dynamically
>   spawns an I2C bus off the MFD using sm501_create_subdev().
>   We use an approach to dynamically create a machine descriptor
>   table and attach this to the "SM501-LOW" or "SM501-HIGH"
>   gpiochip. We use chip-local offsets to grab the right lines.
>   We can get rid of two local static inline helpers as part
>   of this refactoring.
> 
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Heiko Schocher <hs@denx.de>
> Acked-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix a minor typo in error path (scl was sda from copy-paste)
> - Collected Olof's ACK
> 
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.

This ...

> SM501 users: requesting Tested-by on this patch.

... loosely depends on this (until it doesn't).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
