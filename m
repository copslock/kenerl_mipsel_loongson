Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Sep 2006 15:48:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59848 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038542AbWIYOs4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Sep 2006 15:48:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8PEnjUb024161;
	Mon, 25 Sep 2006 15:49:45 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8PEniKJ024160;
	Mon, 25 Sep 2006 15:49:44 +0100
Date:	Mon, 25 Sep 2006 15:49:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/3] fixed typo in hazard.h
Message-ID: <20060925144944.GG20048@linux-mips.org>
References: <20060922010713.657f2861.yoichi_yuasa@tripeaks.co.jp> <20060922011048.676d8de0.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922011048.676d8de0.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 22, 2006 at 01:10:48AM +0900, Yoichi Yuasa wrote:

> This patch has fixed typo in hazard.h .

> -#ifdef __ASSEMBLER__
> +#ifdef __ASSEMBLY__

Not a typo at all - the gcc driver defines __ASSEMBLER__ for MIPS.  But
for clarity's sake I think this change is the right thing to do, so
I've just changed a few other files as well.

  Ralf
