Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Nov 2016 22:15:37 +0100 (CET)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35986 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993209AbcK0VPYBJYqO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Nov 2016 22:15:24 +0100
Received: by mail-oi0-f67.google.com with SMTP id u15so11166691oie.3;
        Sun, 27 Nov 2016 13:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RGC9EX4Rlkgu9mj6O3Wag81M9hd3bB9McGxFcUpvrcs=;
        b=kY0qOJ0/z/o/5p74V3/i4/v0qABuRtnw8pPUG8SBpNyboNLsCUGQt7Vj7pvmuB7DPh
         ch+uDmLhB4kfQ1NGy566/m86DdvVV/AMPKuiBd/k577fTSOia6yjX6uF4ig9BU1e5XEj
         3qELG53gu0As4mbC10AS2Xho1CAZBeyJOEwOD2kKqI+mPXgAWZH8U298IIe+SJ1/9b3H
         jJ3tPU0NfNLi/o+cEnybaEHuPEtPZM3DwiWJSYg9ArVWpRuAQPoCu5hC0i/5c8B2jaM5
         gLcYuBqaqHpnukV2xk4uUfAneMs0+EHfYINv0Xa8QjoBgVWMI9YKRDdTEOMyfV3Q1ZTI
         anFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RGC9EX4Rlkgu9mj6O3Wag81M9hd3bB9McGxFcUpvrcs=;
        b=Cjbb9Y3cAxbkqCnUsa9WAAV7eXRFJyL/vJSlG5pg/kTkh0uyjPqPyCEm8907brWhAo
         gZePHDOREdqqUJximiVBORxGSs5lKPnY4u/QJKivDMvu19trbpMRfpgvWSHShHCtQyqq
         Q0U8XV5JXLomLj2NSBkY/8YDSTUk77YmJmaS27TdvXXbM5lNYnclSrapS7athdbl4veI
         s0Q5JB+3dsyb3TPx2LG5DEp198E5u6sn9O3KY4+89zkxZAgajrnRSrxRz57EmaulVPnO
         UWB38xKO31mWoDgjWVu+j9kN/0ip4pK2+oiRiaDO6s/m+56LGNdOz1S0pQEePuEaBvNN
         FEug==
X-Gm-Message-State: AKaTC01q6DBlXkeUk7ZjHgwuKVx7idkAyfGa4nYi/ocXOPmEtcwdO66U5tTCdpXbggcBIQ==
X-Received: by 10.202.74.73 with SMTP id x70mr8996692oia.47.1480281318031;
        Sun, 27 Nov 2016 13:15:18 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:8457:d23d:8f69:e2d6? ([2001:470:d:73f:8457:d23d:8f69:e2d6])
        by smtp.googlemail.com with ESMTPSA id u66sm16598941ota.34.2016.11.27.13.15.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Nov 2016 13:15:17 -0800 (PST)
Subject: Re: [PATCH 1/3] MIPS: WARN_ON invalid DMA cache maintenance, not
 BUG_ON
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <20161125184611.28396-1-paul.burton@imgtec.com>
 <20161125184611.28396-2-paul.burton@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <61c56baa-b59f-8c3e-23db-a408b4e83a92@gmail.com>
Date:   Sun, 27 Nov 2016 13:15:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161125184611.28396-2-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55899
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

Le 25/11/2016 à 10:46, Paul Burton a écrit :
> If a driver causes DMA cache maintenance with a zero length then we
> currently BUG and kill the kernel. As this is a scenario that we may
> well be able to recover from, WARN & return in the condition instead.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
