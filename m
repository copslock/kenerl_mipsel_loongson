Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 13:30:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59589 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023776AbXHWM2R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 13:28:17 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7NCSE8i012232;
	Thu, 23 Aug 2007 13:28:16 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MMrnkO010635;
	Wed, 22 Aug 2007 23:53:49 +0100
Date:	Wed, 22 Aug 2007 23:53:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix ABI check in include/asm-mips/arv/hinv.h
Message-ID: <20070822225349.GB10561@linux-mips.org>
References: <20070816231542.60ab56ee.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070816231542.60ab56ee.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 16, 2007 at 11:15:42PM +0900, Yoichi Yuasa wrote:

> Fix ABI check in include/asm-mips/arv/hinv.h

Fortunately not a fix but only a cleanup because the gcc compiler driver
defines  _MIPS_SIM = _ABI64 for N64, so queued up for 2.6.24.

Thanks,

  Ralf
