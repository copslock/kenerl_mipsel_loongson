Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2010 07:39:54 +0100 (CET)
Received: from mail-yx0-f194.google.com ([209.85.210.194]:56700 "EHLO
        mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491187Ab0BVGjv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2010 07:39:51 +0100
Received: by yxe32 with SMTP id 32so4751241yxe.0
        for <multiple recipients>; Sun, 21 Feb 2010 22:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=VwhPodmt+FHzCF+WR+I6AO74ddvjW+H4/uTheuycIRg=;
        b=OEwS8v1Hb2LP7i2LoLgkJ8xYdJctpFQ74hondwyXpx1lrtYMv7WbJVHIKDzshasfUL
         6h+Suw6bvXtpjjSU0wcvRriVw5jerY6HlMmjgE1OtlsISI2tnM4w1KfPHTHXSM3se0qX
         WAKWnqtsGcu4Q0mrSlgfrr1oK3Ab1Pm5mgUOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Plxp9z6lmtVAMYtlUsE5T597E/nJvYFZM7t03NTv6sm3q2HaCvoUqxd19YH+woPFjz
         3eaCn8BV0u8pTskU2vuwgU0ZtW5RsnxWPE65Q3MBVnh3XvRkL2wivNFj3bGEBIEg4R3Z
         dKeWC0GqfIz+LWcaGEu+XEWnukGu73Ng4t1q0=
Received: by 10.101.144.1 with SMTP id w1mr2942970ann.61.1266820783149;
        Sun, 21 Feb 2010 22:39:43 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm3058295gxk.7.2010.02.21.22.39.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 22:39:42 -0800 (PST)
Date:   Mon, 22 Feb 2010 15:39:32 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     yuasa@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: Reverting old hack
Message-Id: <20100222153932.af1ddc58.yuasa@linux-mips.org>
In-Reply-To: <1266815257.1959.23.camel@dc7800.home>
References: <20100220113134.GA27194@linux-mips.org>
        <20100220211805.6a33e9e2.yuasa@linux-mips.org>
        <1266815257.1959.23.camel@dc7800.home>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Bjorn,

On Sun, 21 Feb 2010 22:07:37 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> On Sat, 2010-02-20 at 21:18 +0900, Yoichi Yuasa wrote:
> > Hi Ralf,
> > 
> > On Sat, 20 Feb 2010 12:31:34 +0100
> > Ralf Baechle <ralf@linux-mips.org> wrote:
> > 
> > > Below 9f7670e4ddd940d95e48997c2da51614e5fde2cf, an old hack which I
> > > committed in December '07 I think mostly for Cobalt machines.  This is
> > > now getting in the way - in fact the whole loop in
> > > pcibios_fixup_device_resources() may have to go.  So I wonder if this
> > > old hack is still necessary.  Only testing can answer so I'm going to
> > > put a patch to revert this into the -queue tree for 2.6.34.
> > 
> > It is still necessary for Cobalt.
> > I got the following IDE resource errors.
> > 
> > pata_via 0000:00:09.1: BAR 0: can't reserve [io  0xf00001f0-0xf00001f7]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 0 (errno=-16)      
> > pata_via 0000:00:09.1: BAR 2: can't reserve [io  0xf0000170-0xf0000177]         
> > pata_via 0000:00:09.1: failed to request/iomap BARs for port 1 (errno=-16)      
> > pata_via 0000:00:09.1: no available native port 
> 
> I think Cobalt needs something like the patch below, because I think in
> your working system, pata_via is using I/O port 0x1f0, not 0xf00001f0.
> That means the the port the driver sees in the pci_dev resource is
> identical to the port number that appears on the PCI bus, so there is no
> io_offset.
> 
> There are a few other places that may set non-zero io_offset values:
> bcm1480, bcm1480ht. txx9_alloc_pci_controller(), bridge_probe(), and
> octeon_pcie_setup().  I don't know whether they have similar issues.
> 
> 
> 
> commit 7378269220d477118257d898bec9173743675f5e
> Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date:   Sat Feb 20 07:52:29 2010 -0700
> 
>     [MIPS] remove Cobalt I/O space offset
>     
>     On Cobalt, "inb(x)" produces an I/O port access to port "x" on the PCI
>     bus, which means the io_offset is zero and CPU (resource) addresses are
>     identical to PCI bus addresses.  Correcting this means we can remove
>     the IORESOURCE_PCI_FIXED check from pcibios_fixup_device_resources().
>     
>     The io_map_base is used internally by pci_iomap(), inb(), and other I/O
>     port access functions to generate an MMIO access to the address that
>     produces the desired I/O port PCI transaction.
>     
>     [Cobalt plat_mem_setup() does this:
>       set_io_port_base(CKSEG1ADDR(GT_DEF_PCI0_IO_BASE));
>     rather than using cobalt_pci_controller.io_map_base, but the value's
>     the same, and I don't know enough to clean that up.]
>     
>     See http://lkml.org/lkml/2007/7/29/27
>     
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> diff --git a/arch/mips/cobalt/pci.c b/arch/mips/cobalt/pci.c
> index cfce7af..84aa205 100644
> --- a/arch/mips/cobalt/pci.c
> +++ b/arch/mips/cobalt/pci.c
> @@ -34,7 +34,6 @@ static struct pci_controller cobalt_pci_controller = {
>  	.pci_ops	= &gt64xxx_pci0_ops,
>  	.mem_resource	= &cobalt_mem_resource,
>  	.io_resource	= &cobalt_io_resource,
> -	.io_offset	= 0 - GT_DEF_PCI0_IO_BASE,
>  	.io_map_base	= CKSEG1ADDR(GT_DEF_PCI0_IO_BASE),
>  };

io_offset is necessary for DEC tulip on Cobalt. 
It doesn't work when this patch is applied. 

Yoichi
