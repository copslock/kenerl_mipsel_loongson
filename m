Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2006 15:15:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:1191 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133523AbWGMOPP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2006 15:15:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k6DEFHWF026818;
	Thu, 13 Jul 2006 15:15:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k6DEFGIa026817;
	Thu, 13 Jul 2006 15:15:16 +0100
Date:	Thu, 13 Jul 2006 15:15:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] vr41xx: added #indef __KERNEL__/#endif to vr41xx header files
Message-ID: <20060713141516.GB24611@linux-mips.org>
References: <20060713173356.72ab52f1.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713173356.72ab52f1.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 13, 2006 at 05:33:56PM +0900, Yoichi Yuasa wrote:

> This patch has added #ifdef __KERNEL__/#endif to vr41xx header files.

None of the include/asm-mips/vr41xx/ files touched by this patch is
listed in include/asm-mips/Kbuild for installation so I don't see why
protecting with #indef __KERNEL__ would make sense?

  Ralf
