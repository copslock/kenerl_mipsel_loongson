Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2016 11:22:24 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33402 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028789AbcENJWWHAUSm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2016 11:22:22 +0200
Received: by mail-wm0-f67.google.com with SMTP id r12so8058121wme.0
        for <linux-mips@linux-mips.org>; Sat, 14 May 2016 02:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOTYTalEGosSySnjnj47AMdgXs58EGjniS35J5prwqE=;
        b=taGpuDgTrlCgCsRidE68ms73nYmVBVatYlisflqZxWLam84Cq9BiRdzFB/sbMxvKrH
         CZ2+8HKXL9CRDnjdHcCZ0eQ4ykkmz2jDay5P3TiE/l/kL/OOvanRa8J51BEAtfbKO9kV
         k60bV8SnqEu8grOIwqJjBHgwfEOt82IP79YpVltNQ+X7LAOrg8NONEwZG+yNiUtKZkNb
         8SsGcnCHay3XyW5EdvV9wlukarsAvUo8Jr6W8Jyu9UfmoKfdsWtrQ4d3tmsaIAiPinlk
         Tngfbmqqe5Cxq9WM3EXcSp8xETDJSTqtGGNh2AXVPNBKTwsbz/YgVz4PNi9SOwevN8iv
         KHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZOTYTalEGosSySnjnj47AMdgXs58EGjniS35J5prwqE=;
        b=ZDxt8cloKuGLabrUlZRNCO/1DKMbBIUG26nLCp/fRH9Sj+Ee8XgUTtPJ+583chU3u4
         5V4qQsrmC9jkekpAZdyn07uEMK3CITBu0RwxXRVITt/4k2j0ljZ2ck4V6PjRaOQQeTRb
         u6Q7rbOoL0gat8GJ075ZgAQGQp9+i/5XW4+SqzJvYN7a2lRZelHic7HOU4w37Bj6SCmI
         VZjAT7RryPfSf0QjIZKxN/elQ2v4qYaIXsRNknQMHTi1Yu9V3sNNwljmivPtcceKSH2Z
         e4ds4TCgXbDpGvsJma8OSRdMrd0LHb9BYYeO9Eg1tiyEMP6YvYThkUpUgfOFZWTl6vHG
         NDpQ==
X-Gm-Message-State: AOPr4FVHhEAZaNxyK6q3bnlQmz1CYb7Y2jJ6J+qCxF2QnEXtiyCLKf3LoW0l3YBcsL2JSw==
X-Received: by 10.28.125.138 with SMTP id y132mr7891098wmc.90.1463217736769;
        Sat, 14 May 2016 02:22:16 -0700 (PDT)
Received: from debian64.daheim (pD9F8A692.dip0.t-ipconnect.de. [217.248.166.146])
        by smtp.googlemail.com with ESMTPSA id ck9sm22796331wjc.22.2016.05.14.02.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 May 2016 02:22:15 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.87)
        (envelope-from <chunkeey@googlemail.com>)
        id 1b1Vm1-0008Fc-2L; Sat, 14 May 2016 11:22:13 +0200
From:   Christian Lamparter <chunkeey@googlemail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Sat, 14 May 2016 11:22:12 +0200
Message-ID: <6179749.eyWcSy75sL@debian64>
User-Agent: KMail/4.14.10 (Linux/4.6.0-rc5-wt; KDE/4.14.14; x86_64; ; )
In-Reply-To: <1463147559-544140-1-git-send-email-arnd@arndb.de>
References: <1463147559-544140-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <chunkeey@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chunkeey@googlemail.com
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

On Friday, May 13, 2016 03:52:27 PM Arnd Bergmann wrote:
> A patch that went into Linux-4.4 to fix big-endian mode on a Lantiq
> MIPS system unfortunately broke big-endian operation on PowerPC
> APM82181 as reported by Christian Lamparter, and likely other
> systems.
> 
> It actually introduced multiple issues:
> 
> - it broke big-endian ARM kernels: any machine that was working
>   correctly with a little-endian kernel is no longer using byteswaps
>   on big-endian kernels, which clearly breaks them.
> - On PowerPC the same thing must be true: if it was working before,
>   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
>   usually uses big-endian kernels, so they are likely all broken.
> - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
>   so the MMIO no longer synchronizes with DMA operations.
> - On architectures that require specific CPU instructions for MMIO
>   access, using the __raw_ variant may turn this into a pointer
>   dereference that does not have the same effect as the readl/writel.
> 
> This patch is a simple revert for all architectures other than MIPS,
> in the hope that we can more easily backport it to fix the regression
> on PowerPC and ARM systems without breaking the Lantiq system again.
> 
> We should follow this up with a more elaborate change to add runtime
> detection of endianness, to make sure it also works on all other
> combinations of architectures and implementations of the usb-dwc2
> device. That patch however will be fairly large and not appropriate
> for backports to stable kernels.
> 
> Felipe suggested a different approach, using an endianness switching
> register to always put the device into LE mode, but unfortunately
> the dwc2 hardware does not provide a generic way to do that. Also,
> I see no practical way of addressing the problem more generally by
> patching architecture specific code on MIPS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
Thanks Arnd,

Tested-by: Christian Lamparter <chunkeey@googlemail.com>

dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
dwc2 4bff80000.usbotg: DWC OTG Controller
dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected

Regards,
Christian
