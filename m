Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 23:25:35 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:50898 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011918AbaJTVZbwiY2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 23:25:31 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue006) with ESMTP (Nemesis)
        id 0LmAhq-1YGDQr2Ft4-00ZvL5; Mon, 20 Oct 2014 23:25:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org, geert@linux-m68k.org,
        f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date:   Mon, 20 Oct 2014 23:25:10 +0200
Message-ID: <2100909.UrHPDWWSai@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <6216923.cK1phqtEXn@wuerfel>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <1413838448-29464-5-git-send-email-cernekee@gmail.com> <6216923.cK1phqtEXn@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:McSvJM41Aa1hvbFCp/hMJz7qfF/EIcHB/v7OKEYI5RO
 G9wx37WeNek/N659LUPy6YeBPZG99gZRRzJphjP14n5/IoEuZ3
 qc6uu4wk2SA67LV7LQe6qsDUfELqMFr+Mr9ktQ+90Gn4jih8Zg
 mdfqQ6zbZJLlTUc/MdBzy4lJSkqOUXMPP7QeetLllE5gd0FFi5
 fIHu122okRdVPGGGwbBktnYWmTFdvfal2xlYo4tJpRoRIKPsAm
 AtfU0RUPGz1TQIxlnZdiTszbPToEabDgFM4Vq7C6yvsWsjZA2i
 DbN9F85/K4xEkKXtBqEbOcUN40LQZxqMXdrmhqn2o/kIOaMh6B
 fKQbzhKH3FfbrpBZm6vg=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43390
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

On Monday 20 October 2014 23:20:08 Arnd Bergmann wrote:
> 
> In this example, the clock output name of the clock provider is
> the same as the clock input of the consumer, that is almost always
> a bug and would not be a good example at all.
> 
> 

Ah, found the bug: the MIPS code is written to ignore the device
and just look up a global clock name:

struct clk *clk_get(struct device *dev, const char *id)
{
        if (!strcmp(id, "enet0"))
                return &clk_enet0;
        if (!strcmp(id, "enet1"))
                return &clk_enet1;
        if (!strcmp(id, "enetsw"))
                return &clk_enetsw;
        if (!strcmp(id, "ephy"))
                return &clk_ephy;
        if (!strcmp(id, "usbh"))
                return &clk_usbh;
        if (!strcmp(id, "usbd"))
                return &clk_usbd;
        if (!strcmp(id, "spi"))
                return &clk_spi;
        if (!strcmp(id, "hsspi"))
                return &clk_hsspi;
        if (!strcmp(id, "xtm"))
                return &clk_xtm;
        if (!strcmp(id, "periph"))
                return &clk_periph;
        if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
                return &clk_pcm;
        if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
                return &clk_ipsec;
        if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
                return &clk_pcie;
        return ERR_PTR(-ENOENT);
}

This should be changed to use the drivers/clk/clkdev.c lookup code if
you want to share drivers between architectures.

In particular, the "enet0"/"enet1" clock name makes no sense -- the
clock input name should be independent of the instance, aside from
the question of which output of the provider it is wired up to.

	Arnd
