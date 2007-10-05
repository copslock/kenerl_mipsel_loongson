Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:21:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62904 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022005AbXJEMVY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:21:24 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l95CLM84022371;
	Fri, 5 Oct 2007 13:21:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l95CLMqO022370;
	Fri, 5 Oct 2007 13:21:22 +0100
Date:	Fri, 5 Oct 2007 13:21:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/ip32: enable PCI bridges
Message-ID: <20071005122122.GA22239@linux-mips.org>
References: <E1IdXwW-0004Ja-08@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1IdXwW-0004Ja-08@eppesuigoccas.homedns.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 11:09:12PM +0200, Giuseppe Sacco wrote:

> Fixes MACE PCI addressing adding the bus number parameter.
> Remove check of the used slot since every slot should be valid.
> Converted mkaddr from #define to inline function.
> 
> Signed-off-by: Giuseppe Sacco <eppesuig@debian.org>

Thanks, applied.

  Ralf
