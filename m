Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 18:04:54 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:44752 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225425AbTIRREv>; Thu, 18 Sep 2003 18:04:51 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA21405;
	Thu, 18 Sep 2003 19:04:44 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 18 Sep 2003 19:04:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ddb5477 fixes for 2.6
In-Reply-To: <20030918163344.GA22013@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1030918185742.20533A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, Daniel Jacobowitz wrote:

> --- arch/mips/pci/pci.c	22 Jun 2003 23:09:48 -0000	1.3
> +++ arch/mips/pci/pci.c	18 Sep 2003 16:25:08 -0000
> @@ -66,6 +66,8 @@
>  extern void pcibios_fixup(void);
>  extern void pcibios_fixup_irqs(void);
>  
> +#if 0
> +
>  void __init pcibios_fixup_irqs(void)
>  {
>  	struct pci_dev *dev = NULL;
> @@ -126,6 +128,8 @@ void __init pcibios_fixup_resources(stru
>  	}
>  
>  }
> +
> +#endif
>  
>  struct pci_fixup pcibios_fixups[] = {
>  	{PCI_FIXUP_HEADER, PCI_ANY_ID, PCI_ANY_ID,

 Is it OK for other PCI systems?

> --- include/asm-mips/addrspace.h	9 Aug 2003 21:16:38 -0000	1.11
> +++ include/asm-mips/addrspace.h	18 Sep 2003 16:25:13 -0000
> @@ -75,14 +75,14 @@
>   * The compatibility segments use the full 64-bit sign extended value.  Note
>   * the R8000 doesn't have them so don't reference these in generic MIPS code.
>   */
> -#define XKUSEG			0x0000000000000000
> -#define XKSSEG			0x4000000000000000
> -#define XKPHYS			0x8000000000000000
> -#define XKSEG			0xc000000000000000
> -#define CKSEG0			0xffffffff80000000
> -#define CKSEG1			0xffffffffa0000000
> -#define CKSSEG			0xffffffffc0000000
> -#define CKSEG3			0xffffffffe0000000
> +#define XKUSEG			0x0000000000000000ULL
> +#define XKSSEG			0x4000000000000000ULL
> +#define XKPHYS			0x8000000000000000ULL
> +#define XKSEG			0xc000000000000000ULL
> +#define CKSEG0			0xffffffff80000000ULL
> +#define CKSEG1			0xffffffffa0000000ULL
> +#define CKSSEG			0xffffffffc0000000ULL
> +#define CKSEG3			0xffffffffe0000000ULL
>  
>  /*
>   * Cache modes for XKPHYS address conversion macros

 Why do you want these suffixes?  They don't work for assembly sources.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
