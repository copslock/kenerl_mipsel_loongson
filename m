Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 18:35:44 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42465 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492764AbZJKQfl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 18:35:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9BGarDB002970;
	Sun, 11 Oct 2009 18:36:53 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9BGaqPc002967;
	Sun, 11 Oct 2009 18:36:52 +0200
Date:	Sun, 11 Oct 2009 18:36:52 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>,
	Chen Jie <chenj@lemote.com>, Hu Hongbing <huhb@lemote.com>
Subject: Re: [PATCH] MIPS: Fix the syscall lookup_dcookie in scall64-o32.S
Message-ID: <20091011163652.GB2842@linux-mips.org>
References: <1255173589-20394-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255173589-20394-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 10, 2009 at 07:19:49PM +0800, Wu Zhangjin wrote:

> When the kernel is 64bit, the application in O32 ABI will pass 4
> arguments to syscall lookup_dcookie, but the implementation can only
> handle 3 arguments. This patch will fixes it.

Thanks folks, applied - but please use tabs not whitespace for indentation
in the future ...

  Ralf
