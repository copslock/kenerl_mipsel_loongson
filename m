Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Dec 2006 14:13:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3732 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038848AbWLDONV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 4 Dec 2006 14:13:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB4EDMGM015266;
	Mon, 4 Dec 2006 14:13:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB4EDLnq015265;
	Mon, 4 Dec 2006 14:13:21 GMT
Date:	Mon, 4 Dec 2006 14:13:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 3/5] MIPS: separate cobalt PCI codes from setup.c
Message-ID: <20061204141321.GC7231@linux-mips.org>
References: <20061201221242.261f57b0.yoichi_yuasa@tripeaks.co.jp> <20061201221601.3aa34024.yoichi_yuasa@tripeaks.co.jp> <20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201221746.1f45d98c.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 01, 2006 at 10:17:46PM +0900, Yoichi Yuasa wrote:

> This patch has separated cobalt PCI codes from setup.c .
> It's removed #ifdef CONFIG_PCI/#endif from cobalt setup.c .

Looks good.

  Ralf
