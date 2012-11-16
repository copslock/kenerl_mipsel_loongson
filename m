Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 21:17:27 +0100 (CET)
Received: from 207-172-210-101.c3-0.hdp-ubr1.sbo-hdp.ma.static.cable.rcn.com ([207.172.210.101]:30537
        "EHLO mailhost.m5p.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825956Ab2KPURW3ZZ0D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2012 21:17:22 +0100
Received: from m5p.com (ssh.m5p.com [IPv6:2001:418:3fd::fb])
        by mailhost.m5p.com (8.14.5/8.14.5) with ESMTP id qAGKH7Wk009563;
        Fri, 16 Nov 2012 15:17:12 -0500 (EST)
        (envelope-from ehem@m5p.com)
Received: (from ehem@localhost)
        by m5p.com (8.14.5/8.13.7/Submit) id qAGKH5MF076186;
        Fri, 16 Nov 2012 12:17:05 -0800 (PST)
Date:   Fri, 16 Nov 2012 12:17:05 -0800
From:   Elliott Mitchell <ehem+outbound@m5p.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: brcm4716 and PCIe
Message-ID: <20121116201705.GA75969@scollay.m5p.com>
References: <20121116044429.GA73539@scollay.m5p.com>
 <50A67454.6000804@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50A67454.6000804@hauke-m.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.73
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.7 (mailhost.m5p.com [IPv6:2001:418:3fd::f7]); Fri, 16 Nov 2012 15:17:12 -0500 (EST)
X-archive-position: 35028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ehem+outbound@m5p.com
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

On Fri, Nov 16, 2012 at 06:13:56PM +0100, Hauke Mehrtens wrote:
> On 11/16/2012 05:44 AM, Elliott Mitchell wrote:
> > I happened to be browsing the linux-mips git repository and noticed the
> > commit at Tue, 10 Jul 2012 16:16:47.
> 
> What commit are you talking about? Do you have a commit id?

Looking at: http://git.linux-mips.org/?p=ralf/linux.git;a=commitdiff;h=1dfef20a4cf82997d4c7520138ed8188a181241c

I'm guessing "1dfef20a4cf82997d4c7520138ed8188a181241c" is the commit id.

Subject is: "brcmsmac: remove PCI_FORCEHT() macro"

Description is:
The BCM4716 is a SoC and does not have a PCI client interface, so this
condition is never true.

Acked-by: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: John W. Linville <linville@tuxdriver.com>

I'm guessing the piece of code is invoked on all flavors of bcm471[678],
so while it doesn't get invoked on most devices, some of them it
definitely can be.


> > The Broadcom 4716 *does* have an external PCI Express interface! Take a
> > look at the images on http://wiki.openwrt.org/toh/asus/rt-n16  If you
> > look at the image of the underside
> > (http://wiki.openwrt.org/_media/inbox/rt-n16_back_hires.jpg) on the right
> > side, CON3 and CON5 are the solder pads for mounting a mini-PCIe
> > connector and bracket.  Apparently V11 is a voltage regulator needed for
> > that to work, but on this an example of a Broadcom 4716 board that really
> > does allow a useable PCIe interface (with some hardware hacking).
> 
> Are you sure the Asus rt-n16 has a BCM4716 and not an BCM4718? Both have
> the same chip id (0x4716), but a different revision number (BCM4716 =
> rev 8, BCM4718 = rev 10). The BCM4716 and BCM4717 do not have a PCIe
> controller, just the BCM4718 has one [0].

I'm not actually.  Currently exploring a device with ASUS's minimal shell
they give you.  According to /proc/cpuinfo, "system type: Broadcom
BCM4716 chip rev 1 pkg 10".  If I'm looking at the correct byte in
/sys/devices/[...]/config, it does in fact appear to be 0x0A (decimal
10).

I've seen photos of some people in Taiwan who soldered something at V11
(presumably a voltage regulator, it's all Chinese to me).  I'm guessing
they did in fact get a MiniPCIe card to work, but everything is in the
wrong language.   :-)   The crucial build photo of the regulator module
has disappeared, so it is more difficult to reconstruct.


-- 
(\___(\___(\______          --=> 8-) EHM <=--          ______/)___/)___/)
 \BS (    |         EHeM+sigmsg@m5p.com  PGP F6B23DE0         |    )   /
  \_CS\   |  _____  -O #include <stddisclaimer.h> O-   _____  |   /  _/
2477\___\_|_/DC21 03A0 5D61 985B <-PGP-> F2BE 6526 ABD2 F6B2\_|_/___/3DE0
