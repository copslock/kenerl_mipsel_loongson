Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 20:59:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41442 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493537AbZJHS7z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 20:59:55 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n98J15oG011886;
	Thu, 8 Oct 2009 21:01:06 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n98J14it011880;
	Thu, 8 Oct 2009 21:01:04 +0200
Date:	Thu, 8 Oct 2009 21:01:04 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [loongson] Remove redundant local_irq_disable()
Message-ID: <20091008190102.GB10365@linux-mips.org>
References: <1255005590-16562-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255005590-16562-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 08, 2009 at 08:39:50PM +0800, Wu Zhangjin wrote:

> That code is executed with irq disabled already, so, Remove the redundant
> local_irq_disable() here.

Applied, thanks!

  Ralf
