Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 18:17:09 +0100 (CET)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:34873
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992391AbeBGRRBuxu-V convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 18:17:01 +0100
Received: by mail-ot0-x242.google.com with SMTP id a2so1502928otf.2;
        Wed, 07 Feb 2018 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:in-reply-to:references:mime-version:content-transfer-encoding
         :subject:to:cc:from:message-id;
        bh=WHNNSg/zNqSsUXo/Sb/zH4vhGyN6AWmNfh/pCss+5Mg=;
        b=lviDkFmsDRu9QFrBH7NZd/jMVzL63qaYb4qr6RnUuD/1sh/9lZNaE4ZmC2nMH1hvnx
         Q7Wh7m6C35PGOJKLCTpsgBxD8PK4u9ujfP2b6/F15bqU1FuieTCWltWs0sZsKUwm4BlB
         tglSopFtqYrQYziOw3w6FqCEOZndPDcC94SfHCZ0/7pXSfkjTNwpGtrHNhpxiY+pkpEQ
         yteN6yAnHVPxjO6G+mObvh/t4sf036vKto9jk4t6gwL6Docgu29KNweV2pz/rGeYjg1J
         KVGbJjiOEP9dOgdw1p8L6xEmnyQFDTYtVqTTh0CcketlAUpSc8X+OKgi559vHIRuk5Xa
         OiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=WHNNSg/zNqSsUXo/Sb/zH4vhGyN6AWmNfh/pCss+5Mg=;
        b=TzFcGCktRSG58KiDawUrln8hUVrs2f1s8YXd+EVOmBGgZJg8JlBMNazvQscFLw4TjI
         NOA6p60cd3V/V/67wO0SpW3uk63j7WW7wLB8h5v153BQcz6eyy3I8dRpEDilrWqPmPil
         JcQhmvfmzxfTTXeXnM32x1tQ4MRV5G58HfUX1B0ffwGXn9iLq/WWoUTpaHTtQ/w3NFtj
         87cE9ooVqbmJWOWpFNSWRFO7Z4l7WHES/lfJ1ZZ9vR9rzbiJF3N62we760TQnrJrwDz9
         YBPeQtJMSM2aqjry19SVwzFIrezvfqFS0UAAKU3/yNeGUN4w3hPrU8ae7LRnsb8GWFqa
         okzQ==
X-Gm-Message-State: APf1xPDNctShhWyuB6cm6p9EaVOqRdVALUhTeh/hjIL1h4mg0bhhZKcU
        cj/vi5hPP5ypjvc5l2YxaPU=
X-Google-Smtp-Source: AH8x225Fkfw7BnxLEpImNFudFaZY5G/fjzyO3xPgU+gZEO6TkPmBljpmrQUZ7B4RjMOcsY48+jdstQ==
X-Received: by 10.157.81.134 with SMTP id y6mr5373208otg.348.1518023815232;
        Wed, 07 Feb 2018 09:16:55 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:e85e:d467:ab64:5572? ([2001:470:d:73f:e85e:d467:ab64:5572])
        by smtp.gmail.com with ESMTPSA id z51sm877109otd.72.2018.02.07.09.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2018 09:16:54 -0800 (PST)
Date:   Wed, 07 Feb 2018 09:16:49 -0800
In-Reply-To: <20180207023627.7898-1-jaedon.shin@gmail.com>
References: <20180207023627.7898-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] MIPS: BMIPS: Enable CONFIG_SOC_BRCMSTB
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
CC:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6B0A7076-0AF7-45E9-BDA2-65CA00DF6813@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62460
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

On February 6, 2018 6:36:27 PM PST, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>Enable CONFIG_SOC_BRCMSTB in bmips_stb_defconfig. CONFIG_BRCMSTB_PM is
>also enabled by default option in Kconfig.
>
>Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

-- 
Florian
