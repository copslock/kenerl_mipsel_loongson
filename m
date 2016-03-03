Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 21:09:05 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36159 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013258AbcCCUJDjtGsO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2016 21:09:03 +0100
Received: by mail-pf0-f195.google.com with SMTP id q129so1901013pfb.3;
        Thu, 03 Mar 2016 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=rrQkP0zpQ8TZTENJO4vm983v6CSzKrubechoqUF0AS8=;
        b=nTKDKkPARNxeARvAVsDDdaifWrOzFNxtjFCzhK0NYHUL59/01056LdnBRwwt0R6bzY
         1uI0vTCTTFLmACPnKMhb0Y6AvfMGYaj4xCKZ/mqZ9PdQ/1Ipk+dAiOY+FyCD9RHIg2Jb
         dwu2/5pWIe2+QBKYyoVb4GmnQh7dIAeCFygbSimNvfzAgcxEKjzKpi/13g+k0VZzjGpk
         UA4PKo4XKYqKH2poIlf+Nzu1H1lW7n4XSciQgU7i4eenYssLvgPcB5Vvr0PhiwIaDlQn
         MZLML9n72DDubHCn8Yc+82K1c7NRef3wy1Zcv2MjwtRYddJSdT9zV+jglfISsMQlHH9J
         Rzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rrQkP0zpQ8TZTENJO4vm983v6CSzKrubechoqUF0AS8=;
        b=EsHjBb3wunc/oQvz/zba21iq+oGvAO8QfBSJZfXL5SUenZ03nkTAU2iKHdo0ZYGaCS
         lKZX6pqvbODu/lIVRQfm585g6i65g1Yd/VclXwVXVBhwfP9utzA7DlR7KaViyAJV2eWF
         rrQHUNVaWfn6BiUeP0aUBTCDrUglt94uiFrINBi3naYsH6ahcgg7qa/d3gyGhKg0/5kd
         /Chu6axCBi7NG6JHDG1toB6U1ZuF7Ieh1A/s/IgF/Q6Z98u22szwqTJ1LxbQTC7zdL1l
         5o3QYglwSA0KZ+HuYKeVUAG7XgCT+vHWhLok4/m7/YpmTjCpxf6gdce0VktPfjmMr0Ab
         48uA==
X-Gm-Message-State: AD7BkJL+TkxqePkmlvC2sy9t5RZp2bwGQhSNmtbeQxbKT9pqH71X1Bj7zXxM81Bdx4fWdg==
X-Received: by 10.98.72.3 with SMTP id v3mr1482698pfa.62.1457035737758;
        Thu, 03 Mar 2016 12:08:57 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id 67sm121395pfi.2.2016.03.03.12.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2016 12:08:57 -0800 (PST)
Subject: Re: [PATCH v2 2/2] bmips: add device tree example for BCM6358
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jogo@openwrt.org, cernekee@gmail.com
References: <1456054881-26787-2-git-send-email-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56D89984.8020805@gmail.com>
Date:   Thu, 3 Mar 2016 12:07:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1456054881-26787-2-git-send-email-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52435
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

On 21/02/16 03:41, Álvaro Fernández Rojas wrote:
> This adds a device tree example for SFR Neufbox4 (Sercomm version), which
> also serves as a real example for brcm,bcm6358-leds.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
[snip]
> +		periph_intc: periph_intc@fffe000c {

Other examples are not doing this, but this should be: periph_intc:
interrupt-controller@fffe000c to follow the ePAPR recommendations on
naming nodes by function types.

Everything else looks good, thanks!
-- 
Florian
