Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jan 2007 19:51:53 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:2283 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20046081AbXAJTvv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jan 2007 19:51:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0AJqdNg010321;
	Wed, 10 Jan 2007 19:52:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0AJqclf010320;
	Wed, 10 Jan 2007 19:52:38 GMT
Date:	Wed, 10 Jan 2007 19:52:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Bigga <ab@mycable.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix PCI-memory access on Alchemy Au15x0
Message-ID: <20070110195238.GA10283@linux-mips.org>
References: <20061221102519.GA11796@mycable-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221102519.GA11796@mycable-alex>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 21, 2006 at 11:25:19AM +0100, Alexander Bigga wrote:

> The problem was introduced in 2.6.18.3 with the casting of some 36bit-defines
> (PCI memory) in au1000.h to resource_size_t which may be u32 or u64 depending on
> the experimental CONFIG_RESOURCES_64BIT.
> 
> With unset CONFIG_RESOURCES_64BIT, the pci-memory cannot be accessed because
> the ioremap in arch/mips/au1000/common/pci.c already used the truncated
> addresses.
> With set CONFIG_RESOURCES_64BIT, things get even worse, because PCI-scan
> aborts, due to resource conflict: request_resource() in arch/mips/pci/pci.c
> fails because the maximum iomem-address is 0xffffffff (32bit) but the
> pci-memory-start-address is 0x440000000 (36bit).
> 
> To get pci working again, I propose the following patch:
> 
> 1. remove the resource_size_t-casting from au1000.h again
> 2. make the casting in arch/mips/au1000/common/pci.c (it's allowed and
> necessary here. The 36bit-handling will be done in __fixup_bigphys_addr).
> 
> With this patch pci works again like in 2.6.18.2, the gcc-compile warnings
> in pci.c are gone and it doesn't depend on CONFIG_EXPERIMENTAL.
> 
> Only advantages ;-) Nevertheless, I'm open for your comments or even better
> solutions.

Looks reasonable, applied.

  Ralf
