Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2018 23:36:43 +0200 (CEST)
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41113 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992328AbeIZVgcPYKX8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2018 23:36:32 +0200
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so472440oti.8;
        Wed, 26 Sep 2018 14:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQ1yHFe0s9a+dWmxjQ5HtbHvWZyPUcQrC220Vlus2V8=;
        b=XMtpKQY3TPT9e0e9sEEEsw+vt/xlxwLT3e3WKNj+iqfW9Lll+E8ucAN5oAgca2PBtB
         2HxBHLoCGpw6JRq6gy0+bxsNxe/mdDXEcXcPormTgAVCiP5zveHSlDe8frVyQvSfrjeM
         zI8aI/N6BzwYguX9Rt0sL5Uw/nJZ9nEWXXkVg5xZmy1onbcp5YmfUoCeyE6yJgYGcKo9
         u65hEry0Y+mkamgMhSzx8od8lT6bYicBZkUKG81IW8f4Cb3LJUxAlE74AwNh2UGByh/D
         o1WmH6o5zlPfugno4du/wXIkRvruDxAe9O5LaQ6QuKrh6fcU4ZvV2gcRoK0Xa217VCzF
         7mgA==
X-Gm-Message-State: ABuFfoh1wOS9061frT/a2hfNPR1iPwu7UUj5G6g1pL9jg4s8RunOvh5e
        YH66doQvlqQvRINYl/Mx0Q==
X-Google-Smtp-Source: ACcGV60Xoql9fyn2Ahz5aWxOU5iPnAEFGl/84qgUqMvfZhgP5lY1kU6ZMuLKho5zXoAbrh3qgDPVAg==
X-Received: by 2002:a9d:892:: with SMTP id 18-v6mr5783164otf.269.1537997786136;
        Wed, 26 Sep 2018 14:36:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m7-v6sm52400oia.32.2018.09.26.14.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:36:25 -0700 (PDT)
Date:   Wed, 26 Sep 2018 16:36:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH net-next v3 09/11] dt-bindings: add constants for
 Microsemi Ocelot SerDes driver
Message-ID: <20180926213624.GA13387@bogus>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66588
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

On Fri, 14 Sep 2018 10:16:07 +0200, Quentin Schulz wrote:
> The Microsemi Ocelot has multiple SerDes and requires that the SerDes be
> muxed accordingly to the hardware representation.
> 
> Let's add a constant for each SerDes available in the Microsemi Ocelot.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  include/dt-bindings/phy/phy-ocelot-serdes.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-ocelot-serdes.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
