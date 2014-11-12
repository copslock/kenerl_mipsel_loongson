Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:19:57 +0100 (CET)
Received: from mail-qa0-f54.google.com ([209.85.216.54]:43708 "EHLO
        mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013510AbaKLJTvbzkDI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:19:51 +0100
Received: by mail-qa0-f54.google.com with SMTP id u7so8031734qaz.41
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Iq2dhckzWkp/zxGoIGcwsjQu7rql6VyM0d0moKoP7f0=;
        b=bFAWuARRFzY6sZant3/fn8ch8OxNf7qytJ0dJLc9/S/5rr9SYFiH8VeBdiFipABSge
         pKZCUlvy76OTytKx/bCfOnbM8OwCRkrvgolvRFr96tenVMMeS43ZAc3vx0Hgr7QoXkJv
         XrIdKQ/1jXL5PpHjNErLbKd+p0cQjY+qa4gP0I5xpUlXR553NxXLsFBmnxRJ1F7dy+Vn
         wJx0RI99AwVMLpF8CI2nM1thY6GwFrrfn3hgQMjgXD+EatwkpntfyXJ8mvWgh87Dd+U/
         xyXkchdcxRJKT5pEQfAHZLOBxztXnyO3SHsyFAs+0Z4qBJ7ZYT2Pn1VGsyv0dlsqSaC0
         U27A==
X-Received: by 10.229.53.133 with SMTP id m5mr28839348qcg.28.1415783984798;
 Wed, 12 Nov 2014 01:19:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 12 Nov 2014 01:19:24 -0800 (PST)
In-Reply-To: <3356477.HitZEsNa4H@wuerfel>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <1415781993-7755-6-git-send-email-cernekee@gmail.com> <3356477.HitZEsNa4H@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 12 Nov 2014 01:19:24 -0800
Message-ID: <CAJiQ=7AFr5vR+FEc8B3CAZLb5GYujNxtaz7TU2FU0D3oModZ7w@mail.gmail.com>
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for
 BCM7xxx set-top platforms
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
        Rob Herring <robh@kernel.org>, tushar.behera@linaro.org,
        daniel@zonque.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, Nov 12, 2014 at 1:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 12 November 2014 00:46:30 Kevin Cernekee wrote:
>> Remove the platform dependency in Kconfig and add an appropriate
>> compatible string.  Note that BCM7401 has one 16550A-compatible UART
>> in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
>> clock domain.  This driver handles the former one.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>
> Can you explain why you are using the PXA serial driver instead of the
> 8250 driver, if this is 16550A compatible? I don't know the history
> why PXA is using a separate driver.

I wasn't able to get serial8250 to work in any situation where another
driver tried to claim "ttyS"/4/64.

serial8250 calls uart_add_one_port() in its module_init function, even
if the system doesn't have any ports.  Setting nr_uarts
(CONFIG_SERIAL_8250_RUNTIME_UARTS) to 0 doesn't help because
serial8250_find_match_or_unused() will just return NULL.

I guess I could try to rework that logic but several cases would need
to be retested, going back to PCs with ISA buses and PCI add-in cards.
And the differences may be visible to userspace.

The PXA driver seemed like a much cleaner starting point, even if it
was intended for a different SoC.
