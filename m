Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 19:49:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4505 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039282AbWI2StP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 19:49:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8TInJB8010873
	for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 19:50:00 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8TIUdfm007109;
	Fri, 29 Sep 2006 19:30:39 +0100
Date:	Fri, 29 Sep 2006 19:30:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] update i8259 resources
Message-ID: <20060929183039.GB3936@linux-mips.org>
References: <200609290917.k8T9HpZm073011@mbox31.po.2iij.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609290917.k8T9HpZm073011@mbox31.po.2iij.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 29, 2006 at 06:17:51PM +0900, Yoichi Yuasa wrote:

> This patch has updated i8259 resources as same as i386.

Well, MIPS machines tend to use i386 procecessors rather rarely ;-)  But
it indeed seems like all system controllers / ISA bridge I was able to
check in datasheets will not potencially do evil when allocating only
2 bytes.

  Ralf
