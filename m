Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 13:11:13 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53642 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133513AbWDDMLA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2006 13:11:00 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k34CM92E016101;
	Tue, 4 Apr 2006 13:22:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k34CM8xP016100;
	Tue, 4 Apr 2006 13:22:08 +0100
Date:	Tue, 4 Apr 2006 13:22:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: build error about current git
Message-ID: <20060404122208.GC13203@linux-mips.org>
References: <20060404102221.5280f199.yoichi_yuasa@tripeaks.co.jp> <20060404104336.GA3142@linux-mips.org> <20060404204847.6244de31.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404204847.6244de31.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 04, 2006 at 08:48:47PM +0900, Yoichi Yuasa wrote:

> ROCKHOPPER, TB0226 and TB0287 are only base board(CPU is not included in these boards).
> These configs don't need "select SYS_HAS_CPU_VR41XX" and "select SYS_SUPPORTS_32BIT_KERNEL".

All right, applied.

  Ralf
