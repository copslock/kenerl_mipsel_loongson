Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 00:59:16 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.251]:20604 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022864AbZEOX7K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 00:59:10 +0100
Received: by rv-out-0708.google.com with SMTP id k29so1234499rvb.24
        for <multiple recipients>; Fri, 15 May 2009 16:59:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=qzRcdeDS2InFRUXBrsRti0ni3t1VxoIcAaimnvab28g=;
        b=LF1ohwFyXhG3SgpdEi5KxiMhm8WI0ugBIOdAZKg2bo/miuvLLXQhO9l8/qI0Mg15z8
         3EwOb4mf/q0UBlol+XDfhJ/EwQbmUsJ6UZvzHK8NkjOmEYhCIYWGnjwrhImivNBe4e/h
         b1vrDlvRwPRpL+TRLsixFdyycu3jqy9UI8WIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=b5f3KabX9ULTGeWDLfn8+7sUFsVM5wSr2OrxPjl3i6F68T/b/LwD00aH2KTgSX0Dys
         j9kg+PDUhi4xeQ0RghGZn6dcAhVxWyDQyQ/bVzf3Pl6DGNj8rH86G7+WtiEF4J3Jy6Fs
         v97zE0yVDxAzgw7J9sUhGuiABGCj3RPjJTOfQ=
Received: by 10.141.176.13 with SMTP id d13mr1637089rvp.231.1242431947780;
        Fri, 15 May 2009 16:59:07 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id f21sm5359464rvb.5.2009.05.15.16.59.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 16:59:06 -0700 (PDT)
Subject: Re: [PATCH 01/30] Fix warning: incompatible argument type of
 pci_fixup_irqs
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <4A0DEDD5.3000607@caviumnetworks.com>
References: <1242424728.10164.140.camel@falcon>
	 <4A0DEDD5.3000607@caviumnetworks.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 07:58:53 +0800
Message-Id: <1242431933.10164.183.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2009-05-15 at 15:33 -0700, David Daney wrote:
> Wu Zhangjin wrote:
> >>From 1e6360e89b239699ef1f5344e1d3a5c0b3c5bef1 Mon Sep 17 00:00:00 2001
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > Date: Tue, 12 May 2009 10:33:37 +0800
> > Subject: [PATCH 01/30] Fix warning: incompatible argument type of
> > pci_fixup_irqs
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=utf-8
> > Content-Transfer-Encoding: 8bit
> > 
> > arch/mips/pci/pci.c:160: warning: passing argument 2 of pci_fixup_irqs
> > from incompatible pointer type
> > 
> > include/linux/pci.h:
> > 
> > 	void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
> >             int (*)(struct pci_dev *, u8, u8));
> > 
> > arch/mips/pci/pci.c:160:
> > 
> > 	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
> > 
> > arch/mips/include/asm/pci.h:
> > 
> > 	extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);
> > 
> > arch/mips/pci/fixup-malta.c
> > 
> > 	int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > ---
> >  arch/mips/include/asm/pci.h    |    2 +-
> >  arch/mips/pci/fixup-au1000.c   |    2 +-
> >  arch/mips/pci/fixup-capcella.c |    2 +-
> >  arch/mips/pci/fixup-cobalt.c   |    2 +-
> >  arch/mips/pci/fixup-emma2rh.c  |    2 +-
> >  arch/mips/pci/fixup-excite.c   |    2 +-
> >  arch/mips/pci/fixup-ip32.c     |    2 +-
> >  arch/mips/pci/fixup-lm2e.c     |    2 +-
> >  arch/mips/pci/fixup-malta.c    |    2 +-
> >  arch/mips/pci/fixup-mpc30x.c   |    2 +-
> >  arch/mips/pci/fixup-pmcmsp.c   |    2 +-
> >  arch/mips/pci/fixup-pnx8550.c  |    2 +-
> >  arch/mips/pci/fixup-rc32434.c  |    2 +-
> >  arch/mips/pci/fixup-sni.c      |    2 +-
> >  arch/mips/pci/fixup-tb0219.c   |    2 +-
> >  arch/mips/pci/fixup-tb0226.c   |    2 +-
> >  arch/mips/pci/fixup-tb0287.c   |    2 +-
> >  arch/mips/pci/fixup-wrppmc.c   |    2 +-
> >  arch/mips/pci/fixup-yosemite.c |    2 +-
> >  arch/mips/pci/pci-bcm1480.c    |    2 +-
> >  arch/mips/pci/pci-bcm47xx.c    |    2 +-
> >  arch/mips/pci/pci-ip27.c       |    2 +-
> >  arch/mips/pci/pci-lasat.c      |    2 +-
> >  arch/mips/pci/pci-sb1250.c     |    2 +-
> >  arch/mips/txx9/generic/pci.c   |    2 +-
> >  25 files changed, 25 insertions(+), 25 deletions(-)
> > 
> [...]
> 
> Did you intend that we should do something with all these patches?
> 
> They cannot be merged without a Signed-off-by: tag.  There may be other 
> issues as well.  Did you run checkpatch.pl on them?  If not, I would 
> recommend it.  Try to fix all errors flagged by checkpatch.

sorry, forget to check it. I will do it later, thanks!

> 
> This is what I get on this patch:
> 
> ERROR: patch seems to be corrupt (line wrapped?)
> #130: FILE: arch/mips/include/asm/pci.h:55:
> pci_controller *hose);
> 
> ERROR: Missing Signed-off-by: line(s)
> 
> total: 2 errors, 0 warnings, 293 lines checked
> 
> [PATCH 01_30] Fix warning: incompatible argument type of 
> pci_fixup_irqs.eml has style problems, please review.  If any of these 
> errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 
> 
> 
> David Daney
