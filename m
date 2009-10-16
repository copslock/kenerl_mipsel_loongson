Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 11:34:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46123 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493181AbZJPJeY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Oct 2009 11:34:24 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9G9Zitv005142;
	Fri, 16 Oct 2009 11:35:44 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9G9ZiAS005141;
	Fri, 16 Oct 2009 11:35:44 +0200
Date:	Fri, 16 Oct 2009 11:35:44 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Disable Function Tracer for Compressed kernel
	support part
Message-ID: <20091016093543.GB3686@linux-mips.org>
References: <1255667205-22998-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1255667205-22998-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 12:26:45PM +0800, Wu Zhangjin wrote:

> There is no need to trace the compressed support part, so, dislable it.
> and also, if we not disable it, there will be compiling error about no
> defined _mcount.

Thanks, folded into the other compression patch in -queue.

  Ralf
