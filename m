Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:35:08 +0200 (CEST)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:45085
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIOVfBeMPjH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:35:01 +0200
Received: by mail-pl1-x643.google.com with SMTP id j8-v6so5684296pll.12;
        Sat, 15 Sep 2018 14:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HU7kikOQ8N5r1SbH1w2kVP/GhptrxpVltOgdNsulNZ4=;
        b=F8MAUEOWmk0gtiooscdj7tuzoC5qOc8ZBOuYS/ts+SFHjGT3GpXBICLq35eyDhDu1F
         2t2Hu5fZWW6P7skqkrDorMWAQJsAwaU7Ls3DcKWFAwI5i0gZfFVdvcP3neXeoV5YIshI
         /tSl3xkh3vfxK48S3rPel32Cd2bhT53Qul8vU7VxuTb9U8De4rlnkNHQokA0kWvbMGIG
         7ywJ9tKr5fYj9teX+2p/Hrz92qQvgGqzaxSjAd/OJpnrjF7s95TTKJndE/VQtZZcWei7
         Le0mmYOWV/1NTyernR9xDobMtcstP58ONpb7/+lXncu2V7uBqkQO6ZNkK+uD1NOY+Qz6
         D3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HU7kikOQ8N5r1SbH1w2kVP/GhptrxpVltOgdNsulNZ4=;
        b=Guo/dJRUrKcN8nYXDzSXSb3zMYk93Tt3hD5kpKN6s3zOo9jn3chu3PVknkdarK5f7N
         Ix5072JDgA9FmmfbiBU/uQBcqCQuUmS+5pe1/MLcFBsqDUk1IkqE3/A9onRB+Lt9pKW2
         zpBT/sJ4QYhRYYvxluiEr3Pv1V8eBVVEKZFuGO4WGpFK2eHaM1sPYhO5FhaOkMpMrMIv
         oE3+uPk3NuyxT3p4i8+lIhI/3HFapn3vPrC0tGeeWVZXsMVLe7ywdMeDppV3ZVvIAbOE
         etPyZKWcOe+kWi3YVLa3Hr4sWF9sKCkx7E4GiqCz3YunaL55MhAHStlvPrsbUWVXVDsw
         S7oA==
X-Gm-Message-State: APzg51BvS4mpS3IhIovqVdi6+9GO6Xhlkw/VlHvih/olnY+/8byLmeDf
        ROSqNIe7dz5uSa8Bq5+BHxMC529z
X-Google-Smtp-Source: ANB0VdYil0cc8MUoaTaBG+UP2syj7eXTDfFXNYM9vMDaKv0YzmQEljIJVh9s+8xikmM9zL5cw2UNGg==
X-Received: by 2002:a17:902:558f:: with SMTP id g15-v6mr18225518pli.38.1537047295280;
        Sat, 15 Sep 2018 14:34:55 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id b64-v6sm13680474pfg.66.2018.09.15.14.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:34:54 -0700 (PDT)
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two
 additional LED modes for VSC8584
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c1102b61-fc17-c55b-fe27-b85dcd8aeccb@gmail.com>
Date:   Sat, 15 Sep 2018 14:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66342
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



On 09/14/18 02:44, Quentin Schulz wrote:
> The VSC8584 (and most likely other PHYs in the same generation) has two
> additional LED modes that can be picked, so let's add them.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
