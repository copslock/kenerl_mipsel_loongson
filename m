Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 06:45:03 +0000 (GMT)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:9357
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S20040045AbXAXGo6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 06:44:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id F1330AE4161;
	Tue, 23 Jan 2007 22:44:56 -0800 (PST)
Date:	Tue, 23 Jan 2007 22:44:56 -0800 (PST)
Message-Id: <20070123.224456.102772415.davem@davemloft.net>
To:	anemo@mba.ocn.ne.jp
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Fix wrong checksum calculation on 64-bit MIPS
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20070124.154334.130239327.nemoto@toshiba-tops.co.jp>
References: <20070124.154334.130239327.nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Wed, 24 Jan 2007 15:43:34 +0900 (JST)

> The commit 8e3d8433d8c22ca6c42cba4a67d300c39aae7822 ([NET]: MIPS
> checksum annotations and cleanups) broke 64-bit MIPS.
> 
> The problem is the commit replaces some unsigned long with __be32.  On
> 64bit MIPS, a __be32 (i.e. unsigned int) value is represented as a
> sign-extented 32-bit value in a 64-bit argument register.  So the
> address 192.168.0.1 (0xc0a80001) is passed as 0xffffffffc0a80001 to
> csum_tcpudp_nofold() but the asm code in the function expects
> 0x00000000c0a80001, therefore it returns a wrong checksum.  Explicit
> cast to unsigned long is needed to drop high 32bit.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Al, let me know if you want this fixed differently.
Thanks.
