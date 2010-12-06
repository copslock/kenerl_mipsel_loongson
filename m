Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 19:02:41 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.8]:49412 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492054Ab0LFSCg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Dec 2010 19:02:36 +0100
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oB6IVFvG014290;
        Mon, 6 Dec 2010 12:31:38 -0600
Received: from localhost (147.117.20.213) by eusaamw0706.eamcs.ericsson.se
 (147.117.20.91) with Microsoft SMTP Server id 8.2.234.1; Mon, 6 Dec 2010
 13:02:03 -0500
Date:   Mon, 6 Dec 2010 10:02:03 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Matt Turner <mattst88@gmail.com>
CC:     Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20101206180203.GA18478@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com>
 <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 06, 2010 at 12:40:15PM -0500, Matt Turner wrote:
> On Mon, Dec 6, 2010 at 5:30 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
> >> From: Maciej W. Rozycki <macro@linux-mips.org>
> >>
> >> This is a rewrite of large parts of the driver mainly so that it uses
> >> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> >> As a part of the overhaul of the init and exit calls, all accesses to the
> >> hardware got converted to use accessory functions via an ioremap() cookie.
> >>
> >> Minimally rebased by Matt Turner.
> >>
> >> Tested-by: Matt Turner <mattst88@gmail.com>
> >> Signed-off-by: Matt Turner <mattst88@gmail.com>
> >
> >
> > I applied the patch to my 1480 tree. Unfortunately, it doesn't work with my system.
> > As far as I can see, the driver does not get any interrupts.
> >
> > My tree is 2.6.32, though. Do you know if I might be missing some other relevant patch ?
> >
> > Thanks,
> > Guenter
> 
> I think this patch depends on
> http://www.linux-mips.org/archives/linux-mips/2010-12/msg00030.html
> 
I did apply the second patch as well, since you had mentioned it in your patch.
That did not help, though. Frankly, I don't see the dependency in the first place - the other 
patch only affects drivers/rtc/rtc-m41t80.c, and I would hope that SMBus support does not depend
on an rtc driver. Am I missing something ?

Thanks,
Guenter
