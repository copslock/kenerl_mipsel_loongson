Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 17:34:01 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7097 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038830AbWJMQd7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 17:33:59 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9DGYBdZ026874;
	Fri, 13 Oct 2006 17:34:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9DGYAlf026873;
	Fri, 13 Oct 2006 17:34:10 +0100
Date:	Fri, 13 Oct 2006 17:34:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] rewrite GALILEO_INL/GALILEO_OUTL  to GT_READ/GT_WRITE
Message-ID: <20061013163410.GB19260@linux-mips.org>
References: <20061014002504.07fd395a.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014002504.07fd395a.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 14, 2006 at 12:25:04AM +0900, Yoichi Yuasa wrote:

> This patch has rewritten GALILEO_INL/GALILEO_OUTL using GT_READ/GT_WRITE.
> This patch tested on Cobalt Qube2.

This is fairly large and thefore not in the "obviously correct" cathegory,
so I put it into the queue tree.

  Ralf
