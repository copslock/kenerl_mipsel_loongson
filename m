Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 11:58:28 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33042 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27029199AbcELJ61BcRmA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 11:58:27 +0200
Received: by mail-wm0-f66.google.com with SMTP id r12so14969795wme.0
        for <linux-mips@linux-mips.org>; Thu, 12 May 2016 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/n8m7s577hshOOUn/mrYA/azM+D8LJ9JLSBmZ887qdA=;
        b=BKbbmK2BRoJK+SiJcbdgZ6euEBXmmA8rlMUD2riONfclD/4mTLdRSGX/51Erve1ZRo
         cNAqMFqa/Uqewwc6kWw/7KB9c+Vz0jX1Io3hq15PKs0yLdvbLf9shMRJ/w0ng6Yj3/hg
         z2PTi9yxuc6vxS8b5GqzuzGZ/6IuGWt99hStP7gNkIAm9vHZG+WSpsvdmwfdMMv5QXe0
         tV98aZ3xfxdmEXqjaTolgyR4kbm0J/HlgH2CnyXeWjeg5Eh/OYODvM/mCOuPgIwhZ/UO
         BbcDS3FyoQ2ZOUBBZpxGgmSVV0ndMyEIMrKDzsvxpHL1ubG0nqZJd+EA1iJY6EuFhI+a
         XBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/n8m7s577hshOOUn/mrYA/azM+D8LJ9JLSBmZ887qdA=;
        b=WTSN/CCE4C5MKpG5tYmaszl6l60CkeCLc4MUWkj+TpcORfPh3X0sQzh6oDAeG3saYe
         8JrnMLJqSCoL8vAUXm74cvqa3HVSVgSYyy1zbd44FjoUckdViMMGr7XKwpN54iZLfx92
         uohiL/eVEC9ozz7u2JcQp7ZfPi2eu3XTGqf9z37m2tK7qqVJSHOj4TN8hNXwN7jToOF4
         xpO0REp4E0Zme9ujJlrxqf9GnJOosKBx8JSb2x9YySBe2l53D0Z97o7Wk1d37pCBFRvD
         j5mIlAx05PcQcxQzqCU+8jQEKLd3DMERmCceuia9E+VvRjq0Kla8pEVH59Zpehvqerja
         GEQQ==
X-Gm-Message-State: AOPr4FVjQX1BNw3NIImcKpxQedd7fPJeRqfVgw0pJFWZ5e6FbmVg0Yd7ttkMG1fXlS5FVg==
X-Received: by 10.28.169.69 with SMTP id s66mr9214362wme.83.1463047101710;
        Thu, 12 May 2016 02:58:21 -0700 (PDT)
Received: from debian64.daheim (pD9F89BEC.dip0.t-ipconnect.de. [217.248.155.236])
        by smtp.googlemail.com with ESMTPSA id kz1sm12506954wjc.46.2016.05.12.02.58.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2016 02:58:20 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.87)
        (envelope-from <chunkeey@googlemail.com>)
        id 1b0nNq-0006AB-S4; Thu, 12 May 2016 11:58:18 +0200
From:   Christian Lamparter <chunkeey@googlemail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Thu, 12 May 2016 11:58:18 +0200
Message-ID: <7745292.ZB3149zIk7@debian64>
User-Agent: KMail/4.14.10 (Linux/4.6.0-rc5-wt; KDE/4.14.14; x86_64; ; )
In-Reply-To: <5347627.S9K7mIusOJ@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <1462833472.20290.129.camel@kernel.crashing.org> <5347627.S9K7mIusOJ@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <chunkeey@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chunkeey@googlemail.com
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

