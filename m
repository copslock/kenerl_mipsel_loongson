Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 09:07:52 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43479 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021797AbZEUIHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 09:07:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4L879aP019857;
	Thu, 21 May 2009 09:07:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4L86liT019849;
	Thu, 21 May 2009 09:06:47 +0100
Date:	Thu, 21 May 2009 09:06:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-PATCH-v1 02/27] fix-warning: incompatible argument
	type of virt_to_phys
Message-ID: <20090521080647.GA19476@linux-mips.org>
References: <cover.1242855716.git.wuzhangjin@gmail.com> <0e7026092faebce7caf6bfe9807146cffcd8842a.1242855716.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e7026092faebce7caf6bfe9807146cffcd8842a.1242855716.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 21, 2009 at 05:49:30AM +0800, wuzhangjin@gmail.com wrote:

> mm/page_alloc.c:1760: warning: passing argument 1 of ‘virt_to_phys’
> makes pointer from integer without a cast
> 
> mm/page_alloc.c:1760
> 	...
> 	unsigned long addr;
> 	...
> 	split_page(virt_to_page(addr), order);
> 
> arch/mips/include/asm/page.h
> 
> 	#define virt_to_page(kaddr) pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
> 	#define virt_addr_valid(kaddr)  pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
> 
> arch/mips/include/asm/io.h
> 	static inline unsigned long virt_to_phys(volatile const void *address)

I'm inclined to say the caller needs fixing.  Most callers are passing
some kind of pointer argument but here an unsigned long is being passed
in.  I'm checking with the mm maintainers.  For now I'll apply this patch
to my -mm queue.

  Ralf
