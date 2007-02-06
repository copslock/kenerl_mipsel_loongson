Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 15:28:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:24537 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038419AbXBFP2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 15:28:19 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l16FSJa8031973;
	Tue, 6 Feb 2007 15:28:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l16FSHAq031972;
	Tue, 6 Feb 2007 15:28:17 GMT
Date:	Tue, 6 Feb 2007 15:28:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix run_uncached warning about 32bit kernel
Message-ID: <20070206152817.GB5660@linux-mips.org>
References: <200702060159.l161xM59075711@mbox33.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702060159.l161xM59075711@mbox33.po.2iij.net>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 06, 2007 at 10:59:22AM +0900, Yoichi Yuasa wrote:

> arch/mips/lib/uncached.c: In function 'run_uncached':
> arch/mips/lib/uncached.c:47: warning: comparison is always true due to limited range of data type
> arch/mips/lib/uncached.c:48: warning: comparison is always false due to limited range of data type
> arch/mips/lib/uncached.c:57: warning: comparison is always true due to limited range of data type
> arch/mips/lib/uncached.c:58: warning: comparison is always false due to limited range of data type

Thanks, applied.

  Ralf
