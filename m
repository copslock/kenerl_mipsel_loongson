Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2007 14:55:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:44237 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023275AbXDPNzW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Apr 2007 14:55:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3GDlAh9030592;
	Mon, 16 Apr 2007 14:52:30 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3GDlAtI030591;
	Mon, 16 Apr 2007 14:47:10 +0100
Date:	Mon, 16 Apr 2007 14:47:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Aeschbacher, Fabrice" <Fabrice.Aeschbacher@siemens.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] building compressed kernel (au1000)
Message-ID: <20070416134710.GA28217@linux-mips.org>
References: <D7810733513F4840B4EBAAFA64D9C6A401268264@stgw002a.ww002.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7810733513F4840B4EBAAFA64D9C6A401268264@stgw002a.ww002.siemens.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 16, 2007 at 11:01:48AM +0200, Aeschbacher, Fabrice wrote:

Fabrice,

> Please find enclosed a patch (against 2.6.20.4) for building a
> compressed kernel image (zImage) for mips / au1000.

I see several #include <linux/config.h> but that file does no longer
exist in 2.6.20 which either means that code is dead code or has not
been compile tested ...

> This patch was only adapted from
> http://www.freewrt.org/trac/browser/trunk/freewrt/target/linux/au1000-2.
> 6/patches/003-zImage.patch?rev=1

Signed-off-by: ?

  Ralf
