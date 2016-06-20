Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 10:39:40 +0200 (CEST)
Received: from mout.gmx.net ([212.227.15.19]:63109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27042148AbcFTIjjDBYLJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Jun 2016 10:39:39 +0200
Received: from [82.218.216.94] by 3capp-gmx-bs62.server.lan (via HTTP); Mon,
 20 Jun 2016 10:39:03 +0200
MIME-Version: 1.0
Message-ID: <trinity-6320ab58-52d3-403a-9e36-b371a13c5e76-1466411943381@3capp-gmx-bs62>
From:   p.wassi@gmx.at
To:     "Aaro Koskinen" <aaro.koskinen@iki.fi>
Cc:     =?UTF-8?Q?=22Rafa=C5=82_Mi=C5=82ecki=22?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <ddaney.cavm@gmail.com>,
        "David Daney" <david.daney@cavium.com>,
        =?UTF-8?Q?=22Michael_B=C3=BCsch=22?= <m@bues.ch>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "Larry Finger" <larry.finger@lwfinger.net>,
        "Felix Fietkau" <nbd@nbd.name>, "John Crispin" <john@phrozen.org>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 20 Jun 2016 10:39:03 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20160616184358.GC8398@raspberrypi.musicnaut.iki.fi>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>,
 <20160616184358.GC8398@raspberrypi.musicnaut.iki.fi>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K0:Kz3VnrufYfQQfzQYwTwK9i7qBqweqKJl6f0q8nEDbDL
 629y+z4qmzxNaJ2Gy8+slE1JrzwEZiNBeYwJ1kOw3sjDQ619Ph
 r2YTPJmLv0uneBz/A38Lnu9SwdcxTu33smbjot4Jf3L8aRHWw2
 UviDV0DD46Yd88C+JeiBK/6hzkXdp30Jw3fnr2h0Kz1WuvjxvC
 OfeGLb6vPm7wmIBy4hJgS+RIwchRFCJvvljfEPqXhxvd0NPttU
 HkNWra4K9S9KQFvsKD3OoB0H82EVfY6sOAHKQz4GAeU0bNDClx d0ONYc=
X-UI-Out-Filterresults: notjunk:1;V01:K0:NIh3z5ZtmB8=:udO6AG4d+j86fIkwySyD/V
 ZYaG5bXIgIw+6Z3sV6Ro6Ozae/JXIJylUI83lj3ksxBzn+T1nCeBQJnK6czifT+xfXDc+Y7MM
 wuFpF5iduwk4TuPqypq4zbDxKAI8qFN2zlHGEnGCV4c82jLsZqVGbYo6f7zQUqeqbZY2UFCAZ
 4jpSry811J+O0DHwqPbnrtZ2k96sG3S/JBHnqmkdBakNnTig/YFy3z+/Pi8afQskVF8rsVBQP
 ICLBCKo4vZ65xZ504x0xIPYETSKz6M8Q5MjZnLLQ2cTfTfmC/jkpLdqz4w5ArJ6gxJdWgdNN3
 PCxYy0iDQxcCeKJ0/Jy4oamJx8L8BMATKYmTvdQq/xhCJb3I8kgFds+pYfhhg6s3uLIaK8csd
 JscCjoCn4ifsmz1SkSoHLZ4NNwNrRIsyAHKBAyIcHlVO+c9L/boHop0eEvmwd3ABeYpsfrZpM
 OvBE4IWx8w==
Return-Path: <p.wassi@gmx.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.wassi@gmx.at
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

Hi,

I've now done some further tests on my WRT54GL (BCM5352):
> (...)
> Starting program at 0x80001000
> [    0.000000] Linux version 4.4.13 (openwrt@debian-compiler) (gcc version 5.3.0 (LEDE GCC 5.3.0 r482) ) #1 Thu Jun 16 19:04:33 UTC 2016
> (...)

So Kernel 4.4 is successfully booting on this hardware.

However, this still does not resolve the issue with prebuilt/"homemade" images for LEDE/OpenWrt.
(This is to be discussed on other mailing lists.)

I have a slightly different memory map compared to Aaro's:
> Total memory used by CFE:  0x80300000 - 0x803A4010 (671760)
> Initialized Data:          0x80339E70 - 0x8033C630 (10176)
> BSS Area:                  0x8033C630 - 0x8033E010 (6624)
> Local Heap:                0x8033E010 - 0x803A2010 (409600)
> Stack Area:                0x803A2010 - 0x803A4010 (8192)
> Text (code) segment:       0x80300000 - 0x80339E70 (237168)
> Boot area (physical):      0x003A5000 - 0x003E5000
> Relocation Factor:         I:00000000 - D:00000000

For testing:
I have WRT54GL and WL500gpv2 here, and can attach JTAG if that helps.
(No BCM4704 though)

What came to my eyes now:
after the output "Starting program at 0x80001000" it takes some time (~1-2 seconds) until
Kernel's first printk appears. I guess that's the (GZ|LZMA|whatever)-decompressor.
Maybe this gets stuck somehow? -> Would JTAG help?

Best regards,
P. Wassi
