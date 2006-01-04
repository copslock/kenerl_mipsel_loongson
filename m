Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 12:32:24 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:11444 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133488AbWADMcG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Jan 2006 12:32:06 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k04CYVc7017371;
	Wed, 4 Jan 2006 04:34:31 -0800
Received: from 163.181.250.1 by SSVLGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Wed, 04 Jan 2006 04:32:21 -0800
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Received: from elbe.amd.com (elbe.amd.com [172.20.31.2]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k04CWHh5023833; Wed,
 4 Jan 2006 06:32:18 -0600 (CST)
Received: from bobritzsch.amd.com by elbe.amd.com (8.8.8+Sun/AMD-S-2.0)
 id NAA29633; Wed, 4 Jan 2006 13:32:17 +0100 (MET)
From:	"Matthias Lenk" <matthias.lenk@amd.com>
Reply-to: matthias.lenk@amd.com
Organization: AMD
To:	"Matej Kupljen" <matej.kupljen@ultra.si>
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
Date:	Wed, 4 Jan 2006 13:32:15 +0100
User-Agent: KMail/1.8.2
cc:	"Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	linux-usb-devel@lists.sourceforge.net
References: <20051208210042.GB17458@cosmic.amd.com>
 <20060103155447.GI15770@cosmic.amd.com>
 <1136376726.27748.32.camel@localhost.localdomain>
In-Reply-To: <1136376726.27748.32.camel@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <200601041332.16043.matthias.lenk@amd.com>
X-WSS-ID: 6FA51FDE2BK1886933-01-01
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <matthias.lenk@amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthias.lenk@amd.com
Precedence: bulk
X-list: linux-mips

Hi Matej ,

I looked into the issue and came to the same conclusions as you. Something 
significant has changed from 2.6.15rc2 (what the patch was made for) to 
2.6.15rc5. I added the initialization of the caps and regs fields of the ehci 
structure to the probe function in ehci-au1xxx.c. The driver doesn't crash 
anymore but does not work either.

I also tried the Au1xxx OHCI and it hangs while loading the module with rc7. 
So it'll probably take some time to port the Au1200 EHCI and OHCI drivers to 
2.6.15rc7 (again!). 

Any hints on what has changed are appreciated.

Thanks,

Matthias

On Wednesday 04 January 2006 13:12, Matej Kupljen wrote:
> Hi
>
> (After some confusion about kernel version, I think I found the
> problem, sorry about that).
>
> I used binutils 2.15 and 2.16.1, but did not work.
>
> The code in the ehci-hcd.c looks like this:
> ---------------------------------------------------------------------------
>- ehci->periodic_size = DEFAULT_I_TDPS;
> 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
> 		return retval;
>
> 	/* controllers may cache some of the periodic schedule ... */
> 	hcc_params = readl(&ehci->caps->hcc_params);
> 	if (HCC_ISOC_CACHE(hcc_params)) 	// full frame cache
> 		ehci->i_thresh = 8;
> 	else					// N microframes cached
> 		ehci->i_thresh = 2 + HCC_ISOC_THRES(hcc_params);
> ---------------------------------------------------------------------------
>-
>
> The problem is *AFTER* the call to ehci_mem_init, where a read from
> ehci->caps->hcc_params is attempted, but caps is NULL.
>
> This can be seen by this assembly code form Insight:
> ---------------------------------------------------------------------------
>- 0x80350758	jal	0x802a3f40 <memset>
> 0x8035075c	sll	a2,a2,0x2
> 0x80350760	lw	v1,0(s0)
> 0x80350764	lw	a2,8(v1)
>
> s0 points to ehci
> at offset 0 from ehci is caps
> and at offset 8 from caps is hcc_params
> ---------------------------------------------------------------------------
>-
>
> Where should the caps be initialized?
> The only place, where it is set in drivers/usb/ is in
> drivers/usb/host/ehci-pci.c:
> ---------------------------------------------------------------------------
>- /* called during probe() after chip reset completes */
> static int ehci_pci_setup(struct usb_hcd *hcd)
> {
>         struct ehci_hcd         *ehci = hcd_to_ehci(hcd);
>         struct pci_dev          *pdev =
> to_pci_dev(hcd->self.controller);
>         u32                     temp;
>         int                     retval;
>
>         ehci->caps = hcd->regs;
> ---------------------------------------------------------------------------
>- But the ehci-pci.c is not included in the compilation, because at the end
> of ehci-hcd.c we find:
> ---------------------------------------------------------------------------
>- #if defined(CONFIG_SOC_AU1X00)
> #include "ehci-au1xxx.c"
> #elif defined(CONFIG_PCI)
> #include "ehci-pci.c"
> #else
> #error "missing bus glue for ehci-hcd"
> #endif
> ---------------------------------------------------------------------------
>-
>
> What should be done?
> I hope this helps.
>
> BR,
> Matej
