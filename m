Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 14:14:51 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14279 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133515AbWDFNOe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 14:14:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k366s8oi028333
	for <linux-mips@linux-mips.org>; Thu, 6 Apr 2006 07:54:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k366r3FF028324;
	Thu, 6 Apr 2006 07:53:03 +0100
Date:	Thu, 6 Apr 2006 07:53:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] vr41xx: fix plat_irq_dispatch()
Message-ID: <20060406065303.GA28314@linux-mips.org>
References: <20060406120737.689accd3.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406120737.689accd3.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 06, 2006 at 12:07:37PM +0900, Yoichi Yuasa wrote:

> This patch has fixed the wrong conversion of plat_irq_dispatch() for vr41xx.
> Please apply.

Thanks, applied.  Let's hope this is all that broke in the rewrite ...

  Ralf
