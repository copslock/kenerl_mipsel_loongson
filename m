Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 21:17:12 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:62864 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012438AbcBOURKE9Pl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 21:17:10 +0100
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0MH974-1ai0Uf2LWk-00Dn0l; Mon, 15 Feb
 2016 21:16:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] gpio: remove broken irq_to_gpio() interface
Date:   Mon, 15 Feb 2016 21:16:30 +0100
Message-ID: <4277616.myYDBWrFcU@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <56C1F645.1070405@metafoo.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com> <1455551208-2825510-2-git-send-email-arnd@arndb.de> <56C1F645.1070405@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:5V3mmFSVQ3ctjraJU486u+T21/fiTK1/YwlOH3oKzdBGO+2g2PB
 QKGByyMvTG6jmQnAvb1PY99dMQcix9O8YpZo1j7UCF0ZxK+eYkADefJ0vbOxcyj+I1OZ+Z7
 UAlHtFfXU/23gE/aSzE/U4M1bC18lCQw/MJKVTYHwj9l4bz5/DGY7FjzlfVLp5KhJnLcZCj
 yh8PrJzhVskuAf8Ytm3Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ylWPSZ/yuxo=:gCC3WqzzCpvefvDvzOFsrf
 OKlK36GoYf+MRjNXUye8Eu+o2957nZv3uxdDzWn4NBVIIRDozzWZoN6yQdATDnbtkXNMvQrEC
 NAL74VoJ6i+mX0zkaM+WXjEhoEEPYJBegok2JjffWs2MK/gRJjjA7nwNqX566o/p6DUDdUQWC
 UWtmgodGPtGN1wE/umIEM7ZDx2hot5JJgo7B/XnEgdIMUHf30G0FSgQXIpsGSzyUxPZU6KUkl
 3mt/R5sVWZy2LJtpaNBCMU59yAN8uVbl0+N2AASGhtnsKbyhMledtnsIvdagRfpnsyuGFbg0V
 DjL+OVet4+ghNvr3bvfPGKQBDH6GOJ5HVWFCsOzOoDWelB11e455zwB7nxK9cr+II3lnlGrLN
 tZpmtTxtNPG7Ds9foceoSVa06hsY7hRM7IB6lJLVW70fKhXBHRGncNW7gR5C1ca32RlJOmWA/
 5pGNnKg0MkMNeJm0Nvk5UhM/CBNV/V2SeceHgz+JCGJf75M7rwAjVjKumIee9JFjSw3NZrHD1
 krzjZ9MMC846zkJSOJi9mn37WRlN+WNy7L3tjkTCEckPZXOE/C9xH74RErthblDXoVEyoOqhR
 oxJyLEJ0RgontsdFVKjb1YIsOJdvEeS4OzpxhxVEnqdoKak9rnS447iJBfNN6FslbBI8rV5a1
 r1qu8qQVKSEr+KZJCF6Ho6aQ9QZ9AwcEsL0EzSfcz/pMaTbGfVKgcbYr10j261Tz6LIWFt1X/
 eAgLveRo7tKt3r3U
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52075
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

On Monday 15 February 2016 17:01:09 Lars-Peter Clausen wrote:
> On 02/15/2016 04:46 PM, Arnd Bergmann wrote:
> > +static inline __deprecated int irq_to_gpio(unsigned int irq)
> > +{
> > +     /* this has clearly not worked for a long time */
> > +     return -EINVAL;
> > +}
> > +
> >  #define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
> 
> The issue seems to be a fallout from commit 832f5dacfa0b ("MIPS: Remove all
> the uses of custom gpio.h").
> 
> The irq_to_gpio() should be replaced with "(irq - JZ4740_IRQ_GPIO(0))".
> 
> 

Ah, that explain it, so it has not been broken for that long.

	Arnd
