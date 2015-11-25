Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 21:29:13 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:54623 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012714AbbKYU3MRBhdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 21:29:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=7FmthkAOOhwWdD3E89fLai64EoRRUQ665Z7bCZqT3Aw=;
        b=RB9I6FjSSP+5H4cdKMzryfyfWCXsxi1SQuMBwNq3RekniGV9Ln7D7agFnVHZ45rcO/c3Nh/yVlFihpsAPdWEbhz1bjP2pJ8ech0P0b6YveMZ2dl0kej0JYpMX1wmMsYdFwd+2orcw0PRJ+z1KbYGNvMiGDB5efo1NcprHrZxQDzMlaWOLNLHxvcaQI7fQqdbI9FGMcnH44XY5ReRDsyr18VUcutwJLJTh139fPdvAtPFySw1eyvF//l4GZUsN9Pxv7WmgVcfCr/s3NqO2i0XAiyHOjF1U2L9M7eZ16K5xbOD7d6M/4jLBzXPxjkQtYltlCRhpG/wJGQAnZPHLIcd1g==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44733 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1ggW-0006su-9m (Exim); Wed, 25 Nov 2015 20:29:01 +0000
Subject: Re: [PATCH 4/10] watchdog: bcm63xx_wdt: Handle hardware interrupt and
 remove software timer
To:     Jonas Gorski <jogo@openwrt.org>, Guenter Roeck <linux@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CB9C.4090005@simon.arlott.org.uk>
 <20151124182138.GB12289@roeck-us.net>
 <CAOiHx=kn4NPxxYq0Te_T+8y_Cb1udyU0_EO-_eKp2Xshh7X6EA@mail.gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56561A0B.9020700@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 20:28:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=kn4NPxxYq0Te_T+8y_Cb1udyU0_EO-_eKp2Xshh7X6EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 25/11/15 20:14, Jonas Gorski wrote:
> On Tue, Nov 24, 2015 at 7:21 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On Sun, Nov 22, 2015 at 02:05:16PM +0000, Simon Arlott wrote:
>>> There is a level triggered interrupt for the watchdog timer as part of
>>> the bcm63xx_timer device. The interrupt occurs when the hardware watchdog
>>> timer reaches 50% of the remaining time.
>>>
>>> It is not possible to mask the interrupt within the bcm63xx_timer device.
>>> To get around this limitation, handle the interrupt by restarting the
>>> watchdog with the current remaining time (which will be half the previous
>>> timeout) so that the interrupt occurs again at 1/4th, 1/8th, etc. of the
>>> original timeout value until the watchdog forces a reboot.
>>>
>>> The software timer was restarting the hardware watchdog with a 85 second
>>> timeout until the software timer expired, and then causing a panic()
>>> about 42.5 seconds later when the hardware interrupt occurred. The
>>> hardware watchdog would not reboot until a further 42.5 seconds had
>>> passed.
>>>
>>> Remove the software timer and rely on the hardware timer directly,
>>> reducing the maximum timeout from 256 seconds to 85 seconds
>>> (2^32 / WDT_HZ).
>>>
>>
>> Florian,
>>
>> can you have a look into this patch and confirm that there is no better
>> way to clear the interrupt status ?
> 
> While the watchdog interrupt can't be masked, it should be able to be
> cleared by writing 1 to the appropriate bit in the timer block's
> interrupt status register. At least the broadcom sources do so.

Not according to the hardware itself:
[    6.674626] watchdog watchdog0: warning timer fired, reboot in 7499ms
[    6.681212] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08
[    6.688583] watchdog watchdog0: warning timer fired, reboot in 7486ms
[    6.695181] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08
[    6.702554] watchdog watchdog0: warning timer fired, reboot in 7472ms
[    6.709158] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08
[    6.716529] watchdog watchdog0: warning timer fired, reboot in 7458ms
[    6.723135] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08
[    6.730538] watchdog watchdog0: warning timer fired, reboot in 7444ms
[    6.737121] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08
[    6.744482] watchdog watchdog0: warning timer fired, reboot in 7430ms
[    6.751090] irq_bcm6345_l2_timer: bcm6345_timer_write_int_status: b0000083=08


typedef struct Timer {
    uint16        unused0;
    byte          TimerMask;
#define TIMER0EN        0x01
#define TIMER1EN        0x02
#define TIMER2EN        0x04
    byte          TimerInts;
#define TIMER0          0x01
#define TIMER1          0x02
#define TIMER2          0x04
#define WATCHDOG        0x08
...

-- 
Simon Arlott
