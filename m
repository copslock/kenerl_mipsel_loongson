Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2012 12:04:12 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:62571 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2CJLEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2012 12:04:08 +0100
Received: by bkcjk13 with SMTP id jk13so2351086bkc.36
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2012 03:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Py4cfCsQ8h9x5CYtD2v2fv47xtGnNm8ewYCF81NZUks=;
        b=hD7H3oLlmJdHBm9PlhGoA6qrXy/LTTdUrxw6BTG6tFD2jYv+ixTzKmqPjOO1VB/B7O
         dnHMeE54AgWPIxR0dsE07DcNUSuyJY2IfhdG8X/5evBYA3Se76Nr9ESragNt1bG7db2l
         5Y+eDGPJx82nN+CijHDPFu6vRDcr1lSyaVQN4c5Iy7FDWpuHWaZdVcV8i6irHUDY+0A/
         4EZhXlVYO9D4NjBuGbXCeUiPBw5BRACRkrpgiyGldc4TddoCtohcAwsZvSjHwDH21eId
         FDN5qS4QlXJZE8Dr8tOGNjlH5XpmAo/v1u5GzBvpdob/tJFM8W2W0+bJhfKII0wicJ1J
         reaQ==
Received: by 10.204.156.133 with SMTP id x5mr2142048bkw.86.1331377441470;
        Sat, 10 Mar 2012 03:04:01 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-94-226.pppoe.mtu-net.ru. [91.79.94.226])
        by mx.google.com with ESMTPS id u14sm13995397bkp.2.2012.03.10.03.03.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 03:03:59 -0800 (PST)
Message-ID: <4F5B34CE.5040900@mvista.com>
Date:   Sat, 10 Mar 2012 15:02:38 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Thomas Schwinge <thomas@codesourcery.com>
CC:     unlisted-recipients:; Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 5/7] USB: r8a66597-hcd: restore big-endian operation.
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com> <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQl0nk6RxU2JF1I5YdLaiimQzTAiBe8pKpK5TeI7h5La0a6CCC0mv13kj/My60qg0wOKCdfg
X-archive-position: 32640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 09-03-2012 20:38, Thomas Schwinge wrote:

> On SH, as of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the

    Please also specify the summary of thta commit in parens.

> endianess-agnostic I/O accessor functions.

> This driver is also enabled in ARM's viper_defconfig as well as MIPS'
> bcm47xx_defconfig and fuloong2e_defconfig -- I suppose none of these are
> operating in big-endian mode, or this issue should already have been noticed
> before.

> The device is now recognized correctly for both litte-endian and big-endian
> sh7785lcr, but I have not tested this any further, as the board is situated in
> a remote data center.

> Signed-off-by: Thomas Schwinge<thomas@codesourcery.com>
> Cc: Paul Mundt<lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-usb@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mips@linux-mips.org

WBR, Sergei
