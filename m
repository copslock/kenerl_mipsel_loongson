Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:35:32 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:24469 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023430AbZEOWf0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:35:26 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a0dedf30000>; Fri, 15 May 2009 18:34:27 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 May 2009 15:33:58 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 15 May 2009 15:33:58 -0700
Message-ID: <4A0DEDD5.3000607@caviumnetworks.com>
Date:	Fri, 15 May 2009 15:33:57 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 01/30] Fix warning: incompatible argument type of pci_fixup_irqs
References: <1242424728.10164.140.camel@falcon>
In-Reply-To: <1242424728.10164.140.camel@falcon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 May 2009 22:33:58.0267 (UTC) FILETIME=[3CC98CB0:01C9D5AD]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
>>From 1e6360e89b239699ef1f5344e1d3a5c0b3c5bef1 Mon Sep 17 00:00:00 2001
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> Date: Tue, 12 May 2009 10:33:37 +0800
> Subject: [PATCH 01/30] Fix warning: incompatible argument type of
> pci_fixup_irqs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: 8bit
> 
> arch/mips/pci/pci.c:160: warning: passing argument 2 of ‘pci_fixup_irqs’
> from incompatible pointer type
> 
> include/linux/pci.h:
> 
> 	void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
>             int (*)(struct pci_dev *, u8, u8));
> 
> arch/mips/pci/pci.c:160:
> 
> 	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
> 
> arch/mips/include/asm/pci.h:
> 
> 	extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> 
> arch/mips/pci/fixup-malta.c
> 
> 	int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> ---
>  arch/mips/include/asm/pci.h    |    2 +-
>  arch/mips/pci/fixup-au1000.c   |    2 +-
>  arch/mips/pci/fixup-capcella.c |    2 +-
>  arch/mips/pci/fixup-cobalt.c   |    2 +-
>  arch/mips/pci/fixup-emma2rh.c  |    2 +-
>  arch/mips/pci/fixup-excite.c   |    2 +-
>  arch/mips/pci/fixup-ip32.c     |    2 +-
>  arch/mips/pci/fixup-lm2e.c     |    2 +-
>  arch/mips/pci/fixup-malta.c    |    2 +-
>  arch/mips/pci/fixup-mpc30x.c   |    2 +-
>  arch/mips/pci/fixup-pmcmsp.c   |    2 +-
>  arch/mips/pci/fixup-pnx8550.c  |    2 +-
>  arch/mips/pci/fixup-rc32434.c  |    2 +-
>  arch/mips/pci/fixup-sni.c      |    2 +-
>  arch/mips/pci/fixup-tb0219.c   |    2 +-
>  arch/mips/pci/fixup-tb0226.c   |    2 +-
>  arch/mips/pci/fixup-tb0287.c   |    2 +-
>  arch/mips/pci/fixup-wrppmc.c   |    2 +-
>  arch/mips/pci/fixup-yosemite.c |    2 +-
>  arch/mips/pci/pci-bcm1480.c    |    2 +-
>  arch/mips/pci/pci-bcm47xx.c    |    2 +-
>  arch/mips/pci/pci-ip27.c       |    2 +-
>  arch/mips/pci/pci-lasat.c      |    2 +-
>  arch/mips/pci/pci-sb1250.c     |    2 +-
>  arch/mips/txx9/generic/pci.c   |    2 +-
>  25 files changed, 25 insertions(+), 25 deletions(-)
> 
[...]

Did you intend that we should do something with all these patches?

They cannot be merged without a Signed-off-by: tag.  There may be other 
issues as well.  Did you run checkpatch.pl on them?  If not, I would 
recommend it.  Try to fix all errors flagged by checkpatch.

This is what I get on this patch:

ERROR: patch seems to be corrupt (line wrapped?)
#130: FILE: arch/mips/include/asm/pci.h:55:
pci_controller *hose);

ERROR: Missing Signed-off-by: line(s)

total: 2 errors, 0 warnings, 293 lines checked

[PATCH 01_30] Fix warning: incompatible argument type of 
pci_fixup_irqs.eml has style problems, please review.  If any of these 
errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.




David Daney
