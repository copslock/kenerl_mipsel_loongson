Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 23:39:48 +0200 (CEST)
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4573 "EHLO
        smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903299Ab2IBVjl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 23:39:41 +0200
Received: from starbug-2.trinair2002 (dhcp-089-098-069-120.chello.nl [89.98.69.120])
        (authenticated bits=0)
        by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id q82LcqwS052519;
        Sun, 2 Sep 2012 23:38:52 +0200 (CEST)
        (envelope-from maarten@treewalker.org)
Received: from hyperion.localnet (hyperion.trinair2002 [192.168.0.43])
        by starbug-2.trinair2002 (Postfix) with ESMTP id A8FA0401E7;
        Sun,  2 Sep 2012 23:38:51 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/3] MIPS: JZ4740: Move PWM driver to PWM framework
Date:   Sun, 02 Sep 2012 23:34:32 +0200
Message-ID: <1494411.dJ2nCQkPX8@hyperion>
User-Agent: KMail/4.9 (Linux/3.1.10-1.16-desktop; KDE/4.9.0; x86_64; ; )
In-Reply-To: <20120902192752.GA10930@avionic-0098.mockup.avionic-design.de>
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de> <1890769.KjIbOv8Xbz@hyperion> <20120902192752.GA10930@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Virus-Scanned: by XS4ALL Virus Scanner
X-archive-position: 34411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sunday 02 September 2012 21:27:53 Thierry Reding wrote:
> On Sun, Sep 02, 2012 at 03:25:55PM +0200, Maarten ter Huurne wrote:
> > I tested the "for-next" branch on the Dingoo A320 with the pwm-backlight
> > driver. It didn't work at first, because the PWM number and the timer
> > number didn't align: I requested PWM number 5 to get PWM7 and the GPIO
> > of PWM7 was used, but with timer 5 instead of timer 7, resulting in a
> > dark screen. However, it works fine after adding PWM0/1 as described
> > above.
> 
> I haven't seen any usage of the pwm-backlight driver in mainline. I
> assume this is only present in some downstream repository?

Yes, the Dingoo A320 support is currently only available in the qi-kernel 
repository. We have some essential drivers (the SLCD framebuffer driver in 
particular) that are in their current state just too ugly to submit to 
mainline.

> > If other people want to test on real hardware, you can find the code in
> > branch jz-3.6-rc2-pwm in the qi-kernel repository. Unfortunately our web
> > interface for git is still broken, but the repo itself is fine.
> > 
> >   git://projects.qi-hardware.com/qi-kernel.git

This is where you can find the code. The relevant configs are 
qi_lb60_defconfig and a320_defconfig.

> An alternative approach would be to change pwm_chip.base from -1
> (dynamically allocated) to 2, which would leave 0 and 1 unavailable.
> That should at least solve the problem that you had regarding the GPIO
> and timer mismatch.

That could work, but the hardware does have PWM0 and PWM1, which are just 
not available in our kernel, so adding them in busy state would better 
describe real situation.

Maybe at some point we'll have a generic timer framework as well and then 
having PWM0/1 defined but not requestable because the timers are busy would 
be a natural fit.

> But the above also sounds sensible, and since both you and Lars agree
> that this is the better option, I can squash these changes into my patch
> with your permission.

Yes, please do.

Bye,
		Maarten
