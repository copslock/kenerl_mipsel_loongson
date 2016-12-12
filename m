Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 00:27:32 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:38690 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993060AbcLLX1ZSWX1z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Dec 2016 00:27:25 +0100
Received: from [IPv6:2003:86:2805:b100:993a:d6f0:b4f5:93fb] (p200300862805B100993AD6F0B4F593FB.dip0.t-ipconnect.de [IPv6:2003:86:2805:b100:993a:d6f0:b4f5:93fb])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 72FA510047A;
        Tue, 13 Dec 2016 00:27:23 +0100 (CET)
To:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        thomas.langer@intel.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: Braking Lantiq DTS API
Message-ID: <97d898f4-6bf5-6333-eef1-6265f2f9b081@hauke-m.de>
Date:   Tue, 13 Dec 2016 00:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

I would like to break the DTS API for Lantiq devices. ;-)

The Lantiq platform uses device tree in the kernel since a long time and
for some parts there are now better ways to implement it.

Martin started here with some nice patches converting lantiq to the
common clock framework and extracting some other parts:
https://github.com/xdarklight/linux/commits/lantiq-clk-20160123
(I would like to place the drivers somewhere else than arch/mips/lantiq/
but I do not know where)
For most of the parts some compat code is available to make it still
work with the older device tree files.

I would also like to change the IRQ and the DMA controller driver.

It looks like the code in /arch/mips/lantiq/ would only contain the bare
minimum any more after this.

The SoC vendor kernel does not support loading the device tree from a
boot loader and I am not aware of anyone doing so. The SoC vendor kernel
always patches or appends the device tree file to the kernel. The out of
tree vendor drivers can get adapted to the changes later.

Would it be possible to change the device tree files in an incompatible
way without proving a compat layer for older device tree files?
I just want the general opinion on this topic, as this is considered API
and if it would make sense to propose some patches in that direction.

Hauke
