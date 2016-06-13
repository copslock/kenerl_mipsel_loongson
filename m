Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 08:09:14 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33328 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27039636AbcFMGJMJqSxE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 08:09:12 +0200
Received: by mail-wm0-f68.google.com with SMTP id r5so12120987wmr.0;
        Sun, 12 Jun 2016 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=k8Ob+7UGlmS/fCYEbVSmhWWtggw67tBrmlUE9AyBjnw=;
        b=qrOEnSYckRq/R/8P41oC16sKK92XtzVSl02mNno9dbXoy72PzdUVgG41osd/qKZOf1
         euqr2cf3305gGItMiNjmGwMJNjrU1L4FFXrfOzgC6ApfxSl354nWaIaAUWZ3XEr8kUKy
         eOWyDo1FFU45MFFILNo22Cgt1IYf1A3ChOA5gmbt9qzV/AIav7TqeVpkAyDvWBCAW8Kn
         z0kftx2Mtp0P3cFwQeP3uvST1hETYkjxhu+Ohpj4S0uRMD/ie4A0xMAeIaflqn4Eto7Y
         us70VGZpbONuAhnLy3X1UxGUOPcRNl5Q+/JDQhZpB1DE87LGXSZZ/ZVRWnbMIph2i+A+
         Z9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=k8Ob+7UGlmS/fCYEbVSmhWWtggw67tBrmlUE9AyBjnw=;
        b=Y0DppEOq6S4C+i/ndskt7wYk8eLSvmcRvGsHCoUcqYnwgphcOEe/JDgzCHSKrInmxe
         jvBIzWiVn0quZrdjZQPEuWHIh6k4MWrjgHYGascpiFazZTFx5w76aVmTMrn2P5BKFb3c
         C+gru3DxYLfLdVLtE0s135gwlRDLak2OETu5z69UD1JnclhwnM/V9mBE0r9rrwAhLurt
         sNaR4bBOBRgG08jYDAOy/vHC2heVNIdunPUOisa4GcEXMwhhK7ohJLa+Unx7BRO6rxvZ
         yQMZx93s8yBz0Y3rTu8ovZtgTN8D5yhEVHVUQJp+/p99ExrDlZan9AdnSC9DXGrzD/2m
         1M4Q==
X-Gm-Message-State: ALyK8tLv8v4v1/HjkOKqMVcoxUyqeQlBMpMpIlfq6zGLUiaMMkh5y2sd+Zkt8UM41b8GYQ==
X-Received: by 10.194.116.195 with SMTP id jy3mr13875713wjb.36.1465798146848;
        Sun, 12 Jun 2016 23:09:06 -0700 (PDT)
Received: from MacBook-Pro-de-Alvaro.local ([46.222.221.91])
        by smtp.gmail.com with ESMTPSA id s125sm12312103wms.14.2016.06.12.23.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 23:09:06 -0700 (PDT)
Subject: Re: [PATCH 2/3] MIPS: BMIPS: Add BCM6345 support
To:     Rob Herring <robh@kernel.org>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com>
 <1464941524-3992-2-git-send-email-noltari@gmail.com>
 <20160606135834.GA28996@rob-hp-laptop>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <575E4E08.3070801@gmail.com>
Date:   Mon, 13 Jun 2016 08:09:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160606135834.GA28996@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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



El 6/6/16 a las 15:58, Rob Herring escribió:
> On Fri, Jun 03, 2016 at 10:12:03AM +0200, Álvaro Fernández Rojas wrote:
>> BCM6345 has only one CPU, so SMP support must be disabled.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>>  arch/mips/bmips/setup.c                             | 9 +++++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> index 4a7e030..1936e8a 100644
>> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> @@ -4,7 +4,7 @@ Required properties:
>>  
>>  - compatible: "brcm,bcm3384", "brcm,bcm33843"
>>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
>> -              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
>> +              "brcm,bcm6328", "brcm,bcm6345", "brcm,bcm6358", "brcm,bcm6368",
>>                "brcm,bcm63168", "brcm,bcm63268",
>>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
> 
> Are these all mutually exclusive? Please make that clear.
> 

They are different CPUs so I guess they're are all mutually exclusive.

Álvaro.
