Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jul 2006 15:35:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:59886 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3466333AbWGFOfZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Jul 2006 15:35:25 +0100
Received: from localhost (p4085-ipad209funabasi.chiba.ocn.ne.jp [58.88.115.85])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 211ABB6DB; Thu,  6 Jul 2006 23:35:19 +0900 (JST)
Date:	Thu, 06 Jul 2006 23:36:34 +0900 (JST)
Message-Id: <20060706.233634.59465089.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44AD0C2B.7060204@innova-card.com>
References: <44ABC59C.6070607@innova-card.com>
	<20060705.231737.59032119.anemo@mba.ocn.ne.jp>
	<44AD0C2B.7060204@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 06 Jul 2006 15:12:11 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Ok thinking more about it, some platforms may have physical memory
> that doesn't start at 0. MIPS doesn't support such platform though it
> should be fairly easy. In that case __pa should be defined as:
> 
> 	#define __pa(x)	((unsigned long) (x) - PAGE_OFFSET + PFN_PHYS(ARCH_PFN_OFFSET))
> 
> and use in your patch:
> 
> 	free_area_init_node(0, NODE_DATA(0), zones_size, ARCH_PFN_OFFSET, zholes_size);
> 
> So I would recommend to use ARCH_PFN_OFFSET.

Well, currently ARCH_PFN_OFFSET is defined in
asm-generic/memory_model.h only for FLATMEM case.  I think other
memory models do not need it because it is just a case that a first
hole begins at pfn 0.

---
Atsushi Nemoto
