Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jul 2004 01:49:58 +0100 (BST)
Received: from p508B762C.dip.t-dialin.net ([IPv6:::ffff:80.139.118.44]:46972
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226166AbUGHAty>; Thu, 8 Jul 2004 01:49:54 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i680nq4w017081;
	Thu, 8 Jul 2004 02:49:52 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i680np0X017080;
	Thu, 8 Jul 2004 02:49:51 +0200
Date: Thu, 8 Jul 2004 02:49:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS getdomainname() off by 1;
Message-ID: <20040708004951.GA17045@linux-mips.org>
References: <20040531202101.4ace5e95.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531202101.4ace5e95.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 31, 2004 at 08:21:01PM -0700, Randy.Dunlap wrote:

> irix_getdomainname() max size appears to be off by 1;
> other similar code in kernel uses __NEW_UTS_LEN as the max size,
> and <domainname> includes an extra byte for the terminating
> null character.
> 
> Does sysirix.c need to limit <len> to 63 instead of 64 for some
> reason?

I would know why - and it has other bugs also, so I removed it by the
normal Linux getdomainname(2) for SysV flavour syscalls, too.

  Ralf
