Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 15:44:41 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:39962 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6819313AbaFINojXiEca convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 15:44:39 +0200
Received: (qmail 8940 invoked from network); 9 Jun 2014 13:44:36 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 9 Jun 2014 13:44:36 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08135-02 for <linux-mips@linux-mips.org>;
 Mon,  9 Jun 2014 14:44:29 +0100 (BST)
Received: (qmail 8868 invoked by uid 599); 9 Jun 2014 13:44:28 -0000
Received: from unknown (HELO AcuExch.aculab.com) (10.202.163.4)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Mon, 09 Jun 2014 14:44:28 +0100
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Mon, 9 Jun 2014 14:43:56 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrzej Hajda' <a.hajda@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ben Dooks <ben@trinity.fluff.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "m@bues.ch" <m@bues.ch>, Linux-sh list <linux-sh@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "patches@opensource.wolfsonmicro.com" 
        <patches@opensource.wolfsonmicro.com>,
        "linux-samsungsoc@vger.kernel.org" <linux-samsungsoc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "spear-devel@list.st.com" <spear-devel@list.st.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Thread-Topic: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Thread-Index: AQHPg+T3C2ikfzU+v0axMk1kdlYMtJtow1QA
Date:   Mon, 9 Jun 2014 13:43:56 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17259A1F@AcuExch.aculab.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
 <5388C0F1.90503@gmail.com> <5388CB1B.3090802@metafoo.de>
 <20140608231823.GB10112@trinity.fluff.org> <53959A93.7080308@metafoo.de>
 <5395B379.2010706@samsung.com>
In-Reply-To: <5395B379.2010706@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

From: Of Andrzej Hajda
...
> > You can't error out on module unload, although that's not really relevant
> > here. gpiochip_remove() is typically called when the device that registered
> > the GPIO chip is unbound. And despite some remove() callbacks having a
> > return type of int you can not abort the removal of a device.
> 
> It is a design flaw in many subsystems having providers and consumers,
> not only GPIO. The same situation is with clock providers, regulators,
> phys, drm_panels, ..., at least it was such last time I have tested it.
> 
> The problem is that many frameworks assumes that lifetime of provider is
> always bigger than lifetime of its consumers, and this is wrong
> assumption - usually it is not possible to prevent unbinding driver from
> device, so if the device is a provider there is no way to inform
> consumers about his removal.
> 
> Some solution for such problems is to use some kind of availability
> callbacks for requesting resources (gpios, clocks, regulators,...)
> instead of simple 'getters' (clk_get, gpiod_get). Callbacks should
> guarantee that the resource is always valid between callback reporting
> its availability and callback reporting its removal. Such approach seems
> to be complicated at the first sight but it should allow to make the
> code safe and as a bonus it will allow to avoid deferred probing.
> Btw I have send already RFC for such framework [1].

Callbacks for delete are generally a locking nightmare.
A two-way handshake is also usually needed to avoid problems
with concurrent disconnect requests.

	David
