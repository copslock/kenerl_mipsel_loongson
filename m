Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 19:26:03 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49028 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011621AbaJPR0B5NhLu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 19:26:01 +0200
Received: by mail-pd0-f172.google.com with SMTP id ft15so3605861pdb.31
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jFf1293fRut8hxybsiSdQ0nzn76CJkaMGhSD4gS0374=;
        b=zvBJ+UOnE5sM+rAIX8d5kawGCQNlOscFPkR3qyowpb62XtcYw86/yHjZS1lr3PtLeV
         EG2B0/IGveITugRIG5+28dtIqPjvxp23tv6NpDTtVDWGhjAQ++Y6WdnN1Ip9kFeUQURt
         N7lGC/ZUe/GOpifDz6p1OuaAs5V0o4yEp7gv+kUm+Hxrm/IAfdm/hHs5u6ihC3KjyKTS
         IFtkgL+u2rmizQdvGR1d8h6ksGr3aW2BjgYmEa15PTCxtRkBkBYZh6ueAqxOFFih6e9d
         3+NWCwFeSv++m1WhTtJIfjT2YONmYpw0oCuEpijK/QtRAbUJxxzny/Ivwm1hIYc5VH8G
         nmUw==
X-Received: by 10.70.45.40 with SMTP id j8mr2889136pdm.130.1413480355234;
        Thu, 16 Oct 2014 10:25:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by mx.google.com with ESMTPSA id z13sm20210662pbt.74.2014.10.16.10.25.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Oct 2014 10:25:54 -0700 (PDT)
Date:   Thu, 16 Oct 2014 10:25:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V2] watchdog: add MT7621 watchdog support
Message-ID: <20141016172550.GA25222@roeck-us.net>
References: <1413454099-2836-1-git-send-email-blogic@openwrt.org>
 <543FCC94.1020102@roeck-us.net>
 <543FCE70.80201@openwrt.org>
 <20141016151742.GA17084@roeck-us.net>
 <543FF3F1.7050800@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543FF3F1.7050800@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43308
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

On Thu, Oct 16, 2014 at 06:36:01PM +0200, John Crispin wrote:
> 
> On 16/10/2014 17:17, Guenter Roeck wrote:
> > On Thu, Oct 16, 2014 at 03:56:00PM +0200, John Crispin wrote:
> >> Hi
> >>
> >>
> >>
> >> On 16/10/2014 15:48, Guenter Roeck wrote:
> >>> On 10/16/2014 03:08 AM, John Crispin wrote:
> >>>> This patch adds support for the watchdog core found on newer 
> >>>> mediatek/ralink Wifi SoCs.
> >>>>
> >>>> Signed-off-by: John Crispin <blogic@openwrt.org> --- Changes 
> >>>> since V1
> >>>>
> >>>> * fix the comments identifying the driver * add a comment to the 
> >>>> code setting the prescaler * use watchdog_init_timeout * use 
> >>>> devm_reset_control_get * get rid of the miscdev code
> >>>>
> >>>> .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++ 
> >>>> drivers/watchdog/Kconfig                           |    7 + 
> >>>> drivers/watchdog/Makefile                          |    1 + 
> >>>> drivers/watchdog/mt7621_wdt.c                      |  186 
> >>>> ++++++++++++++++++++ 4 files changed, 206 insertions(+) create 
> >>>> mode 100644 
> >>>> Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt create 
> >>>> mode 100644 drivers/watchdog/mt7621_wdt.c
> >>>>
> >>>> diff --git 
> >>>> a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt 
> >>>> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt new 
> >>>> file mode 100644 index 0000000..c15ef0e --- /dev/null +++ 
> >>>> b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt @@ 
> >>>> -0,0 +1,12 @@ +Ralink Watchdog Timers + +Required properties: +- 
> >>>> compatible: must be "mediatek,mt7621-wdt" +- reg: physical base 
> >>>> address of the controller and length of the register range + 
> >>>> +Example: + +    watchdog@100 { +        compatible = 
> >>>> "mediatek,mt7621-wdt"; +        reg = <0x100 0x10>; +    }; diff 
> >>>> --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >>>> index f57312f..9ee0d32 100644 --- a/drivers/watchdog/Kconfig +++ 
> >>>> b/drivers/watchdog/Kconfig @@ -1186,6 +1186,13 @@ config 
> >>>> RALINK_WDT help Hardware driver for the Ralink SoC Watchdog 
> >>>> Timer.
> >>>>
> >>>> +config MT7621_WDT +    tristate "Mediatek SoC watchdog" + select
> >>>> WATCHDOG_CORE +    depends on SOC_MT7620 || SOC_MT7621
> >>> There is no SOC_MT7621 symbol, at least not in the current kernel.
> >> the answer has not changed since last time. the patches are sitting in
> >> the linux-mips patchwork.
> >>
> >>
> >>
> >>>> +    help +      Hardware driver for the Mediatek/Ralink SoC 
> >>>> Watchdog Timer. +
> >>> How about mentioning the supported chips (7620 ? 7621 ? 7628 ?)
> >> ok
> >>
> >>>> # PARISC Architecture
> >>>>
> >>>> # POWERPC Architecture diff --git a/drivers/watchdog/Makefile 
> >>>> b/drivers/watchdog/Makefile index 468c320..5b2031e 100644 --- 
> >>>> a/drivers/watchdog/Makefile +++ b/drivers/watchdog/Makefile @@ 
> >>>> -138,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o 
> >>>> octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o 
> >>>> obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
> >>>> obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> >>>> +obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
> >>>>
> >>>> # PARISC Architecture
> >>>>
> >>>> diff --git a/drivers/watchdog/mt7621_wdt.c 
> >>>> b/drivers/watchdog/mt7621_wdt.c new file mode 100644 index 
> >>>> 0000000..0cb9e0b --- /dev/null +++ 
> >>>> b/drivers/watchdog/mt7621_wdt.c @@ -0,0 +1,186 @@ +/* + * Ralink 
> >>>> MT7621/MT7628 built-in hardware watchdog timer + *
> >>> MT7628 or MT7620 ?
> >>>
> >> MT7621 and MT7628 as it says there. the mt7628 is a subtype of mt7620.
> >> it is the same core with slightly different peripherals. this is
> >> covered by the SOC_MT7620. there i a patch for this inside the
> >> linux-mips patchwork.
> >>
> >> shall i resend a V3 only with the "How about mentioning the supported
> >> chips (7620 ? 7621 ? 7628 ?)" fixed ?
> >>
> > Yes, that would be great. Also, it might be useful to mention that the 
> > patch(es) to add support for 7621 are pending in linux-mips. Mention it
> > after ---, so the information is not added to the commit log.
> >
> > Question is how to proceed. Are the 7621 patches going into 3.18
> > or 3.19 ?
> >
> > Thanks,
> > Guenter
> 
> Hi Guenter,
> 
> i a hoping for 3.18. would you mind if we have this patch flow via the
> linux-mips tree with the rest of the patches once you added your SoB ?
> i will most likely setup a tree for Ralf to pull from. I am already on
> 55 patches and i have another ~50 to go. might be easier if we resolve
> the merge order mess by having the whole MT7621/8 patches flow via 1 tree.
> 
I tend to agree, but that will be up to Wim to decide. I am just the guy
who reviews many of the watchdog patches, not the maintainer.

Guenter
