Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 12:53:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57477 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133650AbWESKwy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 12:52:54 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4JAqs7Y004940;
	Fri, 19 May 2006 11:52:54 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4JAqq8u004939;
	Fri, 19 May 2006 11:52:52 +0100
Date:	Fri, 19 May 2006 11:52:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	dmitry pervushin <dpervushin@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] NEC EMMA2RH support
Message-ID: <20060519105252.GA4714@linux-mips.org>
References: <1147946423.8223.4.camel@diimka-laptop> <20060518195404.663eba86.yoichi_yuasa@tripeaks.co.jp> <1147950509.8223.10.camel@diimka-laptop> <20060518111703.GA15601@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518111703.GA15601@networkno.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 18, 2006 at 12:17:04PM +0100, Thiemo Seufer wrote:

> > May be, I have
> > misunderstood the modern ways in linux kernel development, but I am
> > pretty sure that assembler interrupt handler will be faster than C
> > code.
> 
> Only marginally, it doesn't outweigh the maintenance trouble.

Actually the average interrupt handler was sufficiently badly scheduled
such that the C written ones were usually better.  Not only, gcc knows
alot of CPU specifics about scheduling, so the average interrupt should
now suffer from many less taken branches.

  Ralf
