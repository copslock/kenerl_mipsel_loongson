Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 14:25:16 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:61610 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22735211AbYJ3OZH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 14:25:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UEP6sh028725;
	Thu, 30 Oct 2008 14:25:07 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UEP5AA028724;
	Thu, 30 Oct 2008 14:25:05 GMT
Date:	Thu, 30 Oct 2008 14:25:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix dsemul build error
Message-ID: <20081030142504.GA25273@linux-mips.org>
References: <4909bf05.1c048e0a.2c9d.fffffe74@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4909bf05.1c048e0a.2c9d.fffffe74@mx.google.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 30, 2008 at 11:04:48PM +0900, Yoichi Yuasa wrote:

> arch/mips/math-emu/dsemul.c: In function 'mips_dsemul':
> arch/mips/math-emu/dsemul.c:96: error: 'BRK_MEMU' undeclared (first use in this function)
> arch/mips/math-emu/dsemul.c:96: error: (Each undeclared identifier is reported only once
> arch/mips/math-emu/dsemul.c:96: error: for each function it appears in.)
> arch/mips/math-emu/dsemul.c: In function 'do_dsemulret':
> arch/mips/math-emu/dsemul.c:138: error: 'BRK_MEMU' undeclared (first use in this function)
> make[1]: *** [arch/mips/math-emu/dsemul.o] Error 1

Interesting.  Ah, the kernel builds with CONFIG_BUG=y.  So enabling the
bugs makes the kernel work, that's another bug ;-)

Patch applied, thanks!

  Ralf
