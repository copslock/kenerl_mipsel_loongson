Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 04:29:38 +0100 (CET)
Received: from mail-oi0-x22f.google.com ([IPv6:2607:f8b0:4003:c06::22f]:50925
        "EHLO mail-oi0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990590AbdKBD33pYEkS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 04:29:29 +0100
Received: by mail-oi0-x22f.google.com with SMTP id q4so7316900oic.7;
        Wed, 01 Nov 2017 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A73bmEVWWH5r3taPmgXYMTBuRNNf2+XAF7RCOjktjV0=;
        b=KENGTqdawVc0naxjjzgOaPosSSiPBs7MVu98P7UA6ZC7EV9l0vUnTV72ZI7u2rGjS3
         JDkCJDFxpq1jvk5xHfUv0A4r93lBTNgSH/Deji6fAUFogd6xeEyOlTTbOeeOpGChbgkP
         d2ZVfYYrXxnXlPqGQr/zjsP9tMylBr3/+HmY2ACAZLio5BxYNU5DGhlpNQ1blYr6FIH3
         elzlWVpsBx4KHGDn3zk6c2BeghrVEM/mUcxfNnLWUzBhHqeLvJ04p5GF0VzxXB/uAKWg
         PNemkvwNSXC+EuoSfS02hMExkjc7tp4cNgZCj6cC3eCTX9RYnJYREztE8pEyF4Esotdx
         OkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A73bmEVWWH5r3taPmgXYMTBuRNNf2+XAF7RCOjktjV0=;
        b=OR+eJRn1vrDW1c3eevht+0ObKwTSAfYlVZtRiT2E5vjuOBexcjToe5KhyqNfx9QdHS
         UrpC10posjOnL/RhCqdIWD2J7IZgaz4Z3mqo8nTg7JUpkbdlvzYwDTsKweuisp9ygtUc
         ErdL8kCZK0pR9FuK4uiRebPgYXfRn+K1WELlyz658W/w5fKKN125ugTGU17qgUqngT/c
         Wmbkz/BUybzS7s/8skzLplcNjRpL6YKspbyRBf05YIOHq/082Pz2BJElD+YmX5wlrksE
         RyFJhOvcaFZZpJPGj7R1GI/YasSoGRl2H3kIudIYJoNIg1xpddGCzFRucJXsYspgavql
         ZycA==
X-Gm-Message-State: AMCzsaUqhHYBhIHfFJPvDykIss1Nvwq3xhoTaB6z4iZ/+mSrsWGYJny0
        ASoThm8mUBSnr8ZQRBdLT/Y=
X-Google-Smtp-Source: ABhQp+QHpgHJCQLVzLfuLpMhsFYGwkKrDgaxKAC1uUSLWpXaaZjoGfb5/nP8rysR+NvdSsjKWh7WAw==
X-Received: by 10.202.213.209 with SMTP id m200mr1051653oig.177.1509593363358;
        Wed, 01 Nov 2017 20:29:23 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:60ce:df47:b37c:4715? ([2001:470:d:73f:60ce:df47:b37c:4715])
        by smtp.googlemail.com with ESMTPSA id w140sm986178oia.21.2017.11.01.20.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Nov 2017 20:29:22 -0700 (PDT)
Subject: Re: [PATCH 4/7] MIPS: Octeon: Add Free Pointer Unit (FPA) support.
To:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-5-david.daney@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d473b10c-ae5d-efa1-7329-de7b68152725@gmail.com>
Date:   Wed, 1 Nov 2017 20:29:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171102003606.19913-5-david.daney@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60656
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

Le 11/01/17 à 17:36, David Daney a écrit :
> From: Carlos Munoz <cmunoz@cavium.com>
> 
> From the hardware user manual: "The FPA is a unit that maintains
> pools of pointers to free L2/DRAM memory. To provide QoS, the pools
> are referenced indirectly through 1024 auras. Both core software
> and hardware units allocate and free pointers."

This looks like a possibly similar implement to what
drivers/net/ethernet/marvell/mvneta_bm.c, can you see if you can make
any use of genpool_* and include/net/hwbm.h here as well?
-- 
Florian
