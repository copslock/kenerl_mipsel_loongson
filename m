Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 May 2014 03:09:00 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46646 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820484AbaEaBI61U3fG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 May 2014 03:08:58 +0200
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
        by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 95DD221061
        for <linux-mips@linux-mips.org>; Fri, 30 May 2014 21:08:56 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 30 May 2014 21:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=H6hY2X3/GVQAdtxNYu1HS121+zQ=; b=ZI/05HJ9bQDDOFwlT42hHsTRiDYI
        ckTH4/N4gX7xW7QeFXWQt8IK5MbTnkYnjJIRECTkv/9end2hkn8rANt2VmYElkMH
        x5hxZEB/t9aoibUZ4Y7ZuQPLHGVpROSJ7cFi/ijm23DC+cC0leV5EKfEzFhl9X+o
        0ZopGpc/dW+2BF4=
X-Sasl-enc: mG3HOIbkp/gHuYYZ+YnlGJBjY8DMXOaWrduuGzgdh+Yy 1401498536
Received: from localhost (unknown [76.28.255.20])
        by mail.messagingengine.com (Postfix) with ESMTPA id 06AFAC00003;
        Fri, 30 May 2014 21:08:56 -0400 (EDT)
Date:   Fri, 30 May 2014 16:29:22 -0700
From:   Greg KH <greg@kroah.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Alexandre Courbot <gnurou@gmail.com>,
        patches@opensource.wolfsonmicro.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        spear-devel@list.st.com, linux-samsungsoc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        m@bues.ch,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        abdoulaye berthe <berthe.ab@gmail.com>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Message-ID: <20140530232922.GD25854@kroah.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
 <5388C0F1.90503@gmail.com>
 <5388CB1B.3090802@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5388CB1B.3090802@metafoo.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Fri, May 30, 2014 at 08:16:59PM +0200, Lars-Peter Clausen wrote:
> On 05/30/2014 07:33 PM, David Daney wrote:
> >On 05/30/2014 04:39 AM, Geert Uytterhoeven wrote:
> >>On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com>
> >>wrote:
> >>>--- a/drivers/gpio/gpiolib.c
> >>>+++ b/drivers/gpio/gpiolib.c
> >>>@@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct
> >>>gpio_chip *gpiochip);
> >>>   *
> >>>   * A gpio_chip with any GPIOs still requested may not be removed.
> >>>   */
> >>>-int gpiochip_remove(struct gpio_chip *chip)
> >>>+void gpiochip_remove(struct gpio_chip *chip)
> >>>  {
> >>>         unsigned long   flags;
> >>>-       int             status = 0;
> >>>         unsigned        id;
> >>>
> >>>         acpi_gpiochip_remove(chip);
> >>>@@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
> >>>         of_gpiochip_remove(chip);
> >>>
> >>>         for (id = 0; id < chip->ngpio; id++) {
> >>>-               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
> >>>-                       status = -EBUSY;
> >>>-                       break;
> >>>-               }
> >>>-       }
> >>>-       if (status == 0) {
> >>>-               for (id = 0; id < chip->ngpio; id++)
> >>>-                       chip->desc[id].chip = NULL;
> >>>-
> >>>-               list_del(&chip->list);
> >>>+               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> >>>+                       panic("gpio: removing gpiochip with gpios still
> >>>requested\n");
> >>
> >>panic?
> >
> >NACK to the patch for this reason.  The strongest thing you should do here
> >is WARN.
> >
> >That said, I am not sure why we need this whole patch set in the first place.
> 
> Well, what currently happens when you remove a device that is a provider of
> a gpio_chip which is still in use, is that the kernel crashes. Probably with
> a rather cryptic error message. So this patch doesn't really change the
> behavior, but makes it more explicit what is actually wrong. And even if you
> replace the panic() by a WARN() it will again just crash slightly later.
> 
> This is a design flaw in the GPIO subsystem that needs to be fixed.

Then fix the GPIO code properly, don't add a new panic() to the kernel.

greg k-h
