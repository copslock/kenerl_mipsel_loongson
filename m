Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 00:21:01 +0200 (CEST)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36741 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdFHWUy0yXGQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 00:20:54 +0200
Received: by mail-ot0-f196.google.com with SMTP id i31so4633491ota.3;
        Thu, 08 Jun 2017 15:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zqft25m9JRUlYRhy+VhPxCtLDjLjxAnFplrBAv3P2FA=;
        b=qFlG/VKAEpmSgtjvI9dltE96M6zdEN1CCZBiWfdr+HdTiFKqhqJ3shGBO+Vafp7ji3
         gr5S9te3AcSgk+sJLsA0NaiOagyQnbaY/oG86BK/S32h7XDlwq7lOkF1cDUr6F/xkmDS
         NL6LFl307y9qP61vXp0Lbd2znF6x+QAnUDLX4xBLN0IpFZ/Q/58zSo17GdlX0oekCI9+
         FgQMIqmAAr2VKUCIMEfncKVJCZJVwt/gH2vXvzlOAFomCRVUv7SaP1r2/1mv0KTrfG+1
         /ajEBTZCot4bdy78iN3P+a2iUWmCexCfTLVL79zTgu/dl1uBZBDbbryOZ/Vw/bXxd6II
         sGlg==
X-Gm-Message-State: AODbwcDCX5dQjprTvbtwB+PYNlrTap7gLLfoXjsv+MZ5zCYfrZ6mVdEv
        aHV55QwsKfHbGw==
X-Received: by 10.157.22.208 with SMTP id s16mr10319267ots.81.1496960448594;
        Thu, 08 Jun 2017 15:20:48 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id 93sm3307272ots.28.2017.06.08.15.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Jun 2017 15:20:48 -0700 (PDT)
Date:   Thu, 8 Jun 2017 17:20:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: Document img,boston-clock binding
Message-ID: <20170608222047.c27en4hqbqkqybin@rob-hp-laptop>
References: <20170602182003.16269-1-paul.burton@imgtec.com>
 <20170602182003.16269-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602182003.16269-2-paul.burton@imgtec.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58374
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

On Fri, Jun 02, 2017 at 11:20:00AM -0700, Paul Burton wrote:
> Add device tree binding documentation for the clocks provided by the
> MIPS Boston development board from Imagination Technologies, and a
> header file describing the available clocks for use by device trees &
> driver.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> 
> ---
> 
> Changes in v4:
> - Move img,boston-clock node under platform register syscon node.
> - Add MAINTAINERS entry.
> 
> Changes in v3: None
> 
> Changes in v2:
> - Add BOSTON_CLK_INPUT to expose the input clock.
> 
>  .../devicetree/bindings/clock/img,boston-clock.txt | 31 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++++
>  include/dt-bindings/clock/boston-clock.h           | 14 ++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/img,boston-clock.txt
>  create mode 100644 include/dt-bindings/clock/boston-clock.h

Reviewed-by: Rob Herring <robh@kernel.org>
