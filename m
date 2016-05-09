Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 15:06:50 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:43159 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028413AbcEINGpTWnhR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 15:06:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=taE5i8TT5+vboklpSUuTRRDudZmAgTs7um2mT4CvDWw=; b=eOaokkUSTCiZndfr/IPSu3l+YM
        +/40cscd3JTVXCl2WJvqQ45MroJv64bKp34eUfpL+7/0tFSed73hxGqvtApg9kZwhE1/ip7naoJjv
        HnaFn3uNv4WPTXlXp29OjXM0pF9OsmQ11OGrRsKQ6M2+g5pRob3/QJDIa+bR0YM+RBGAbkDk6lG70
        U4qplwyKQpLOWWorCqDjOMxA17fHUYIg3bFF6dSzZ3GXCZ/56jDItN+IVRofqOnK+to5+FY5BT6a2
        AsFJ2HljFuPI2ZDMWpxXE8k6qg2GUAypVJoKzkJsEHJdZ/4Y7+u0UmZU/VB4o/WBHns/nJ0qUbXKC
        nWiozVpw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:59784 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1azksv-001i25-Vq; Mon, 09 May 2016 13:06:08 +0000
Subject: Re: [PATCH (v5) 3/11] MIPS: bmips: Add bcm6345-l2-timer interrupt
 controller
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Simon Arlott <simon@fire.lp0.eu>,
        Thomas Gleixner <tglx@linutronix.de>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <CAOiHx=k0Aa+qrBT1J7_cQaQRxndBmwsgSgi3x0eJOYTAy6Zq7Q@mail.gmail.com>
 <5653612A.4050309@simon.arlott.org.uk> <565361AF.20400@simon.arlott.org.uk>
 <70d031ae4c3aa29888d77b64686c39e7e7eaae92@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5654E67A.9060800@gmail.com> <5657886F.3090908@simon.arlott.org.uk>
 <alpine.DEB.2.11.1511270926580.3572@nanos>
 <56599D73.7040801@simon.arlott.org.uk> <565CE85A.3080904@roeck-us.net>
 <256BE4660FB03085.33070B6A-E0AC-4643-92B8-4FD874210CD9@mail.outlook.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-watchdog@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <57308B3D.3020502@roeck-us.net>
Date:   Mon, 9 May 2016 06:06:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <256BE4660FB03085.33070B6A-E0AC-4643-92B8-4FD874210CD9@mail.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 05/09/2016 05:01 AM, Álvaro Fernández Rojas wrote:
> Hello Guenter,
>
> Are there any other issues preventing this patches from being merged?
>

My major problem/concern is the interrupt handling and the repeated
restart of the hardware timer with continuously reduced timeouts.
This appears fragile, and it doesn't really make sense from a system
level point of view. Unfortunately, I don't have a data sheet for
the chip, nor the means or the time to test it myself. So we are pretty
much in limbo, unless someone from Broadcom confirms that, yes, this is
the one and expected means to program this watchdog.

Guenter

> Regards,
> Álvaro.
> _____________________________
> From: Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>>
> Sent: martes, diciembre 1, 2015 1:23 a. m.
> Subject: Re: [PATCH (v5) 3/11] MIPS: bmips: Add bcm6345-l2-timer interrupt controller
> To: Simon Arlott <simon@fire.lp0.eu <mailto:simon@fire.lp0.eu>>, Thomas Gleixner <tglx@linutronix.de <mailto:tglx@linutronix.de>>
> Cc: Ralf Baechle <ralf@linux-mips.org <mailto:ralf@linux-mips.org>>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>>, Mark Rutland <mark.rutland@arm.com <mailto:mark.rutland@arm.com>>, Florian Fainelli <f.fainelli@gmail.com <mailto:f.fainelli@gmail.com>>, Ian Campbell <ijc+devicetree@hellion.org.uk <mailto:ijc+devicetree@hellion.org.uk>>, Kevin Cernekee <cernekee@gmail.com <mailto:cernekee@gmail.com>>, MIPS Mailing List <linux-mips@linux-mips.org <mailto:linux-mips@linux-mips.org>>, Kumar Gala <galak@codeaurora.org <mailto:galak@codeaurora.org>>, Miguel Gaio <miguel.gaio@efixo.com <mailto:miguel.gaio@efixo.com>>, Jonas Gorski <jogo@openwrt.org <mailto:jogo@openwrt.org>>, Marc Zyngier <marc.zyngier@arm.com <mailto:marc.zyngier@arm.com>>, Pawel Moll <pawel.moll@arm.com <mailto:pawel.moll@arm.com>>, Rob Herring <robh+dt@kernel.org <mailto:robh+dt@kernel.org>>, <devicetree@vger.kernel.org <mailto:devicetree@vger.kernel.org>>, Maxime
> Bizon <mbizon@freebox.fr <mailto:mbizon@freebox.fr>>, Wim Van Sebroeck <wim@iguana.be <mailto:wim@iguana.be>>, <linux-watchdog@vger.kernel.org <mailto:linux-watchdog@vger.kernel.org>>, Jason Cooper <jason@lakedaemon.net <mailto:jason@lakedaemon.net>>
>
>
> On 11/28/2015 04:26 AM, Simon Arlott wrote:
>  > Add the BCM6345/BCM6318 timer as an interrupt controller so that it can be
>  > used by the watchdog to warn that its timer will expire soon.
>  >
>  > Support for clocksource/clockevents is not implemented as the timer
>  > interrupt is not per CPU (except on the BCM6318) and the MIPS clock is
>  > better. This could be added later if required without changing the device
>  > tree binding.
>  >
>  > Signed-off-by: Simon Arlott <simon@fire.lp0.eu <mailto:simon@fire.lp0.eu>>
>
> Hi Simon,
>
> can you please re-send the entire series, with all Acked-by:/Reviewed-by:
> tags as appropriate ?
>
> Thanks,
> Guenter
>
>
>
>
