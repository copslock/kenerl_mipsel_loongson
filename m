Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 01:59:50 +0100 (BST)
Received: from p508B762C.dip.t-dialin.net ([IPv6:::ffff:80.139.118.44]:55420
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226485AbUGHA7q>; Thu, 8 Jul 2004 01:59:46 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i680xjaR017340;
	Thu, 8 Jul 2004 02:59:45 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i680xjaF017339;
	Thu, 8 Jul 2004 02:59:45 +0200
Date: Thu, 8 Jul 2004 02:59:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mika Kukkonen <mika@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: Re: MIPS defines __kernel_uid_t as int?
Message-ID: <20040708005945.GA17133@linux-mips.org>
References: <1089223996.20452.31.camel@miku.mobile.lnx.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089223996.20452.31.camel@miku.mobile.lnx.nokia.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 07, 2004 at 11:13:16AM -0700, Mika Kukkonen wrote:

> I was doing
> 	$ grep __kernel_uid_t include/*/posix_types.h
> 
> and noticed that MIPS is the only architecture that
> defines that to be signed (int) and not unsigned?
> 
> Same with __kernel_uid32_t. Is this intentional
> deviation or just an oversight?

Intentional but with a really weak reason.  Linux/MIPS uses the same
type definitions as SysV rsp. the MIPS ABI in it's EFT (Extended
Fundamental Types).  Not a great idea in retroperspective but that's a
choice made 10 years ago.

I don't think we'd break anything by changing this.  Objections to
changing it?

  Ralf
