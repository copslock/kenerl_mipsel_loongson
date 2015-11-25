Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 21:14:45 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:41917 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012274AbbKYUOlpwcGp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 21:14:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 6715228BDC6;
        Wed, 25 Nov 2015 21:14:40 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com [209.85.215.45])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5B4D9281091;
        Wed, 25 Nov 2015 21:14:33 +0100 (CET)
Received: by lfs39 with SMTP id 39so71333242lfs.3;
        Wed, 25 Nov 2015 12:14:33 -0800 (PST)
X-Received: by 10.112.137.66 with SMTP id qg2mr16038664lbb.41.1448482473144;
 Wed, 25 Nov 2015 12:14:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.162.78 with HTTP; Wed, 25 Nov 2015 12:14:13 -0800 (PST)
In-Reply-To: <20151124182138.GB12289@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk> <5650C08C.6090300@simon.arlott.org.uk>
 <5650E2FA.6090408@roeck-us.net> <5650E5BB.6020404@simon.arlott.org.uk>
 <56512937.6030903@roeck-us.net> <5651CB13.4090704@simon.arlott.org.uk>
 <5651CB9C.4090005@simon.arlott.org.uk> <20151124182138.GB12289@roeck-us.net>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 25 Nov 2015 21:14:13 +0100
X-Gmail-Original-Message-ID: <CAOiHx=kn4NPxxYq0Te_T+8y_Cb1udyU0_EO-_eKp2Xshh7X6EA@mail.gmail.com>
Message-ID: <CAOiHx=kn4NPxxYq0Te_T+8y_Cb1udyU0_EO-_eKp2Xshh7X6EA@mail.gmail.com>
Subject: Re: [PATCH 4/10] watchdog: bcm63xx_wdt: Handle hardware interrupt and
 remove software timer
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Simon Arlott <simon@fire.lp0.eu>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Tue, Nov 24, 2015 at 7:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Nov 22, 2015 at 02:05:16PM +0000, Simon Arlott wrote:
>> There is a level triggered interrupt for the watchdog timer as part of
>> the bcm63xx_timer device. The interrupt occurs when the hardware watchdog
>> timer reaches 50% of the remaining time.
>>
>> It is not possible to mask the interrupt within the bcm63xx_timer device.
>> To get around this limitation, handle the interrupt by restarting the
>> watchdog with the current remaining time (which will be half the previous
>> timeout) so that the interrupt occurs again at 1/4th, 1/8th, etc. of the
>> original timeout value until the watchdog forces a reboot.
>>
>> The software timer was restarting the hardware watchdog with a 85 second
>> timeout until the software timer expired, and then causing a panic()
>> about 42.5 seconds later when the hardware interrupt occurred. The
>> hardware watchdog would not reboot until a further 42.5 seconds had
>> passed.
>>
>> Remove the software timer and rely on the hardware timer directly,
>> reducing the maximum timeout from 256 seconds to 85 seconds
>> (2^32 / WDT_HZ).
>>
>
> Florian,
>
> can you have a look into this patch and confirm that there is no better
> way to clear the interrupt status ?

While the watchdog interrupt can't be masked, it should be able to be
cleared by writing 1 to the appropriate bit in the timer block's
interrupt status register. At least the broadcom sources do so.


Jonas
