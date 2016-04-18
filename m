Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 16:41:35 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.134]:53129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026884AbcDROldSOGbl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 16:41:33 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0Mgrky-1b5HMD0uxc-00M4S9; Mon, 18 Apr
 2016 16:41:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Alban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] phy: Add a driver for simple phy
Date:   Mon, 18 Apr 2016 16:40:58 +0200
Message-ID: <10235833.eh3J2kCBDh@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <5714D35B.8000208@ti.com>
References: <1447708924-15076-1-git-send-email-albeu@free.fr> <4848615.OezLJod6Cv@wuerfel> <5714D35B.8000208@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:XdfQNFUr9ZZrJWp4D2hz58vjcgbZSiGA34XlAYnzCCWwbwiopEC
 qa6YcdqUiz+gNuMs86VazNmC3e5gI40K6uckS4qkdhmceXsi8OKHE9H3uJ6APqrnhTtIkEJ
 occ8O5hRjnfsvfebAssXZgj9u7O/6VHhO4n6EHNw/ewZzU6zpbN0WQ7dVk1hC3DVsBWBWeh
 GAO+smVh7Inb9DExW32Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ti9sGP86Rr8=:UwO1+OGvV21TqjonXh9RHx
 +myKaMpADaLN5tZyN7r82vgoq6BErHYclEpJTSxD9VtlXddU05JDuEef/vxoOopFuqU/ZEewC
 MHM5tltnLH3aW8T2S/sVc1suMsYbg9znAp2DVkBrAfr4HWa3C5jaRFZcAcZCSm+ule8jrYo16
 I1ETIUYOCWM2AvUWOlODnIeBumzl9XK1cUECGXVbt+/PLRLNR9QBg5x5RACq++/UXQhL+Kbar
 hFrP9WlrC3n/+PJKmqzgWO98xNtlUVEgpoIgE077wi1ECYxHe7pj0kbNIoJOyNsfklpJcB283
 tpmplJngTUhNGb1NKgGs4vJOuWvgzbYXi6MQmwoDgXWU6T6Qy3X4vbUMrRQC9Y2PT+IXdY1IN
 +1K2kLNYIQpvDtIHCHVWvGwb634pvRrnv0d+p8ZRpzOwpLrFbtXEicGvfiLTyIm/+A7E1QAI/
 2KJPok7z+v7z+zF4rsbPVSzIRFAodrQUYlSKep7CKklKWB4D1VczQeAnyP8MPQ3MZv24b82wb
 uh0iLmkoyheJIOJiJwVl3+nnf7xyRguD/dJAJEgNQh9wHabL9Nsifi/8C0/HLBU/VUkytzbbb
 /iXUvGlV5ip1BvA65KoyG++PnjJyW/iv5n8nvtYZFJUQkkGIEDpVEmIZC2JMj/w1DN4MatjhW
 6uDG5kgKiKfn5OQcpHZtDz0zFWhYhZoIA3LjNE7z+pgOW8jlVXCTycr8AZ1XQFhOBDI/rfU8R
 SsUoEp+ycq120SQf
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Monday 18 April 2016 18:00:19 Kishon Vijay Abraham I wrote:
> Hi Arnd,
> 
> On Sunday 17 April 2016 01:20 AM, Arnd Bergmann wrote:
> > On Thursday 14 April 2016 11:22:58 Kishon Vijay Abraham I wrote:
> >>
> >> IMO simple-phy driver should be an independent driver and shouldn't export
> >> symbols. The dt binding for the simple phy device should be something like
> >> below where all the properties of the simple phy device should be in the
> >> binding documentation.
> >> usbphy {
> >>         compatible = "simple-phy";
> >>         phy-supply = <&supply>;
> >>         clocks = <&clock>;
> >>         reset = <&reset>;
> >> };
> >>
> >> Anything that needs more than this shouldn't be a simple phy.
> > 
> > I think there are two aspects here:
> > 
> > a) I agree that a driver that matches "simple-phy" should only call
> >    the generic functions and not use any other properties.
> > 
> > b) Independent of that, I think that it makes a lot of sense to export
> >    those functions from the generic PHY subsystems so they can be
> >    called from drivers that are a little less generic, or that already
> >    have an established binding but need no other code.
> 
> These export functions can be abused and called directly from the controller
> driver bypassing the phy core.
> 
> Actually lot of generic PHY programming are done in the phy-core itself. (For
> example, the generic PHY regulator binding "phy-supply" can be used for the phy
> core to enable the regulator during power on and disable during power off, phy
> core also invokes pm_runtime API's during power_on and power_off which can be
> used to enable/disable clocks). So drivers which are less generic can just
> populate their specific handling part in their phy ops and leave the rest to be
> done in phy core.
> "simple-phy" should be used to avoid adding new PHY drivers that does simple
> PHY ops.

Having the phy core do everything automatically indeed sounds superior here,
the simple-phy driver can then become a trivial stub without any calls
into the regulator/clk/reset subsystems. If that works (or can be made to
work), that's great.

	Arnd
