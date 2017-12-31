Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Dec 2017 14:40:23 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:34485
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdLaNkQygc3a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Dec 2017 14:40:16 +0100
Received: by mail-wm0-x241.google.com with SMTP id y82so10817424wmg.1
        for <linux-mips@linux-mips.org>; Sun, 31 Dec 2017 05:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=owfd/YVR/EzDiMXyNdt2qlnnnm75UX6BTgVMALTYcGc=;
        b=jKae8n48cRp4UDuCUX/DPv9YXEEwtkhcYFDJQeAFf7+zUL5/W1N6gS19IzVVIDDF3K
         GZWKHf96rTHVF5TZ1NZ/lpxoLZaOE599fET1erdywYTlqnSlsXMLf5TDXywGtpAUIrSl
         w2pJLmtVGAQ+XgFMjXS14c7+Qdqz/7isM9slzVuDO1iHMxYMnzwd4X3FSUYz/xl54pqE
         VqxYB3b1h0jb+tYL+IGuPXxQxp4vrLvpgHsNUvDr4h7YsSWLjZZv4y62T7hpf+t0a2nJ
         rSPyiDAHh6pBBN+DFuyLXJqZXnOK0RwDaph9dO7F/Xq/eHhrsrR4R2GgZmIDmU19ACtq
         5raA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=owfd/YVR/EzDiMXyNdt2qlnnnm75UX6BTgVMALTYcGc=;
        b=Z89OwRA0Va4yTtVXWQFCGGs/zSvayLqtX1A5I3q5o+yVIKBadhqRqw6pm9LCSf0pP8
         3XflpbfNK66NVKpoFomCaG6WG9SyC7dcpe1+aeY11hj1nmeZz29eX77Mp5M0HXuAmQGn
         jp6wtJ7Nxcc+yh3ywKptgDNXeubM26ZN+CllM8ZTIYkJ3F0aB3Ws0nq0G3tK/e7nFQJg
         kjDtAgIkGK70dMEb0SlmdCwd2hp/r8fbuhkhmOU15SVvlf026WmmHv1G1m3BlxTG4lp+
         65b87YCGGYvimEPQPk5bNPo1N29ZHSENkKU1h6aRpbHqLhFC4ZHfldczczEMERbbJEIN
         trfA==
X-Gm-Message-State: AKGB3mJKRV82lW1xmdNoPaYi6gBA65ULUCvSC1hjCrMCmkmv06CNaYdG
        NL6rB0RYFXldeb6ar3e4kZabRw==
X-Google-Smtp-Source: ACJfBovu2i2vZ6D5GC6XkK7LYH+ifTLlk01NXuIs6iIW+XzCCxtiY7oo/ukI7G/HcysWPq4No/Vn3w==
X-Received: by 10.80.136.228 with SMTP id d91mr53099728edd.296.1514727610747;
        Sun, 31 Dec 2017 05:40:10 -0800 (PST)
Received: from [192.168.178.80] (D4CCACC7.cm-2.dynamic.ziggo.nl. [212.204.172.199])
        by smtp.gmail.com with ESMTPSA id 33sm36390377edt.57.2017.12.31.05.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Dec 2017 05:40:10 -0800 (PST)
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to return unsigned
 long
To:     Mikko Perttunen <cyndis@kapsi.fi>, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-rpi-kernel@lists.infradead.org,
        patches@opensource.cirrus.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
Date:   Sun, 31 Dec 2017 13:40:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <pure.logic@nexus-software.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pure.logic@nexus-software.ie
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

On 30/12/17 16:36, Mikko Perttunen wrote:
> FWIW, we had this problem some years ago with the Tegra CPU clock - then 
> it was determined that a simpler solution was to have the determine_rate 
> callback support unsigned long rates - so clock drivers that need to 
> return rates higher than 2^31 can instead implement the determine_rate 
> callback. That is what's currently implemented.
> 
> Mikko

Granted we could work around it but, having both zero and less than zero 
indicate error means you can't support larger than LONG_MAX which is I 
think worth fixing.

---
bod
