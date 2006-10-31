Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2006 13:51:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:33709 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038602AbWJaNvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Oct 2006 13:51:06 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id k9VDpaw8009819;
	Tue, 31 Oct 2006 13:51:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id k9VDpatb009818;
	Tue, 31 Oct 2006 13:51:36 GMT
Date:	Tue, 31 Oct 2006 13:51:36 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix warning of printk format in mips_srs_init()
Message-ID: <20061031135136.GC7795@linux-mips.org>
References: <200610310445.k9V4jF44016171@mbox32.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610310445.k9V4jF44016171@mbox32.po.2iij.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 31, 2006 at 01:44:38PM +0900, Yoichi Yuasa wrote:

> This patch has fixed the warning of printk format in mips_srs_init().
> 
> arch/mips/kernel/traps.c:1115: warning: int format, long unsigned int arg (arg 2)

Applied as well,

  Ralf
