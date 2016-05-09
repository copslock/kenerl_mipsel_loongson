Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 00:38:09 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:38063 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028490AbcEIWiHfnmV9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 00:38:07 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u49MboSo003139;
        Mon, 9 May 2016 17:37:52 -0500
Message-ID: <1462833472.20290.129.camel@kernel.crashing.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        a.seppala@gmail.com, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 10 May 2016 08:37:52 +1000
In-Reply-To: <4908563.V9YuKsSrTJ@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <4162108.qmr2GZCaDN@wuerfel>
         <8737prikg9.fsf@intel.com> <4908563.V9YuKsSrTJ@wuerfel>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2 (3.18.5.2-1.fc23) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Mon, 2016-05-09 at 17:08 +0200, Arnd Bergmann wrote:
> 
> Unfortunately, I don't see any way this could be done in MIPS specific
> code: There is typically a byteswap between the internal bus and the PCI
> bus on big-endian MIPS systems, so the PCI MMIO ends up being little-endian,

Ugh ... not exactly, re-watch my talk on the matter :-) While there is
a specific lane wiring to preserve byte addresss, in the end it's the
end device itself that is either BE or LE. Regardless of any "bus
endianness".
 
> which matches the expected behavior of readl/writel. However, drivers
> for non-PCI devices often use the same readl/writel accessors because
> that is how it's done on ARMv6/ARMv7.

Even then, you can have on-SoC (non-PCI) devices that also have a
different endianness from the main CPU. How does it work on ARM for
example ? The device endianness should be fixed, regardless of the
endianness of the core, no ?

> Doing it hardcoded by architecture is just the simplest way to deal
> with it, working on the assumption that nothing actually needs the
> runtime detection that Ben suggested. 

No, it's not an archicture problem. It's a problem specific to that one
SoC that the device was synthetized to be a certain endian while it was
synthetized differently on another SoC... that also happens to be a
different architecture. But doesn't have to.

For example, we had in the past cases of both LE and BE EHCI
implementations on the same architecture (PowerPC).

> Detecting the endianess of the
> device is probably the best future-proof solution, but it's also
> considerably more work to do in the driver, and comes with a
> tiny runtime overhead.

The runtime overhead is probably non-measurable compared with the cost
of the actual MMIOs.

Cheers,
Ben.
