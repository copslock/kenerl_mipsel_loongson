Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 18:33:36 +0100 (CET)
Received: from mail-yw0-x244.google.com ([IPv6:2607:f8b0:4002:c05::244]:43187
        "EHLO mail-yw0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdJ2Rd3tDYLr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 18:33:29 +0100
Received: by mail-yw0-x244.google.com with SMTP id y75so9637329ywg.0;
        Sun, 29 Oct 2017 10:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mu8oWeUdLMA8LnTysHj4FmBXBMXs2Wpu0UTF0HLec8c=;
        b=f6VZii5uzxJLKjogmXkRCfBegk9UaR4zTn0VaGAK8LpvdarkAOX6x1+BilM8+6yRqL
         RWsE69Aqu/PhqGlz8wVoX/h3/iZkH98JMqNOAurXnrIXr8AKBJzYJ5g8MdTwA8NIeM5C
         q/8p7DB1hXS4fgnvqe5XFwZpU8Xgr+TPVrqiugxbNwYtcw/g6mS7vyGmaLK1Gf+qDIhJ
         I/0UNBWcYf6s/0BPc58107f7QbmLPXGBj9yj2EICo4y9lDLvHAGm1SanrGx5qYd6uzv6
         5JnURR4wQYSIbn9fbtwHJyyf6sZw/6oq02jmQPy3j+i3xGrCZplQiBUa9t4cw/TY8hhW
         THow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mu8oWeUdLMA8LnTysHj4FmBXBMXs2Wpu0UTF0HLec8c=;
        b=h/k2YqqbBokNiJnFVlPX5tqdLZJTgf4XJNvy/S8S9C4pN54CiwbWVMiQuEpvPGHkCC
         4YEJg4G1eCAFRbsmeSYZ3rt2teHzlMvBOxc8/xPduHT/LKEdUv27WqVb/AnKwu2s2cQf
         NoFT6ZghUx7qaDIXr04baJvP89I4+I8aliL1y0LjQ7JMNGKi4693mZHEC0T8vMgqLGcy
         GX49xwBl56hLi1b+wvwkWKfI/Dkw6ezDtQ9LgwYME/3BOUmIEAcqyggemDy8lUsLT2BZ
         UEwgYSOslgx1Funnj7FWBgGL9l3YE0ekI3hOaU4xkED3tPoxGPUdCEnexdpOjtYbG1Ot
         JUXw==
X-Gm-Message-State: AMCzsaXoBTvfAjuBgjCdwSjvd32LYedxlddXjDpX18lop7gIZHs5Jk16
        rQb3WGblT33z0t61mSUI7Ko=
X-Google-Smtp-Source: ABhQp+QVNIEbQeiIhPXwKxo8U20lU+2gBUF4DQn7OIBWcqxu2upPC+rLHtWajCVnfsRZPXo/tVufaQ==
X-Received: by 10.129.160.130 with SMTP id x124mr4407118ywg.209.1509298403636;
        Sun, 29 Oct 2017 10:33:23 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:35db:b726:7a31:93b4? ([2001:470:d:73f:35db:b726:7a31:93b4])
        by smtp.gmail.com with ESMTPSA id c17sm6211000ywk.103.2017.10.29.10.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 10:33:22 -0700 (PDT)
Subject: Re: [PATCH 1/3] MIPS: AR7: defer registration of GPIO
To:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Nicolas Schichan <nschichan@freebox.fr>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
 <20171029152721.6770-2-jonas.gorski@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fe7b4311-b013-b372-68d3-67a656eaf8f2@gmail.com>
Date:   Sun, 29 Oct 2017 10:33:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171029152721.6770-2-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60581
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



On 10/29/2017 08:27 AM, Jonas Gorski wrote:
> When called from prom init code, ar7_gpio_init() will fail as it will
> call gpiochip_add() which relies on a working kmalloc() to alloc
> the gpio_desc array and kmalloc is not useable yet at prom init time.
> 
> Move ar7_gpio_init() to ar7_register_devices() (a device_initcall)
> where kmalloc works.
> 
> Fixes: 14e85c0e69d5 ("gpio: remove gpio_descs global array")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
