Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 10:19:39 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:24769
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20024772AbYH0JTh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 10:19:37 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7R9JasY002365;
	Wed, 27 Aug 2008 10:19:36 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7R9JZNQ002342;
	Wed, 27 Aug 2008 10:19:35 +0100
Date:	Wed, 27 Aug 2008 10:19:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove never used pci_probe variable
Message-ID: <20080827091935.GA28714@linux-mips.org>
References: <20080419.003435.26096353.anemo@mba.ocn.ne.jp> <20080708.011426.08077033.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080708.011426.08077033.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 08, 2008 at 01:14:26AM +0900, Atsushi Nemoto wrote:

> Nobody overwrite pci_probe.  Remove it.  Also make
> pcibios_assign_all_busses weak so that platform code can overwrite it.

> diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> index 9dd6e01..a3dcfd4 100644
> --- a/arch/mips/pci/pci.c
> +++ b/arch/mips/pci/pci.c
> @@ -21,10 +21,6 @@
>   */
>  int pci_probe_only;
>  
> -#define PCI_ASSIGN_ALL_BUSSES	1
> -
> -unsigned int pci_probe = PCI_ASSIGN_ALL_BUSSES;
> -
>  /*
>   * The PCI controller list.
>   */
> @@ -221,9 +217,9 @@ void pcibios_set_master(struct pci_dev *dev)
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
>  
> -unsigned int pcibios_assign_all_busses(void)
> +unsigned int __weak pcibios_assign_all_busses(void)
>  {
> -	return (pci_probe & PCI_ASSIGN_ALL_BUSSES) ? 1 : 0;
> +	return 1;
>  }
>  
>  int __weak pcibios_plat_dev_init(struct pci_dev *dev)

I think real problem here is that we have two variables which both serve the
same purpose, pci_probe_only and pci_probe, no?  Not entirely sure here
because the alpha defines:

arch/alpha/include/asm/pci.h:#define pcibios_assign_all_busses()        1

yet it has pci_probe_only ...

  Ralf
