Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2010 18:20:28 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:38076 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490980Ab0JFQUZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Oct 2010 18:20:25 +0200
Received: by qyk9 with SMTP id 9so573263qyk.15
        for <linux-mips@linux-mips.org>; Wed, 06 Oct 2010 09:20:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.224.89.80 with SMTP id d16mr9787398qam.88.1286382018841; Wed,
 06 Oct 2010 09:20:18 -0700 (PDT)
Received: by 10.229.215.132 with HTTP; Wed, 6 Oct 2010 09:20:15 -0700 (PDT)
In-Reply-To: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
References: <1286380758-14063-1-git-send-email-arun.murthy@stericsson.com>
Date:   Wed, 6 Oct 2010 11:20:15 -0500
Message-ID: <AANLkTi=5yrcBPqbtDYRsnXTvhmBaYFemNu04P5ZnzJVM@mail.gmail.com>
Subject: Re: [PATCHv3 0/7] PWM core driver for pwm based led and backlight driver
From:   Bill Gatliff <bgat@billgatliff.com>
To:     Arun Murthy <arun.murthy@stericsson.com>
Cc:     lars@metafoo.de, akpm@linux-foundation.org, kernel@pengutronix.de,
        philipp.zabel@gmail.com, robert.jarzmik@free.fr,
        marek.vasut@gmail.com, eric.y.miao@gmail.com, rpurdie@rpsys.net,
        sameo@linux.intel.com, kgene.kim@samsung.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        STEricsson_nomadik_linux@list.st.com, khilman@deeprootsystems.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <bgat@billgatliff.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bgat@billgatliff.com
Precedence: bulk
X-list: linux-mips

Arun:

On Wed, Oct 6, 2010 at 10:59 AM, Arun Murthy <arun.murthy@stericsson.com> wrote:
> PWM core driver for pwm based led and backlight driver.

With all due respect, it looks like you have reinvented portions of my
RFC for a comprehensive PWM API that has been floating around on
linux-embedded for over a year--- with an update coming in the last
two weeks or so.  Why?

To make matters worse, when I posted my original code I was told to
move the whole discussion to linux-embedded, because as a
cross-platform API proposal that's where it belongs.  I encourage you
do likewise.

I have a terse email style, so I just want to be clear that I'm not
mad or anything.  Honest!  I'm just disappointed that you've invested
so much hard work in traveling down the same path I came over a year
ago.  Bummer for everyone.

Can we not combine our efforts?  I haven't reviewed all of your
patches yet, but you are clearly ahead of me in specific ARM platform
support.  On the other hand, I think my code is more refined in many
other areas.  I also have Blackfin, PowerPC, and Cirrus (ARM) support,
though some of the code is from contributors who are holding it until
I proffer my final code.


What do you think?  Just let me know privately by email, or over on
linux-embedded.


Thanks!


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
