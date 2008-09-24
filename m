Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Sep 2008 00:33:57 +0100 (BST)
Received: from bu3sch.de ([62.75.166.246]:60884 "EHLO vs166246.vserver.de")
	by ftp.linux-mips.org with ESMTP id S29567941AbYIXXd0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Sep 2008 00:33:26 +0100
Received: from p5b09de83.dip.t-dialin.net ([91.9.222.131] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1Kibjw-0001Ts-VB; Wed, 24 Sep 2008 21:17:41 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Date:	Wed, 24 Sep 2008 23:17:13 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net>
In-Reply-To: <20080924191955.GB18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809242317.14120.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Wednesday 24 September 2008 21:19:55 Aurelien Jarno wrote:
> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
> pcibios_plat_dev_init() for the BCM47xx platform.
> 
> It fixes the regression introduced by commit
> aab547ce0d1493d400b6468c521a0137cd8c1edf.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Michael Buesch <mb@bu3sch.de>

Is this STILL not merged?
Come on mips guys, WAKE UP!
This compiletime-regression is fixed since several months and this is the
third time (at least) that we submit this patch.
A kernel.org bugzilla entry does also exist.

I'll bypass the mips tree and send it to akpm, if this takes any further delay.

> ---
>  arch/mips/pci/Makefile      |    1 +
>  arch/mips/pci/pci-bcm47xx.c |   58 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/pci/pci-bcm47xx.c
> 
> diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
> index 15e01ae..c8c32f4 100644
> --- a/arch/mips/pci/Makefile
> +++ b/arch/mips/pci/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_SOC_TX3927)	+= ops-tx3927.o
>  obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
>  obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
>  obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
> +obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
>  
>  #
>  # These are still pretty much in the old state, watch, go blind.
> diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
> new file mode 100644
> index 0000000..64ccb4f
> --- /dev/null
> +++ b/arch/mips/pci/pci-bcm47xx.c
> @@ -0,0 +1,58 @@
> +/*
> + *  Copyright (C) 2008 Michael Buesch <mb@bu3sch.de>
> + *  Copyright (C) 2008 Aurelien Jarno <aurelien@aurel32.net>
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/ssb/ssb.h>
> +
> +int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	int res;
> +
> +	res = ssb_pcibios_map_irq(dev, slot, pin);
> +	if (res < 0) {
> +		printk(KERN_ALERT "PCI: Failed to map IRQ of device %s\n",
> +		       dev->dev.bus_id);
> +		return 0;
> +	}
> +	/* IRQ-0 and IRQ-1 are software interrupts. */
> +	WARN_ON((res == 0) || (res == 1));
> +
> +	return res;
> +}
> +
> +int pcibios_plat_dev_init(struct pci_dev *dev)
> +{
> +	int err;
> +
> +	err = ssb_pcibios_plat_dev_init(dev);
> +	if (err) {
> +		printk(KERN_ALERT "PCI: Failed to init device %s\n",
> +		       pci_name(dev));
> +	}
> +
> +	return err;
> +}
> +
> -- 
> 1.5.6.5
> 
> 



-- 
Greetings Michael.
