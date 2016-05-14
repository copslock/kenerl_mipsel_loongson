Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2016 21:45:55 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.135]:62654 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028449AbcENTpu4807E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2016 21:45:50 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0M5cGS-1bqDqe3AW8-00xcrJ; Sat, 14 May
 2016 21:45:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     John Youn <John.Youn@synopsys.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Sat, 14 May 2016 21:45:27 +0200
Message-ID: <2626585.pWJiHSe1F4@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <2920638.peXreEnG6d@debian64>
References: <4231696.iL6nGs74X8@debian64> <5734CE1C.8070208@synopsys.com> <2920638.peXreEnG6d@debian64>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:sCqVboItXLNSSvrOAbaN1uIXJ1Je72lrEUvA5X3BeGwSezvI6Nr
 yE9T09NeulH33oK2KN68TTwm+QyuN8f2EeyBND3ZWRsaovIfLeBKefdER1OP0D/OJDLitsC
 RFMxQoNN/Dq2dcUMvAS4lLD07sBy3Wnlix9vH08Ll6dRCH1tiFK5fBYlmbI1Mp5AIzqIOdi
 d/5QWJq8ezaLLiCF9wa8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2pG+fTdHBR4=:gHuj3pNP0ONp1/3fbRmkfT
 cKerd/Q3WPYL2JvHLJUgaDISkp3UurRy7LYXVY03ncqb+X7GYj3MbTeTIiLyiXSdhV6TLl1N8
 bkMVmdd3fWFUATpaQWm/kOJJGkx44CZgkLTjCMIkmxQTGTVKoNq40TqCVd1uJvd3dVv8qsPV9
 c4bMhWWsgSwVjFIDc7O1bxd4GCAOdN/zzML+6WUH2S38G3nOVmBK9GThI1YoRxqrp2Iuz/GlB
 NBLTLoz1nkLE2Fhj6C1nluKKFCbjhNs4EFD5syJrcv1sR/Imf3ncdGhOjwt8Z9XEze7VW3Zwx
 LCKvcfWKw2l5VUD+pe6pAwv2YXuAuFfIOF6yVccs517sj5U5SO+hgCjSEOTHibNFKUW2VUS1t
 h6flj9i8yswNO+k/b7NruFe+uvTePdPHKb8hHMTwSODZdjNjiRUdGxVHDgdDuQi0nZfgwhC99
 ieGHE+s4sAjK/hQnyXqIKfMz6BkgVxoEOJ1cc0IcoLCMuQkff1MUgHj5CJZpJ/cH5CiZulGrn
 /budAuxl+JxbWppnxw0drs/MatHoLgwy8zuavdLrZngw9ROfBvw65WZ7qgjm5DA4lgZ4Hjjyo
 r3vcKUIapuT0yGc9emY5p5oWSdW253vZE4k3w10vqSdXBxk9YOcsj3MoRQbvHdXtAY0q9S1fi
 i9tBtXvX7L8Del0V62lqVa9vxu29yLltNFUe9DE+6bDQfPJFwJCZ3eziaIUgkK5niAC6JW738
 3Sugv+EwvoF8o/3OiAIgauE7JuJn1anSQTgyvQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53449
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

On Saturday 14 May 2016 15:11:34 Christian Lamparter wrote:
> 
> +#ifdef CONFIG_MIPS
> +/*
> + * There are some MIPS machines that can run in either big-endian
> + * or little-endian mode and that use the dwc2 register without
> + * a byteswap in both ways.
> + * Unlike other architectures, MIPS apparently does not require a
> + * barrier before the __raw_writel() to synchronize with DMA but does
> + * require the barrier after the __raw_writel() to serialize a set of
> + * writes. This set of operations was added specifically for MIPS and
> + * should only be used there.
> + */
> +static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
> +                            ptrdiff_t reg)
> +{
> +       const void __iomem *addr = hsotg->regs + reg;
> +       u32 value = __raw_readl(addr);
> +
> 

I see you keep the special case for MIPS here, I'd vote for folding
that back into the architecture-independent version and not treating
MIPS any different from the others. With your endianness detection, MIPS
should have no way of getting the byteorder wrong, and on MIPS the
platform is responsible for adding the appropriate barriers to
readl/writel.

Other than this, the patch looks good to me.

	Arnd
