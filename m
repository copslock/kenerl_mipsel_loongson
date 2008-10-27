Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 10:48:03 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:58604 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22490483AbYJ0Krw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 10:47:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9RAlpXA012336;
	Mon, 27 Oct 2008 10:47:51 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9RAloZh012334;
	Mon, 27 Oct 2008 10:47:50 GMT
Date:	Mon, 27 Oct 2008 10:47:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Cc:	linux-mips@linux-mips.org, shinya.kuribayashi@necel.com
Subject: Re: [PATCH 00/10] Restructure EMMA2RH port
Message-ID: <20081027104749.GA9554@linux-mips.org>
References: <4900A510.3000101@ruby.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4900A510.3000101@ruby.dti.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 24, 2008 at 01:23:44AM +0900, Shinya Kuribayashi wrote:

Shinya-San,

> there have been many NEC EMMA SoCs so far, and with great pleasure we
> have many Linux ports running on EMMA these days.  Even though most
> those ports are not submitted to upstream, but I'd like to reorganize
> current EMMA2RH ports into more easy maintainable shape as a reference.

And I hope more of the code for the reference platforms to be submitted
in the future!

> There are a lot of things to do.  For the first step, I'd like to
> introduce arch/mips/emma/ and include/asm/emma/ directories so that all
> EMMA related sourches/headers can be easily shared across various EMMA
> products/ports.
>
> Here's the first attempt to try to change things as mentioned above.
> Some possible improvements and cleanups are also included.  Patches will
> follow, please review.  Any comments are highly appreciated.

Full series applied.

> P.S. I'm also planning to do more cleanups around IRQ codes, register
>     definition style, and so on.  But that'll be some other time.

Whenever you're ready!

Thanks,

  Ralf
