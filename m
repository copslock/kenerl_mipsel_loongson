Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:09:34 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:42618
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVJa2xIip (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:09:30 +0200
Received: by mail-pf1-x443.google.com with SMTP id l9-v6so5812464pff.9;
        Sat, 15 Sep 2018 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GEUrdFSYUBaTgJxqR4suLHlpanCwla3EluAdYPc4EvA=;
        b=XmHyIPKBncEvEwLZ+XHihON3aLxOgA88bXU+OdaA/2F8DjCF4b8er558N5bVpjFSrJ
         aIuB+T8qcQ4XzK6cVbQIVSKkRcmpuXlyqPk6qDorLzlyoE0sw8uh+PpzjRPkRqDwCI/p
         sLCwCFWaKoJQPKixUhW0gGPvUV5z56FUo+2Ru84JyzAbBcZpM82xYBI/390ZSSSNvS38
         eF6B4YWuv64YjXT46iyAW0mOOO0Zh/8PvTf1veS8X1EVCUMMYcPW1i0JZD/CwGXKouS2
         UTHiDe2d0VaNbYONC8dSyn3xxN5sYMoLU8tCPly2/MGy23bhitzNgE0rjdRZmXlGfK/M
         hPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEUrdFSYUBaTgJxqR4suLHlpanCwla3EluAdYPc4EvA=;
        b=DGPEwgO5sjJw5O9fPRiPsgITMylm6x6zqdD0qrwXStb4lbeqGje57Hm4889A9MzJ92
         kW1+o1gQllBRerbxzJWX/7x0ApTNjUiPbfv38G776kV9xtrd4hBF5zksLQRHwckch9aW
         20nSR6Pi7M93XUX2W3oFy7rcxdeLqCu7QNXRS1QIEOrnPSJyqqLNSW62QONdFyEBzibH
         foNHIn8t+a4f+we4iw+AWXYb05ZdTOQw3Hi3LrS9y3gPtZPcH65GqTjFVhGrWvUWxW/7
         fjsx0nS9zqProOTO9Y8462nopSNNsEgE2puzFy6FUPpGiU4siD3xZUPIhMbyIbbuGQ8E
         NEAA==
X-Gm-Message-State: APzg51DMh+XHA4LmF9y/BjJBDYoLCReKG4JUpvN87DeZ0YTGUh8Wo5zN
        raFY5wI/BhwCX2KG/wJR2MW/+hU5
X-Google-Smtp-Source: ANB0VdYizih24GctUAyhXW+oizV/buedIGtQG6NIDcMpOrjamZRs657fQptparGvKTbvn/p4ZnJbqg==
X-Received: by 2002:a63:3089:: with SMTP id w131-v6mr16977133pgw.79.1537045764215;
        Sat, 15 Sep 2018 14:09:24 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id q80-v6sm15091800pfd.15.2018.09.15.14.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:09:23 -0700 (PDT)
Subject: Re: [PATCH net-next v3 07/11] dt-bindings: phy: add DT binding for
 Microsemi Ocelot SerDes muxing
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <712d5cfa-dfd0-dc15-8360-fec5499af273@gmail.com>
Date:   Fri, 14 Sep 2018 19:29:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f392dafca9165800439fc09cd7d16e6a9506d457.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 09/14/18 01:16, Quentin Schulz wrote:
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
