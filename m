Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 12:58:48 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52523 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819764Ab3G2K6qXwFqW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jul 2013 12:58:46 +0200
Message-ID: <51F6495D.9000008@phrozen.org>
Date:   Mon, 29 Jul 2013 12:52:13 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
In-Reply-To: <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi Florian,

> It is not clear to me whether this secondary cevt is also a r4k-cevt
> device, or if it is something else? If the IRQ is shared, is there any
> way to differentiate the ralink cevt from the r4k cevt, such that both
> could request the same irq with the IRQF_SHARED flag?
>

IRQF_SHARED | IRQF_TIMER is not allowed as a combination.


> It looks to me like you are moving the irq setup later just to ensure
> that your ralink clockevent device has been registered before and has
> set cp0_timer_irq_installed when the set_mode() r4k clockevent device
> runs, such that it won't register the same IRQ that your platforms
> uses. If that it the case, cannot you just ensure that you run your
> cevt device registration before mips_clockevent_init() is called?

i dont like relying on the order in which the modules get loaded.

the actual problem is not the irq sharing but that the cevt-r4k 
registers the irq when the cevt is registered and not when it is 
activated. i believe that the patch fixes this problem

	John
