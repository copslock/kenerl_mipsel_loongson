Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TG8YnC021838
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 09:08:34 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TG8YBI021837
	for linux-mips-outgoing; Wed, 29 May 2002 09:08:34 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TG8GnC021834
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 09:08:20 -0700
Received: from prefect.mshome.net ([192.168.0.76] helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17D5zG-000582-00; Wed, 29 May 2002 12:07:46 -0400
Message-ID: <009701c2072b$2b1e2820$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Brian Murphy" <brian@murphy.dk>, "linux-mips" <linux-mips@oss.sgi.com>
References: <3CF4CA8C.9040802@murphy.dk>
Subject: Re: ioremap?
Date: Wed, 29 May 2002 12:09:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Looks like those are for io (inb, outb, etc.) not mem (readb, writeb, etc.).
io addresses shouldn't be ioremapped.

Regards,
Brad

----- Original Message -----
From: "Brian Murphy" <brian@murphy.dk>
To: "linux-mips" <linux-mips@oss.sgi.com>
Sent: Wednesday, May 29, 2002 8:33 AM
Subject: ioremap?


> In three files/drivers I have had problems with physical addresses not
> being ioremapped.
> I include my patch to fix things up and request comments. How come
> others don't have similar
> problems?
>
> /Brian
>


----------------------------------------------------------------------------
----


> --- drivers/ide/ide-dma.c 2001/10/19 01:24:24 1.9
> +++ drivers/ide/ide-dma.c 2002/05/29 11:49:14
> @@ -741,7 +741,8 @@
>   if (hwif->mate && hwif->mate->dma_base) {
>   dma_base = hwif->mate->dma_base - (hwif->channel ? 0 : 8);
>   } else {
> - dma_base = pci_resource_start(dev, 4);
> + dma_base = ioremap(pci_resource_start(dev, 4),
> + pci_resource_len(dev, 4));
>   if (!dma_base) {
>   printk("%s: dma_base is invalid (0x%04lx)\n", name, dma_base);
>   dma_base = 0;
> --- drivers/ide/ide-pci.c 2001/11/19 13:53:59 1.20
> +++ drivers/ide/ide-pci.c 2002/05/29 11:49:15
> @@ -716,8 +716,10 @@
>   if (IDE_PCI_DEVID_EQ(d->devid, DEVID_HPT366) && (port) && (class_rev <
0x03))
>   return;
>   if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE || (dev->class & (port ?
4 : 1)) != 0) {
> - ctl  = dev->resource[(2*port)+1].start;
> - base = dev->resource[2*port].start;
> + ctl = ioremap(pci_resource_start(dev, (2*port)+1),
> +               pci_resource_len(dev, (2*port)+1));
> + base = ioremap(pci_resource_start(dev, 2*port),
> +               pci_resource_len(dev, 2*port));
>   if (!(ctl & PCI_BASE_ADDRESS_IO_MASK) ||
>       !(base & PCI_BASE_ADDRESS_IO_MASK)) {
>   printk("%s: IO baseregs (BIOS) are reported as MEM, report to
<andre@linux-ide.org>.\n", d->name);
> --- drivers/net/pcnet32.c 2002/02/26 05:59:35 1.33.2.1
> +++ drivers/net/pcnet32.c 2002/05/29 11:49:18
> @@ -494,7 +494,8 @@
>      }
>      pci_set_master(pdev);
>
> -    ioaddr = pci_resource_start (pdev, 0);
> +    ioaddr = ioremap(pci_resource_start (pdev, 0),
> +     pci_resource_len (pdev, 0));
>      printk(KERN_INFO "    ioaddr=%#08lx  resource_flags=%#08lx\n",
ioaddr, pci_resource_flags (pdev, 0));
>      if (!ioaddr) {
>          printk (KERN_ERR "no PCI IO resources, aborting\n");
>
>
