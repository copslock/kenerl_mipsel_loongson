Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 14:50:39 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:7093 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22507670AbYJ0Ou1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2008 14:50:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9REoPMw019886;
	Mon, 27 Oct 2008 14:50:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9REoO2n019885;
	Mon, 27 Oct 2008 14:50:24 GMT
Date:	Mon, 27 Oct 2008 14:50:23 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 00/10] Restructure EMMA2RH port
Message-ID: <20081027145023.GA19315@linux-mips.org>
References: <4900A510.3000101@ruby.dti.ne.jp> <20081027104749.GA9554@linux-mips.org> <4905A07A.4040802@necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4905A07A.4040802@necel.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 08:05:30PM +0900, Shinya Kuribayashi wrote:

> Ralf Baechle wrote:
> > And I hope more of the code for the reference platforms to be submitted
> > in the future!
> 
> Yeah, worth talking with my colleagues.

There are plenty of good arguments:

 o Users have direct access to uptodate code through the canical sources
   such as kernel.org and all the distributions based on that code.  That
   is they can chose what they want and are not tied to a product of NEC's
   blessing.
 o NEC's cost of development and maintenance will go down.
 o A a contributors both NEC as a company and the individuals contributing
   code will gain a positive image.

> >> follow, please review.  Any comments are highly appreciated.
> > 
> > Full series applied.
> 
> I forgot to modify the <asm/emma2rh.h> references from arch/mips/pci/
> {ops,pci,fixup}-emma2rh.c sources.  I'll send delta patch soon, please
> fold it to previous one.
> 
> Anyway, thanks a lot!

You're welcome!

  Ralf
