Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 17:16:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:45529 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1494020AbZKCQP6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 17:15:58 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3GHLEZ015398;
	Tue, 3 Nov 2009 17:17:21 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3GHIge015396;
	Tue, 3 Nov 2009 17:17:18 +0100
Date:	Tue, 3 Nov 2009 17:17:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
Subject: Re: [PATCH -queue 2/7] [loongson] mem.c: Register reserved memory
	pages
Message-ID: <20091103161718.GB5999@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com> <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com> <20091102141459.GG21563@linux-mips.org> <1257211265.3528.17.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257211265.3528.17.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 03, 2009 at 09:21:05AM +0800, Wu Zhangjin wrote:

> > Hmm...  After our recent discussion on your hibernation issues I am
> > wondering if this patch is actually still required or useful?
> 
> It does not help the hibernation issue, but helps to clear the memory
> layout to the users(cat /proc/iomem), is this a need?
> 
> Seems some of the other architectures, including some MIPS variants have
> registed the reserved space, so, could you please apply it?

Thanks, also queued for 2.6.33.

  Ralf