On Tuesday, May 10, 2016 09:23:59 AM Arnd Bergmann wrote:
> On Tuesday 10 May 2016 08:37:52 Benjamin Herrenschmidt wrote:
> > On Mon, 2016-05-09 at 17:08 +0200, Arnd Bergmann wrote:
> > > 
> > > Unfortunately, I don't see any way this could be done in MIPS specific
> > > code: There is typically a byteswap between the internal bus and the PCI
> > > bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,
> > 
> > Ugh ... not exactly, re-watch my talk on the matter :-) While there is
> > a specific lane wiring to preserve byte addresss, in the end it's the
> > end device itself that is either BE or LE. Regardless of any "bus
> > endianness".
> 
> I found your slides on
> 
> http://www.linuxplumbersconf.org/2012/wp-content/uploads/2012/09/2012-lpc-ref-big-little-endian-herrenschmidt.odp
> 
> but there are at least two more twists that you completely missed here:
> 
> - Some architectures (e.g. ARMv5 "BE32" mode in IXP4xx, surely some others)
>   do not implement big-endian mode by wiring up the data lines between the
>   bus and the CPU differently between big- and little-endian mode like
>   powerpc and armv7 "BE8" do, but instead they swizzle the *address* lines
>   on 8-bit and 16-bit addresses. The effect of that is that normal RAM
>   accesses work as expected both ways, and devices that are accessed using
>   32-bit MMIO ops never need any byteswap (you actually get "native
>   endian") while MMIO with 8 and 16 bit width does something completely
>   unexpected and touches the wrong register. Having an explicit byteswap
>   on the PCI host bridge gets you the expected addresses again for 8-bit
>   cycles but it also means that readl()/writel() again need to swap the
>   data.
> 
> - Some other architectures (e.g. Broadcom MIPS) apparently are even fancier
>   and use a strapping pin on the SoC flips the endianess of the CPU core
>   at the same time as all the peripheral MMIO registers, with the intention
>   of never requiring any byte swaps. I believe they are implemented careful
>   enough to actually get this right, but it confuses the heck out of
>   Linux drivers that don't expect this.
> 
> > > which matches the expected behavior of readl/writel. However, drivers
> > > for non-PCI devices often use the same readl/writel accessors because
> > > that is how it's done on ARMv6/ARMv7.
> > 
> > Even then, you can have on-SoC (non-PCI) devices that also have a
> > different endianness from the main CPU. How does it work on ARM for
> > example ? The device endianness should be fixed, regardless of the
> > endianness of the core, no ?
> 
> ARMv6/v7 is uses BE8 mode like powerpc: each peripheral is fixed-endian
> and you have to know what it is. Only Freescale managed to put identical
> IP blocks on various (powerpc-derived) SoCs and have a subset of them
> treat the access as little-endian while others remain big-endian, so all
> those drivers now require runtime detection.
> 
> > > Doing it hardcoded by architecture is just the simplest way to deal
> > > with it, working on the assumption that nothing actually needs the
> > > runtime detection that Ben suggested. 
> > 
> > No, it's not an archicture problem. It's a problem specific to that one
> > SoC that the device was synthetized to be a certain endian while it was
> > synthetized differently on another SoC... that also happens to be a
> > different architecture. But doesn't have to.
> > 
> > For example, we had in the past cases of both LE and BE EHCI
> > implementations on the same architecture (PowerPC).
> 
> I understand this, but from what I see in this history of this particular
> driver, all ARM and PowerPC implementations chose to use LE registers for
> DWC2 because the normal approach for these is to not mess with endianess,
> while presumably all MIPS users of the same block wired up the endian-select
> line of the IP block to match that of the CPU core, again because it's
> what you are expected to do on a MIPS based SoC.
> 
> So hardcoding it per architecture would make an assumption based on
> the mindset of the SoC designers rather than strict technical differences,
> and that can fail as soon as someone does things differently on any of
> them (see the Freescale example), but I still think it's the easiest
> workaround for backporting to stable kernels. A revert of the original
> patch would be even easier, but that would break the one big-endian
> MIPS machine we know about.
> 
> > > Detecting the endianess of the
> > > device is probably the best future-proof solution, but it's also
> > > considerably more work to do in the driver, and comes with a
> > > tiny runtime overhead.
> > 
> > The runtime overhead is probably non-measurable compared with the cost
> > of the actual MMIOs.
> 
> Right. The code size increase is probably measurable (but still small),
> the runtime overhead is not.

Ok, so no rebuts or complains have been posted.

I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
and it works: 

Tested-by: Christian Lamparter <chunkeey@googlemail.com>

So, how do we go from here? There is are two small issues with the
original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
#ifdef dwc2_log_writes) and I guess a proper subject would be nice.  

Arnd, can you please respin and post it (cc'd stable as well)?
So this is can be picked up? Or what's your plan?

Regards,
Christian
