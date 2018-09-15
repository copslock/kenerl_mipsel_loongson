Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:10:19 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:40856
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVKIH9-Yp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:10:08 +0200
Received: by mail-pf1-x443.google.com with SMTP id s13-v6so5822624pfi.7;
        Sat, 15 Sep 2018 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52wM23miKhQQURXb36arlPc340qHl50JD2n/tdybVwM=;
        b=XKV8yvHPpJ3BkNf/e0dcPcvwOKLiPvLJjo0n+yCcjUs8Gu/nhnNjoBrAMnKQy3X/9j
         kS8KmIXakx0ySvmnwJVAvM5B+7Juu1cAvdbtaB0Foh1ig5V/gBpJjfs9eETtd42nXPI4
         VKgMEGnBRcKB09toindp3S6tt7mXCsLsgvewZIlK8ea3BfikosN4RI7pHXDBeu5CP7CY
         NHd4fO2tmqIMcMfjj2AR6RHnf18b1kBVRT02tAdLAr/1cw8oyPzTRtkhS+e7fB79cd2h
         EnSrwAQ4uvgZ3elEKPU8JN4wRAVN0MjxUr7iXvbRbpOZJ5qi+/nbgxxfUq0i/+RBydXx
         rX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52wM23miKhQQURXb36arlPc340qHl50JD2n/tdybVwM=;
        b=CBxg0W9aGfmp2MizOSSudrsPjAyOW0phpLykkelv8H1SuaNDcYlS7t18yvrYmy4efL
         XEpKi1PRNBRSOBQHN6mN00f/FTr1Uma/iL2elL1kcojzQTt3icXmzdxRTPqZ5Lyf3xNS
         nWkmC63pC2SGAQyrkbEPmxu4nlaTT7BtMMILlNyHTG3RETF4ErUehMURa6GCxg2u0s5n
         BgHM0BB/dFM/2V8CMyxcY30vzT2GUzYjJg4sfEm+6jvatCj101wFng3jB/clOjHMyZsj
         QpgqTsb2nmEitby34P9AyCa3IZRL/TVYZarE4nUA/+vD7xiYY2bAhnuJhSz19CnevTY5
         YAAg==
X-Gm-Message-State: APzg51CIFvdizBpcHeB21GAypnab1TVAIRyRz1+/a0UEJbAuVs2aGoC5
        OBzwU6UPHkybpUk/DEqp5V8=
X-Google-Smtp-Source: ANB0VdZgm5fryjA5iku9YcYp44leOfor7W3pRICZVnQnduM74RMIvDCiLu+gBZNbfXF4MRyiwnYE8Q==
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr17695361pgl.302.1537045801935;
        Sat, 15 Sep 2018 14:10:01 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id f75-v6sm18012919pfk.85.2018.09.15.14.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:10:00 -0700 (PDT)
Subject: Re: [PATCH net-next v3 08/11] MIPS: mscc: ocelot: add SerDes mux DT
 node
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <ba95add3d931177ef55666e856164523903d1148.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d7ca96be-5a66-0a9a-62b2-936595122058@gmail.com>
Date:   Fri, 14 Sep 2018 19:30:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ba95add3d931177ef55666e856164523903d1148.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66338
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
> The Microsemi Ocelot has a set of register for SerDes/switch port muxing
> as well as PCIe muxing for a specific SerDes, so let's add the device
> and all SerDes in the Device Tree.
> 
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
