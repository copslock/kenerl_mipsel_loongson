Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Dec 2015 17:26:39 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33843 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013641AbbLJQ0iHUQho (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Dec 2015 17:26:38 +0100
Received: by obciw8 with SMTP id iw8so62734310obc.1
        for <linux-mips@linux-mips.org>; Thu, 10 Dec 2015 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/2dQ1I4K/Otgz0LyxnqpvUPEFvyAh7R6LMMAgcQD9mo=;
        b=xJRxbCtOnrg06FPa+RqPwHWKWc6HS/BUewYQT9Y9TCTcGxoCwFcEylNusxyuzzOfrj
         gqtgJWBdOvKfPz4i/1GSw5Yn0SXU56GhPCG5SPPho4ZXZaQduCYXEv1ZGXPTHkaoDLKd
         KB0Ihey+1CKPJbPB4urRBBmrCboUwYuI3tFNvpXQJ9As2BsmUHJ1PvCXS6uPMK8sqnej
         J6wPjGz7h7eYg/KDJo95mXe6R7fm5SJS6LMIN5g5m230fMW1nl8OKH0cvHLgjd21jpiE
         Z7v5oYWK4j12viGZRQeqFXRoKMlddcO6d+fHJ3SfJHE/oRIPCEFGTy/eKwE1mSIp3jAx
         fK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/2dQ1I4K/Otgz0LyxnqpvUPEFvyAh7R6LMMAgcQD9mo=;
        b=VOYS8nvNxtfiwZu/y922Xvm2NjigSkhK/TKvW9lTKEm1QtwZT5uIV258FebEfwVtJB
         1qV5Fa6yuEU4/AfZ/96wLPPXfVtIc3lN3kh81bxyS4IANnVlsVQLpBF/knVO+TdNPmeV
         zeTW+OjWAkFGfPcEcVSWMiyWStiK7Kkg2S+4WdJDukxYccy+qHzNG2ixHXq/4OOGxk8m
         s81np/wFCEXmCG9cR1MXLVj6ZDmfbn3VxhT67jVyYTMuTGrLNhzR9SJq1YDU1dB2T0ii
         vYPLzWaod1/Ein6CDv2sOnqkRGSHc42+9UfVj1vr/qzrFnGPS1PQTO8UsPvxToUYK+5o
         uBsA==
X-Gm-Message-State: ALoCoQn92y4AM44XQFgHUw8e+v9k153go+Ft62soZirDzFy6sT17b1sQIFEOBss3/W4pd9/ib/UhWpt3C7XBlJw2ty9I9ZmAnzSF3mwzUGpCLnU7NSgyTa8=
MIME-Version: 1.0
X-Received: by 10.182.129.132 with SMTP id nw4mr4913603obb.48.1449764791554;
 Thu, 10 Dec 2015 08:26:31 -0800 (PST)
Received: by 10.182.32.70 with HTTP; Thu, 10 Dec 2015 08:26:31 -0800 (PST)
In-Reply-To: <20151130163413.GB1929@sirena.org.uk>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
        <20151130163413.GB1929@sirena.org.uk>
Date:   Thu, 10 Dec 2015 17:26:31 +0100
Message-ID: <CACRpkdb2YhSbaYUXh4Dz7juObHxmWLc8Gj6UmkJ=Nv69UNfaPA@mail.gmail.com>
Subject: Re: [PATCH 00/28] MIPS Boston board support
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Kumar Gala <galak@codeaurora.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grant Likely <grant.likely@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pawel Moll <pawel.moll@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Wolfram Sang <wsa@the-dreams.de>, Duc Dang <dhdang@apm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        dmaengine@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Minghuan Lian <Minghuan.Lian@freescale.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Mon, Nov 30, 2015 at 5:34 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Nov 30, 2015 at 04:21:25PM +0000, Paul Burton wrote:
>> This series introduces support for the Imagination Technologies MIPS
>> Boston development board. Boston is an FPGA-based development board
>> akin to the much older Malta board, built around a Xilinx FPGA running
>> a MIPS CPU & other logic including a PCIe root port connected to an
>> Intel EG20T Platform Controller Hub. This provides a base set of
>> peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
>> slots are also present for expansion.
>
> This is an insanely big CC list :(
>
> What are the interdependencies here - does this really need to be one
> patch series or can the individual driver changes go in separately?

I took the two GPIO patches and ran off with them at least.

Yours,
Linus Walleij
