Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 19:11:37 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:61197 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366931AbZCGTLf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2009 19:11:35 +0000
Received: from 10.8.0.23 ([10.8.0.23]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Sat,  7 Mar 2009 19:11:28 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 07 Mar 2009 13:11:28 -0600
Subject: Re: [PATCH 06/10] Alchemy: Au1300 USB support
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <49B245F1.2090200@ru.mvista.com>
References: <> <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	 <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	 <49B245F1.2090200@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 07 Mar 2009 13:11:28 -0600
Message-Id: <1236453088.9848.7.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-03-07 at 13:01 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> Kevin Hickey wrote:
> 
> > Adds support for USB 2.0 on the Au1300 SOC.
> >
> > Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
> >   
> [...]
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 83babb0..a50d053 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -55,6 +55,7 @@ config USB_ARCH_HAS_EHCI
> >  	boolean
> >  	default y if PPC_83xx
> >  	default y if SOC_AU1200
> > +	default y if SOC_AU13XX
> >   
> 
>    Why not:
> 
> default y if SOC_AU1200 || SOC_AU13XX
> 
I was just following the pattern... there were already two other
explicit "default y if" lines.
> 
> > diff --git a/drivers/usb/host/ehci-au13xx.c b/drivers/usb/host/ehci-au13xx.c
> > new file mode 100644
> > index 0000000..fe03667
> > --- /dev/null
> > +++ b/drivers/usb/host/ehci-au13xx.c
> > @@ -0,0 +1,213 @@
> > +/*
> > + * Copyright 2008 RMI Corporation
> > + * Author: Kevin Hickey <khickey@rmicorp.com>
> > + *
> > + *  This program is free software; you can redistribute  it and/or modify it
> > + *  under  the terms of  the GNU General  Public License as published by the
> > + *  Free Software Foundation;  either version 2 of the  License, or (at your
> > + *  option) any later version.
> > + *
> > + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> > + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> > + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> > + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> > + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> > + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> > + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> > + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> > + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> > + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + *
> > + *  You should have received a copy of the  GNU General Public License along
> > + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> > + *  675 Mass Ave, Cambridge, MA 02139, USA.
> > + *
> > + *  Based on ehci-au1xxx.c.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +#include <asm/mach-au1x00/au1000.h>
> > +
> > +
> > +extern int usb_disabled(void);
> > +
> > +static void au13xx_start_ehc(void)
> > +{
> > +	AU13XX_USB* au13xx_usb = (AU13XX_USB*)(KSEG1 | USB_BASE_PHYS_ADDR);
> >   
> 
>     Your coding style is not acceptable -- run your patched thru 
> scruipts/checkpatch.pl please.
Sorry about that.
> 
> > +	/*
> > +	 * Enable clocks.
> > +	 */
> > +	AU_SET_BITS_32(USB_DWC_CTRL3_EHC_CLKEN, &au13xx_usb->dwc_ctrl3);
> > +
> > +	/*
> > +	 * Take the host controller block out of reset
> > +	 */
> > +	AU_SET_BITS_32(USB_DWC_CTRL1_HSTRS, &au13xx_usb->dwc_ctrl1);
> > +
> > +	/*
> > +	 * Enable all of the PHYs
> > +	 */
> > +	AU_SET_BITS_32(USB_DWC_CTRL2_PHYRS | USB_DWC_CTRL2_PHY0RS | USB_DWC_CTRL2_PH1RS,
> > +		       &au13xx_usb->dwc_ctrl2);
> > +
> > +	/*
> > +	 * Enable interrupts
> > +	 */
> > +	AU_SET_BITS_32(USB_INTR_EHCI, &au13xx_usb->intr_enable);
> > +
> > +	/*
> > +	 * This bit enables coherent DMA.
> > +	 */
> > +	AU_SET_BITS_32(USB_SBUS_CTRL_SBCA, &au13xx_usb->sbus_ctrl);
> > +	asm("sync");
> >   
> 
>     Don't we have au_sync()?
Yes, and I should have used it here :)
> 
> > +static int ehci_hcd_au13xx_drv_probe(struct platform_device *pdev)
> > +{
> >   
> [...]
> > +	au13xx_start_ehc();
> > +
> > +	ehci = hcd_to_ehci(hcd);
> > +	ehci->caps = hcd->regs;
> > +	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
> > +	printk("ehci->regs = %p\n", ehci->regs);
> >   
> 
>    printk() should have KERN_* facility.
Agreed.  In fact this is probably just leftover bringup/debug code that
should be eliminated.
> 
> > +static struct platform_driver ehci_hcd_au13xx_driver = {
> > +	.probe		= ehci_hcd_au13xx_drv_probe,
> > +	.remove		= ehci_hcd_au13xx_drv_remove,
> > +	.shutdown	= usb_hcd_platform_shutdown,
> > +	.suspend	= NULL,
> > +	.resume		= NULL,
> >   
> 
>    No dire need to explicitly initializer these two...
Copy-paste laziness strikes again...
> 
> WBR, Sergei
> 
> 
-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
