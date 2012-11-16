Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2012 00:35:19 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:34694 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823020Ab2KPXfMdInp9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Nov 2012 00:35:12 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id A660C8F61;
        Sat, 17 Nov 2012 00:35:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zMOta1wlbEHb; Sat, 17 Nov 2012 00:35:01 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:7de4:25e9:6bea:1667] (unknown [IPv6:2001:470:1f0b:447:7de4:25e9:6bea:1667])
        by hauke-m.de (Postfix) with ESMTPSA id 7DAE38F60;
        Sat, 17 Nov 2012 00:35:00 +0100 (CET)
Message-ID: <50A6CDA0.2080904@hauke-m.de>
Date:   Sat, 17 Nov 2012 00:34:56 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Elliott Mitchell <ehem+outbound@m5p.com>
CC:     "John W. Linville" <linville@tuxdriver.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: brcm4716 and PCIe
References: <20121116044429.GA73539@scollay.m5p.com> <50A67454.6000804@hauke-m.de> <20121116201705.GA75969@scollay.m5p.com>
In-Reply-To: <20121116201705.GA75969@scollay.m5p.com>
X-Enigmail-Version: 1.4.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35029
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

On 11/16/2012 09:17 PM, Elliott Mitchell wrote:
> On Fri, Nov 16, 2012 at 06:13:56PM +0100, Hauke Mehrtens wrote:
>> On 11/16/2012 05:44 AM, Elliott Mitchell wrote:
>>> I happened to be browsing the linux-mips git repository and noticed the
>>> commit at Tue, 10 Jul 2012 16:16:47.
>>
>> What commit are you talking about? Do you have a commit id?
> 
> Looking at: http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=1dfef20a4cf82997d4c7520138ed8188a181241c
> 
> I'm guessing "1dfef20a4cf82997d4c7520138ed8188a181241c" is the commit id.
> 
> Subject is: "brcmsmac: remove PCI_FORCEHT() macro"
> 
> Description is:
> The BCM4716 is a SoC and does not have a PCI client interface, so this
> condition is never true.
> 
> Acked-by: Arend van Spriel <arend@broadcom.com>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> 
> I'm guessing the piece of code is invoked on all flavors of bcm471[678],
> so while it doesn't get invoked on most devices, some of them it
> definitely can be.

I have never seen a bcm4718 with a PCIe controller running in client
mode and it does not make sense to me. PCIe client mode means it is
connected to some other controller like in a Intel chipset in a desktop
PC, but there you would use a normal PCIe card and not a SoC. The
controller is normally running in host mode, so an other PCIe card like
the BCM43224 could be connected to the PCIe controller in the SoC. I
have a Netgear WNDR3400 with a BCM4718 and a BCM43224 connected to the
PCIe host controller in the SoC.

>>> The Broadcom 4716 *does* have an external PCI Express interface! Take a
>>> look at the images on http://wiki.openwrt.org/toh/asus/rt-n16  If you
>>> look at the image of the underside
>>> (http://wiki.openwrt.org/_media/inbox/rt-n16_back_hires.jpg) on the right
>>> side, CON3 and CON5 are the solder pads for mounting a mini-PCIe
>>> connector and bracket.  Apparently V11 is a voltage regulator needed for
>>> that to work, but on this an example of a Broadcom 4716 board that really
>>> does allow a useable PCIe interface (with some hardware hacking).
>>
>> Are you sure the Asus rt-n16 has a BCM4716 and not an BCM4718? Both have
>> the same chip id (0x4716), but a different revision number (BCM4716 =
>> rev 8, BCM4718 = rev 10). The BCM4716 and BCM4717 do not have a PCIe
>> controller, just the BCM4718 has one [0].
> 
> I'm not actually.  Currently exploring a device with ASUS's minimal shell
> they give you.  According to /proc/cpuinfo, "system type: Broadcom
> BCM4716 chip rev 1 pkg 10".  If I'm looking at the correct byte in
> /sys/devices/[...]/config, it does in fact appear to be 0x0A (decimal
> 10).

So it is a BCM4718 with a PCIe controller.

> I've seen photos of some people in Taiwan who soldered something at V11
> (presumably a voltage regulator, it's all Chinese to me).  I'm guessing
> they did in fact get a MiniPCIe card to work, but everything is in the
> wrong language.   :-)   The crucial build photo of the regulator module
> has disappeared, so it is more difficult to reconstruct.

Yes that could be possible and mainline linux would support such a
setup. Be aware that the PCIe controller in the BCM4718 reorders some of
the PCIe writes and reads, which causes some problems.

Hauke
