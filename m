Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 13:05:32 +0100 (BST)
Received: from p508B7A8B.dip.t-dialin.net ([IPv6:::ffff:80.139.122.139]:31096
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224911AbUHTMF2>; Fri, 20 Aug 2004 13:05:28 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7KC5Qto003567;
	Fri, 20 Aug 2004 14:05:26 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7KC5Qug003566;
	Fri, 20 Aug 2004 14:05:26 +0200
Date: Fri, 20 Aug 2004 14:05:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Song Wang <wsonguci@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Should #ifdef __KERNEL__ be added before #include <spaces.h> in asm-mips/addrspace.h ?
Message-ID: <20040820120526.GA27130@linux-mips.org>
References: <20040721000356.39366.qmail@web40003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721000356.39366.qmail@web40003.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 20, 2004 at 05:03:56PM -0700, Song Wang wrote:

> Should #ifdef _KERNEL__ be added before #include
> <spaces.h> in asm-mips/addrspace.h?
> 
> I think the reason is the same as when you added
> the #ifdef __KERNEL__ before #include <spaces.h>
> for asm-mips/page.h.

Some userspace software is expecting to get PAGE_SHIFT, PAGE_SIZE and
PAGE_MASK to be available in userspace via <asm/page.h>, so I
protected the inclusion of <asm/spaces.h> with __KERNEL__ but left
the definitions of these symbols unprotected.

  Ralf
