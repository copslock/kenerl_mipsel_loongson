Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 16:14:27 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5073 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28591432AbYB1QOZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 16:14:25 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1SGEOIH010911;
	Thu, 28 Feb 2008 16:14:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1SGEOpS010910;
	Thu, 28 Feb 2008 16:14:24 GMT
Date:	Thu, 28 Feb 2008 16:14:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Adrian Bunk <adrian.bunk@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mips: use KBUILD_DEFCONFIG
Message-ID: <20080228161424.GA10876@linux-mips.org>
References: <20080226195454.GC4898@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080226195454.GC4898@cs181133002.pp.htv.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 26, 2008 at 09:54:54PM +0200, Adrian Bunk wrote:

> With KBUILD_DEFCONFIG we don't have to ship a second copy of 
> ip22_defconfig

Thanks, applied.

  Ralf
