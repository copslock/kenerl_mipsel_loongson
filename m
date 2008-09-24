Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 23:14:38 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:796 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S29059918AbYIXWOb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 23:14:31 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 521C33ECC; Wed, 24 Sep 2008 15:14:26 -0700 (PDT)
Message-ID: <48DABBBE.7060201@ru.mvista.com>
Date:	Thu, 25 Sep 2008 02:14:22 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
References: <20080924191840.GA18700@volta.aurel32.net> <20080924191955.GB18700@volta.aurel32.net>
In-Reply-To: <20080924191955.GB18700@volta.aurel32.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Aurelien Jarno wrote:

> This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
> pcibios_plat_dev_init() for the BCM47xx platform.
>
> It fixes the regression introduced by commit
> aab547ce0d1493d400b6468c521a0137cd8c1edf.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> Reviewed-by: Michael Buesch <mb@bu3sch.de>
>   
[...]
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
>   

   Unneeded ()...

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
>   

   Unneeded {}...

WBR, Sergei
