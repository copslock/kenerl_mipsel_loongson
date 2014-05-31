Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 May 2014 14:20:13 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:23784 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821091AbaEaMULJJY6c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 May 2014 14:20:11 +0200
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s4VCJeph009090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 31 May 2014 12:19:41 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
        by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s4VCJWis022073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 31 May 2014 12:19:32 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s4VCJVLO022070;
        Sat, 31 May 2014 12:19:31 GMT
Received: from mwanda (/41.202.240.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 31 May 2014 05:19:30 -0700
Date:   Sat, 31 May 2014 15:19:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Greg KH <greg@kroah.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        patches@opensource.wolfsonmicro.com,
        linux-samsungsoc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        spear-devel@list.st.com,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        m@bues.ch,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Message-ID: <20140531121914.GM15585@mwanda>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
 <5388C0F1.90503@gmail.com>
 <5388CB1B.3090802@metafoo.de>
 <20140530232922.GD25854@kroah.com>
 <5389864B.4000107@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5389864B.4000107@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Sat, May 31, 2014 at 09:35:39AM +0200, Lars-Peter Clausen wrote:
> On 05/31/2014 01:29 AM, Greg KH wrote:
> >On Fri, May 30, 2014 at 08:16:59PM +0200, Lars-Peter Clausen wrote:
> >>On 05/30/2014 07:33 PM, David Daney wrote:
> >>>On 05/30/2014 04:39 AM, Geert Uytterhoeven wrote:
> >>>>On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com>
> >>>>wrote:
> >>>>>--- a/drivers/gpio/gpiolib.c
> >>>>>+++ b/drivers/gpio/gpiolib.c
> >>>>>@@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct
> >>>>>gpio_chip *gpiochip);
> >>>>>   *
> >>>>>   * A gpio_chip with any GPIOs still requested may not be removed.
> >>>>>   */
> >>>>>-int gpiochip_remove(struct gpio_chip *chip)
> >>>>>+void gpiochip_remove(struct gpio_chip *chip)
> >>>>>  {
> >>>>>         unsigned long   flags;
> >>>>>-       int             status = 0;
> >>>>>         unsigned        id;
> >>>>>
> >>>>>         acpi_gpiochip_remove(chip);
> >>>>>@@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
> >>>>>         of_gpiochip_remove(chip);
> >>>>>
> >>>>>         for (id = 0; id < chip->ngpio; id++) {
> >>>>>-               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
> >>>>>-                       status = -EBUSY;
> >>>>>-                       break;
> >>>>>-               }
> >>>>>-       }
> >>>>>-       if (status == 0) {
> >>>>>-               for (id = 0; id < chip->ngpio; id++)
> >>>>>-                       chip->desc[id].chip = NULL;
> >>>>>-
> >>>>>-               list_del(&chip->list);
> >>>>>+               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> >>>>>+                       panic("gpio: removing gpiochip with gpios still
> >>>>>requested\n");
> >>>>
> >>>>panic?
> >>>
> >>>NACK to the patch for this reason.  The strongest thing you should do here
> >>>is WARN.
> >>>
> >>>That said, I am not sure why we need this whole patch set in the first place.
> >>
> >>Well, what currently happens when you remove a device that is a provider of
> >>a gpio_chip which is still in use, is that the kernel crashes. Probably with
> >>a rather cryptic error message. So this patch doesn't really change the
> >>behavior, but makes it more explicit what is actually wrong. And even if you
> >>replace the panic() by a WARN() it will again just crash slightly later.
> >>
> >>This is a design flaw in the GPIO subsystem that needs to be fixed.
> >
> >Then fix the GPIO code properly, don't add a new panic() to the kernel.
> 
> Until somebody comes up with a patch that fixes this for good I
> think that patch is still an improvement over the current situation.
> Rather than keeping the kernel running in a inconsistent state,
> which might cause all kinds of undefined behavior and which will
> lead to a crash eventually, we might as well just crash the kernel
> at the cause of the inconsistent state. This will make it obvious
> why it crashed (compared to a random stacktrace) and will also
> prevent the kernel from running in a undefined state.
> 

Really, adding a panic here is not ok.  With a WARN() then you have
time to save the dmesg to a file.

This CC list is way too huge.  We're all wondering how often this stuff
crashes anyway?  Have you tried to fix the bug instead of just calling
panic()?  Is there a bugzilla entry or something?  Is there a thread on
the list?

Just add a WARN() and fix the bug then cleanup the error handling.

regards,
dan carpenter
