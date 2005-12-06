Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 17:56:41 +0000 (GMT)
Received: from [212.175.13.129] ([212.175.13.129]:63742 "EHLO
	fep03.ttnet.net.tr") by ftp.linux-mips.org with ESMTP
	id S8133718AbVLFR4V (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 17:56:21 +0000
Received: from zenon ([81.213.120.225]) by fep03.ttnet.net.tr with ESMTP
          id <20051206175233.TAHO5148.fep03.ttnet.net.tr@zenon>
          for <linux-mips@linux-mips.org>; Tue, 6 Dec 2005 19:52:33 +0200
Date:	Tue, 6 Dec 2005 19:55:39 +0200
From:	Bora Sahin <bora.sahin@ttnet.net.tr>
Reply-To: =?ISO-8859-9?B?Qm9yYSDeYWhpbg==?= <bora.sahin@ttnet.net.tr>
X-Priority: 3 (Normal)
Message-ID: <1631352046.20051206195539@ttnet.net.tr>
To:	linux-mips@linux-mips.org
Subject: DBAu1200 & Alchemy
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9
Content-Transfer-Encoding: 8bit
X-NAI-Spam-Rules: 1 Rules triggered
	BAYES_00=-2.5
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips

Hi,

While I was working on the graphic console support of DbAu1200, I realized that
USB controller of it is a bit different from the other Alchemy family members.
As far as I understood, only OHCI support is matter(Perhaps OTG but because I am
not interested in now, didnt include; EHCI depends on PCI stuff etc.) and in
order to work needs a bus glue logic different from e.g. Au1550. If I compile it
as is, kernel gives an error message saying that USB_HOST_CONFIG is undefined in
au1xxx_start_hc()...

I am totaly new to USB stuff bus as far as I understood, if I correct this
function accordingly, I can enable USB stuff. So I examined the databook and did
the following change and ifdefing the change to CONFIG_SOC_AU1200...

au1xxx_start_hc()
{
    ...
    au_writel(au_readl(USB_MSR_BASE + USB_MSR_MCFG) | 1 << USBMSRMCFG_OHCCLKEN,
                                    USB_MSR_BASE + USB_MSR_MCFG);
    au_writel(au_readl(USB_MSR_BASE + USB_MSR_MCFG) | 1 << USBMSRMCFG_OMEMEN,
                                    USB_MSR_BASE + USB_MSR_MCFG);
    au_writel(au_readl(USB_MSR_BASE + USB_MSR_MCFG) | 1 << USBMSRMCFG_OBMEN,
                                    USB_MSR_BASE + USB_MSR_MCFG);
    ...
}

So it seemed to work a bit. Firstly, I get the following messages and the kernel
goes on after a bit time passed...

u1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
au1xxx-ohci au1xxx-ohci.0: new USB bus registered, assigned bus number 1
au1xxx-ohci au1xxx-ohci.0: irq 29, io mem 0x14020100
usb usb1: Product: Au1xxx OHCI
usb usb1: Manufacturer: Linux 2.6.15-rc4-g2b269cc6 ohci_hcd
usb usb1: SerialNumber: Au1xxx
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using au1xxx-ohci and address 2
au1xxx-ohci au1xxx-ohci.0: Unlink after no-IRQ?  Controller is probably using the wrong IRQ.

Then rootfs is mounted and I continue to receive the following error messages:

au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus [0] = 0x00100303 PRSC LSDA PPS PES CCS
Dec 31 19:33:20 off kernel: usb 1-1: new low speed USB device using au1xxx-ohci and address 12
Dec 31 19:33:27 off kernel: usb 1-1: khubd timed out on ep0out len=0/0
usb 1-1: device not accepting address 12, error -145
Dec 31 19:33:35 off kernel: usb 1-1: khubd timed out on ep0out len=0/0
Dec 31 19:33:35 off kernel: usb 1-1: device not accepting address 12, error -145
Dec 31 19:33:35 off kernel: kobject <NULL>: cleaning up

Before digging through much, I want to get your points.

In the meanwhile, in the include/asm-mips/mach-au1x00/au1000.h file there are
two defines named
    #define USBMSRMCFG_RDCOMB 30
    #define USBMSRMCFG_PFEN 31
but these are not showed in the Au1200 databook. What is this? I tried enabling
them one-to-one, both; but didnt get a result...

--
Bora SAHIN
