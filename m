Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 11:49:49 +0200 (CEST)
Received: from mail.gmx.net ([213.165.64.20]:38353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492405AbZJGJtn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Oct 2009 11:49:43 +0200
Received: (qmail invoked by alias); 07 Oct 2009 09:49:34 -0000
Received: from unknown (EHLO localhost) [80.123.121.196]
  by mail.gmx.net (mp013) with SMTP; 07 Oct 2009 11:49:34 +0200
X-Authenticated: #20192376
X-Provags-ID: V01U2FsdGVkX1+OQQwSZcSOjaUizC1rKeyzxzTqDAFRVXTseDyigb
	xFXylw+CAzHizp
From:	Andreas Fenkart <andreas.fenkart@streamunlimited.com>
To:	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	linux-am33-list@redhat.com, liqin.chen@sunplusct.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Make totalhigh_pages of consistent type.
Date:	Wed,  7 Oct 2009 11:49:36 +0200
Message-Id: <1254908977-12827-1-git-send-email-andreas.fenkart@streamunlimited.com>
X-Mailer: git-send-email 1.6.4.3
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Return-Path: <afenkart@gmx.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.fenkart@streamunlimited.com
Precedence: bulk
X-list: linux-mips

Printing the value of totalhigh_pages requires casting, see
typical print message:

arch/x86/mm/init_32.c:
  printk(KERN_INFO "Memory: %luk/%luk available (%dk kernel code, "
      "%dk reserved, %dk data, %dk init, %ldk highmem)\n",
    nr_free_pages() << (PAGE_SHIFT-10),
    num_physpages << (PAGE_SHIFT-10),
    codesize >> 10,
    reservedpages << (PAGE_SHIFT-10),
    datasize >> 10,
    initsize >> 10,
    (unsigned long)(totalhigh_pages << (PAGE_SHIFT-10)));


The problem is that the type of totalhigh_pages is dependent on
CONFIG_HIGHMEM being set or not.

include/linux/highmem.h:
  #ifdef CONFIG_HIGHMEM
  
  extern unsigned long totalhigh_pages;
  
  #else /* CONFIG_HIGHMEM */
  
 -#define totalhigh_pages 0
 +#define totalhigh_pages 0UL
  ...

The patch changes the define, so that totalhigh_pages is of uniform
type in both cases.

Patch is build-tested on x86_32 and ARM

kind regards

Andreas
