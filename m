Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2018 07:46:04 +0200 (CEST)
Received: from mail-it0-f65.google.com ([209.85.214.65]:37285 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991947AbeIQFqBJJLSf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2018 07:46:01 +0200
Received: by mail-it0-f65.google.com with SMTP id h20-v6so9435690itf.2;
        Sun, 16 Sep 2018 22:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to:status:lines;
        bh=KIw/x8W1l3CD1XMcIMlujZb+tObZ0rj5ISpe1kiVgR0=;
        b=SrFpCVffbTNRJNj/yaJDrBeqZeeeh0iHax0rxpHiCzJrEWoQunMVMTDlP2j1zAfYfO
         XsOQh8VSh/nWsZ89fRhX8J2auMr+nR8pPH7dWTU/02kvVvCFbkgFQmq1wvX0Wvnwp5WX
         CzKNuoj9MgSza7qDX9GnNn/j/Nvf/o5Tg0yBaz7atur0lqYsdqkM4DR20ozAxKt9bAki
         dhuiY9nXTL9FhkIGFSeQkETMZihRCMg6I3+yaY4unFJCNGN6xymekzVBAOgQTnGr6v1d
         HP18Lda0lBmZN0LB4y8iu+OmRA/63fyiJ3dokYsyuQ/ilqrErejAzowaF3aNlSPcy8Pc
         Gekw==
X-Gm-Message-State: APzg51C5veCWKUNSNCRJ9TOBB8fR2RurAU7cmD/2MreLZOWJBu20+BGJ
        w7DBaE0+Li2Hgs0sSR1jlw==
X-Google-Smtp-Source: ANB0VdYYYsfOF3L5eeZfQjD3KogswNs6NB3YDi+1bhA0kWi9G413wkcmvzxUjgAA2EGAi0MJU7zzcA==
X-Received: by 2002:a02:1b18:: with SMTP id l24-v6mr22010627jad.23.1537163154985;
        Sun, 16 Sep 2018 22:45:54 -0700 (PDT)
Received: from localhost ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id n140-v6sm3328551itb.37.2018.09.16.22.45.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Sep 2018 22:45:54 -0700 (PDT)
Message-ID: <5b9f3f92.1c69fb81.9131a.468f@mx.google.com>
Date:   Mon, 17 Sep 2018 01:45:52 -0400
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com> <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66348
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

On Fri, 14 Sep 2018 11:44:22 +0200, Quentin Schulz wrote:
> The VSC8584 (and most likely other PHYs in the same generation) has two
> additional LED modes that can be picked, so let's add them.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  include/dt-bindings/net/mscc-phy-vsc8531.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
