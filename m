Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2003 18:18:35 +0100 (BST)
Received: from p508B61D6.dip.t-dialin.net ([IPv6:::ffff:80.139.97.214]:9367
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225389AbTHYRSc>; Mon, 25 Aug 2003 18:18:32 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7PHIB8R016167
	for <linux-mips@linux-mips.org>; Mon, 25 Aug 2003 19:18:11 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7PHI6AH016157
	for linux-mips@linux-mips.org; Mon, 25 Aug 2003 19:18:06 +0200
Date: Mon, 25 Aug 2003 19:18:05 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030825171805.GA15798@linux-mips.org>
References: <20030825170001Z8225388-1272+4466@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825170001Z8225388-1272+4466@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 25, 2003 at 05:59:56PM +0100, kwalker@linux-mips.org wrote:

> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	kwalker@ftp.linux-mips.org	03/08/25 17:59:56
> 
> Modified files:
> 	arch/mips/mm-64: init.c 
> 
> Log message:
> 	remove unnecessary HIGHMEM stuff from 64bit version

Stooop, highmem will soon be needed for 64-bit also to handle machines
that can't DMA to the entire memory.

  Ralf
