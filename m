Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 09:14:32 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53004 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023744AbZEUIOZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 09:14:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4L8Dt78019991;
	Thu, 21 May 2009 09:13:55 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4L8DsAp019989;
	Thu, 21 May 2009 09:13:54 +0100
Date:	Thu, 21 May 2009 09:13:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v1 01/27] fix-warning: incompatible argument
	type of pci_fixup_irqs
Message-ID: <20090521081354.GB19476@linux-mips.org>
References: <cover.1242855716.git.wuzhangjin@gmail.com> <f3a0b5ce4e2e228576f4481f4dfff8d75d33db7a.1242855716.git.wuzhangjin@gmail.com> <4A147FFC.5070608@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A147FFC.5070608@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 03:11:08PM -0700, David Daney wrote:

> This is the correct fix, however there are now Cavium Octeon PCI drivers  
> on Ralf's queue.

The reason for the const is that people keep doing very broken things in
pcibios_map_irq().  I don't see any legitimate reason why pcibios_map_irq
should modifiy the structure the first argument is pointing to, so I
changed it to const just to be a pain in the arse.  Of course the warning
should be rectified but this requires talking to the upstream PCI guys.

  Ralf
