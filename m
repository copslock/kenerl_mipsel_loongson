Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2015 23:44:45 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33944 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012329AbbKXWon0mX7C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2015 23:44:43 +0100
Received: by padhx2 with SMTP id hx2so35631648pad.1;
        Tue, 24 Nov 2015 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=n5at/WnQzaFmWMWspdKHyKY8/pBgdewfyQNwNc2Sx8k=;
        b=XbmEamAPzivE2XGYSdBFUwWkOcSKIulJ7/are9MqCJ+kfl89orvGpg++3aY2mIKwuZ
         B06d7rBkNvxIwwiDmPz1rA8edG54uZ8yxB5fndleQg0hZtHtjpI8CGao8CvrtTf3lQJh
         SZIo+co4OVUANGe/xxXHSnyn6t41iXzMc7Js5EatEONNDMzEQtxslOaEVT7NBoFMcp+C
         UrRZmUotoOB0IKw+KTmwP86l6VhNgnk52eeZzHdmi9kGkbpAV/Gt/ZWi9Lh4JTlUdUKj
         hmtgFDLsePvpbE0lzbaFqVvo/3j/ihs+AAJiwJT8/hBhgHT4VaJcMXbF4/Y0GrW1GyPT
         /aJg==
X-Received: by 10.98.14.8 with SMTP id w8mr26751876pfi.38.1448405077604;
        Tue, 24 Nov 2015 14:44:37 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id sn9sm144942pac.16.2015.11.24.14.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 14:44:37 -0800 (PST)
Message-ID: <5654E814.6030807@gmail.com>
Date:   Tue, 24 Nov 2015 14:43:32 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Simon Arlott <simon@fire.lp0.eu>, linux-watchdog@vger.kernel.org
CC:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft function
References: <5650BFD6.5030700@simon.arlott.org.uk>    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>    <5651CB13.4090704@simon.arlott.org.uk>    <5651CC90.7090402@simon.arlott.org.uk> <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50075
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

On 24/11/15 14:15, Simon Arlott wrote:
> Return the remaining time from the hardware control register.
> 
> Warn when the device is registered if the hardware watchdog is currently
> running and report the remaining time left.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

At some point, we should probably consider merging bcm63xx_wdt with
bcm7038_wdt which are nearly 100% identical pieces of hardware (coming
from the same design group originally).
-- 
Florian
