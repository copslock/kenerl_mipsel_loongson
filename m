Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 12:10:02 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:19656 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133488AbWADMJo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 12:09:44 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 6E894C091;
	Wed,  4 Jan 2006 13:12:07 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 14E0E1BC085;
	Wed,  4 Jan 2006 13:12:10 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 743181A18B0;
	Wed,  4 Jan 2006 13:12:09 +0100 (CET)
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jordan Crouse <jordan.crouse@amd.com>
Cc:	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net,
	matthias.lenk@amd.com
In-Reply-To: <20060103155447.GI15770@cosmic.amd.com>
References: <20051208210042.GB17458@cosmic.amd.com>
	 <1136298329.6765.22.camel@localhost.localdomain>
	 <20060103155447.GI15770@cosmic.amd.com>
Content-Type: text/plain
Date:	Wed, 04 Jan 2006 13:12:06 +0100
Message-Id: <1136376726.27748.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

(After some confusion about kernel version, I think I found the
problem, sorry about that).

I used binutils 2.15 and 2.16.1, but did not work.

The code in the ehci-hcd.c looks like this:
----------------------------------------------------------------------------
	ehci->periodic_size = DEFAULT_I_TDPS;
	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
		return retval;

	/* controllers may cache some of the periodic schedule ... */
	hcc_params = readl(&ehci->caps->hcc_params);
	if (HCC_ISOC_CACHE(hcc_params)) 	// full frame cache
		ehci->i_thresh = 8;
	else					// N microframes cached
		ehci->i_thresh = 2 + HCC_ISOC_THRES(hcc_params);
----------------------------------------------------------------------------

The problem is *AFTER* the call to ehci_mem_init, where a read from
ehci->caps->hcc_params is attempted, but caps is NULL.

This can be seen by this assembly code form Insight:
----------------------------------------------------------------------------
0x80350758	jal	0x802a3f40 <memset>
0x8035075c	sll	a2,a2,0x2
0x80350760	lw	v1,0(s0)
0x80350764	lw	a2,8(v1)

s0 points to ehci
at offset 0 from ehci is caps
and at offset 8 from caps is hcc_params
----------------------------------------------------------------------------

Where should the caps be initialized?
The only place, where it is set in drivers/usb/ is in
drivers/usb/host/ehci-pci.c:
----------------------------------------------------------------------------
/* called during probe() after chip reset completes */
static int ehci_pci_setup(struct usb_hcd *hcd)
{
        struct ehci_hcd         *ehci = hcd_to_ehci(hcd);
        struct pci_dev          *pdev =
to_pci_dev(hcd->self.controller);
        u32                     temp;
        int                     retval;

        ehci->caps = hcd->regs;
----------------------------------------------------------------------------
But the ehci-pci.c is not included in the compilation, because at the
end of ehci-hcd.c we find:
----------------------------------------------------------------------------
#if defined(CONFIG_SOC_AU1X00)
#include "ehci-au1xxx.c"
#elif defined(CONFIG_PCI)
#include "ehci-pci.c"
#else
#error "missing bus glue for ehci-hcd"
#endif
----------------------------------------------------------------------------

What should be done?
I hope this helps.

BR,
Matej
