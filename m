Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 18:14:08 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33888 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823042Ab2KPROHSW9EZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2012 18:14:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id CB1B28F61;
        Fri, 16 Nov 2012 18:14:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WHwJ3h7cRTH8; Fri, 16 Nov 2012 18:13:59 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:7de4:25e9:6bea:1667] (unknown [IPv6:2001:470:1f0b:447:7de4:25e9:6bea:1667])
        by hauke-m.de (Postfix) with ESMTPSA id ACDC78F60;
        Fri, 16 Nov 2012 18:13:58 +0100 (CET)
Message-ID: <50A67454.6000804@hauke-m.de>
Date:   Fri, 16 Nov 2012 18:13:56 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Elliott Mitchell <ehem+outbound@m5p.com>
CC:     "John W. Linville" <linville@tuxdriver.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: brcm4716 and PCIe
References: <20121116044429.GA73539@scollay.m5p.com>
In-Reply-To: <20121116044429.GA73539@scollay.m5p.com>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35026
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/16/2012 05:44 AM, Elliott Mitchell wrote:
> I happened to be browsing the linux-mips git repository and noticed the
> commit at Tue, 10 Jul 2012 16:16:47.

What commit are you talking about? Do you have a commit id?

> The Broadcom 4716 *does* have an external PCI Express interface! Take a
> look at the images on http://wiki.openwrt.org/toh/asus/rt-n16  If you
> look at the image of the underside
> (http://wiki.openwrt.org/_media/inbox/rt-n16_back_hires.jpg) on the right
> side, CON3 and CON5 are the solder pads for mounting a mini-PCIe
> connector and bracket.  Apparently V11 is a voltage regulator needed for
> that to work, but on this an example of a Broadcom 4716 board that really
> does allow a useable PCIe interface (with some hardware hacking).

Are you sure the Asus rt-n16 has a BCM4716 and not an BCM4718? Both have
the same chip id (0x4716), but a different revision number (BCM4716 =
rev 8, BCM4718 = rev 10). The BCM4716 and BCM4717 do not have a PCIe
controller, just the BCM4718 has one [0].

> What is the status of brcm4716 support?  The ASUS source code is in the
> wild, but that includes many files marked, "UNPUBLISHED PROPRIETARY
> SOURCE CODE of Broadcom Corporation".  Bit silly since they've been
> published at this point, but they still retain the rights...

Some of the code for BCM4716 is upstream, some is just in OpenWrt [1]
and not yet upstream and some is missing. The Ethernet driver is still
missing. The Asus GPL tar contains all the code expect the one for the
wireless driver, but b43 and brcmsmac already have support for this wifi
core.

Hauke

[0]: http://www.datasheetdir.com/BCM4717+Communications-Processor
[1]:
https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-3.3/
