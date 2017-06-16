Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 19:40:30 +0200 (CEST)
Received: from mail-qt0-x22e.google.com ([IPv6:2607:f8b0:400d:c0d::22e]:35293
        "EHLO mail-qt0-x22e.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994819AbdFPRkYXOGWW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 19:40:24 +0200
Received: by mail-qt0-x22e.google.com with SMTP id w1so71973363qtg.2;
        Fri, 16 Jun 2017 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5bvzT6V0T7AyKnBKC/jJ62/Br6/Fb5r4wqta0Q7FcA=;
        b=CcCHnLFrc9hB2jJTseO4jekVoxj0L2AXHejc26P3myLlzmQ9wChzTv2HUqZmMIbS7J
         +Tjg2Ko6xmuSdx68vPcSqiGHQyF9EEUByfk+KJADvv/RVn2ox3yx6XdRpe1gLbkfRe/8
         L3WmYDQAk476NLSwvwl85qYoQFxhMZrUjRZhHIcx9IJQeVY2iwOVIqfxEN9PCI5OTm+R
         uJ58Vr0Zy9jgeMMRqm4sg94QYgumIC9Q8BmH45bBE94g7SQJXzbUeZdRbNPlXZ977d2j
         sVIEx4DlTzim++frgjr/WKoD7WoccsYBpADuiLPEAtrf4wOacOyBRTMVb1FBJEMlLSO2
         dIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5bvzT6V0T7AyKnBKC/jJ62/Br6/Fb5r4wqta0Q7FcA=;
        b=dVKWEpAIvvFUi6xq67NPjKGgfEuNQAsvMVHtbWRR/OfpldFgjCdn5VV3EvaUEeD5zX
         u++VO2Pd81D4wBCymIwwfwC9oGno5wUVDsm77v1Reds10i/+c1hf7I6T6gRh8bFQ8cMo
         B6kVqK/q5IkWbKu0gpAUKVQbib6bzFtkPeDbOiy64SidPjPiyaPqQXfTPDupmJmn8iks
         MnnMdcNL3chgGRZEsPKE/bPEPS238d7hC6UbcVZmUMlywxZCUCxDJ/oyaQd/AXoZVRj2
         k6nLRGPyCXld1KPBE9h9NFpp+CgzQSmRNx8S66rVSQ4QBGyI0Zl1ybaKasgAhXexSSYh
         SM5A==
X-Gm-Message-State: AKS2vOxrEPjcuFAPD6Ma3Nej+bwevALdiJa5auwZB5x3nKxGALlExidN
        Ei/GqVqBOt/ZqE8+YpI=
X-Received: by 10.55.73.132 with SMTP id w126mr14536936qka.31.1497634818335;
        Fri, 16 Jun 2017 10:40:18 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id r9sm2083180qtr.31.2017.06.16.10.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 10:40:17 -0700 (PDT)
Subject: Re: [PATCH] MIPS: BMIPS: Fix missing cbr address
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <20170616110301.38103-1-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e1f97ebc-ab78-a0c6-896d-1cdd04605b90@gmail.com>
Date:   Fri, 16 Jun 2017 10:40:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170616110301.38103-1-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58529
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

On 06/16/2017 04:03 AM, Jaedon Shin wrote:
> Fixes NULL pointer access in BMIPS3300 RAC flush.
> 
> Fixes: 738a3f79027b ("MIPS: BMIPS: Add early CPU initialization code")
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Good catch, sorry about that!
-- 
Florian
