Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2015 23:43:52 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33031 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012329AbbKXWnudRveC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2015 23:43:50 +0100
Received: by pabfh17 with SMTP id fh17so36648835pab.0;
        Tue, 24 Nov 2015 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2CHqNq2wRjkymuTwfiJJ/EzF3qh5IDzsgamZ6TMolAs=;
        b=dHTNcqwxpDR7CdBUbRicsh/mbVYlVfNPF1qFs+pF3hcI7+8dOL/+XzI9Nt+fQgeAZK
         gmR73mQDL0QHt+4D+2iOx5WL+rtJF6l8PltjjrDSf9RtHNNrbHFkknYIR3sswvEQB+ps
         7MEHoEvbsRgXY6TUs6aaS9DyEX7TW0vXoQvIH+mR20YKzcAdb+kk7i5wGrYt6+4UFhEO
         HxF4WHEVdzKXHp02TQKjKigUEfEhn7ISv/7ASr1trtbLrAXhoorEj4KBCuiaDcKuyQYs
         s3D4j1rJIXf0fUiEOiHqr7F/nD1m+IYvgHWmMRx//EyvwWMceKFzr/krt8HMIx47clZe
         vifQ==
X-Received: by 10.98.15.76 with SMTP id x73mr25877052pfi.81.1448405024610;
        Tue, 24 Nov 2015 14:43:44 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id qy7sm16929749pab.37.2015.11.24.14.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2015 14:43:43 -0800 (PST)
Message-ID: <5654E7DE.4020400@gmail.com>
Date:   Tue, 24 Nov 2015 14:42:38 -0800
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
Subject: Re: [PATCH (v2) 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock
 HZ from "periph" clk
References: <5650BFD6.5030700@simon.arlott.org.uk>    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>    <5651CB13.4090704@simon.arlott.org.uk>    <5651CC3C.5090200@simon.arlott.org.uk> <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <38e0094262a1f609b95697730137fb81dc83fcea@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50074
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

On 24/11/15 14:12, Simon Arlott wrote:
> Instead of using a fixed clock HZ in the driver, obtain it from the
> "periph" clk that the watchdog timer uses.
> 
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
