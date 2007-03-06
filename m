Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2007 18:06:17 +0000 (GMT)
Received: from hancock.steeleye.com ([71.30.118.248]:13261 "EHLO
	hancock.sc.steeleye.com") by ftp.linux-mips.org with ESMTP
	id S20021427AbXCFSGN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Mar 2007 18:06:13 +0000
Received: from [172.17.6.40] (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id l26I51x11230;
	Tue, 6 Mar 2007 13:05:01 -0500
Subject: Re: [parisc-linux] [PATCH 2/2] Make pcibios_add_platform_entries()
	return errors
From:	James Bottomley <James.Bottomley@SteelEye.com>
To:	Michael Ellerman <michael@ellerman.id.au>
Cc:	Greg Kroah-Hartman <greg@kroah.com>, linux-mips@linux-mips.org,
	dev-etrax@axis.com, linux-ia64@vger.kernel.org, discuss@x86-64.org,
	chris@zankel.net, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
	linux-m68k@vger.kernel.org, ink@jurassic.park.msu.ru,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, linux-pci@atrey.karlin.mff.cuni.cz,
	parisc-linux@parisc-linux.org, kernel@wantstofly.org,
	rth@twiddle.net
In-Reply-To: <20070306150725.68D97DDF36@ozlabs.org>
References: <20070306150725.68D97DDF36@ozlabs.org>
Content-Type: text/plain
Date:	Tue, 06 Mar 2007 12:05:01 -0600
Message-Id: <1173204301.3379.33.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-1.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@SteelEye.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@SteelEye.com
Precedence: bulk
X-list: linux-mips

On Tue, 2007-03-06 at 16:06 +0100, Michael Ellerman wrote:
>  int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
> @@ -644,10 +644,13 @@ int __must_check pci_create_sysfs_dev_fi
>  		}
>  	}
>  	/* add platform-specific attributes */
> -	pcibios_add_platform_entries(pdev);
> +	if (pcibios_add_platform_entries(pdev))
> +		goto err_rom_attr;
>  
>  	return 0;
>  
> +err_rom_attr:
> +	sysfs_remove_bin_file(&pdev->dev.kobj, rom_attr);

This file is only created if the rom resource has a non-zero length.  If
you unconditionally call sysfs_remove_bin_file() it's going to spit
scary warnings and dump traces in this error leg if the rom resource
doesn't exist.

James


>  err_rom:
>  	kfree(rom_attr);
>  err_bin_file:
> Index: msi-new/include/linux/pci.h
> ===================================================================
> --- msi-new.orig/include/linux/pci.h
> +++ msi-new/include/linux/pci.h
> @@ -857,7 +857,7 @@ extern int pci_pci_problems;
>  extern unsigned long pci_cardbus_io_size;
>  extern unsigned long pci_cardbus_mem_size;
>  
> -extern void pcibios_add_platform_entries(struct pci_dev *dev);
> +extern int pcibios_add_platform_entries(struct pci_dev *dev);
>  
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_PCI_H */
> _______________________________________________
> parisc-linux mailing list
> parisc-linux@lists.parisc-linux.org
> http://lists.parisc-linux.org/mailman/listinfo/parisc-linux
