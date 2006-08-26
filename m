Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2006 04:56:21 +0100 (BST)
Received: from web31505.mail.mud.yahoo.com ([68.142.198.134]:111 "HELO
	web31505.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039473AbWHZD4T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Aug 2006 04:56:19 +0100
Received: (qmail 18367 invoked by uid 60001); 26 Aug 2006 03:56:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fp/XPYjIT+3hDbVfa9gsXGv7wRruQdF16kXKbK54Rs5g6y6Xzq8lEYrDs05+UPL6T62ifnuOZoQM1QoiWayBXHVISj064HNjabyQGkYyE+VqWZD7vG+Hg+0t3cCrI4wQ/f9VS20tEoTVLKay+QNWWKmVHI2FSmGr9iDjHP//akc=  ;
Message-ID: <20060826035613.18365.qmail@web31505.mail.mud.yahoo.com>
Received: from [65.102.5.19] by web31505.mail.mud.yahoo.com via HTTP; Fri, 25 Aug 2006 20:56:13 PDT
Date:	Fri, 25 Aug 2006 20:56:13 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH] RM9000 serial driver
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-serial@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <200608260038.13662.thomas.koeller@baslerweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

As it's not a driver I think I use, my opinions on the
matter should not carry any significant weight. On the
other hand, if there are no other opinions on the
matter, then no non-zero weight is insignificant.
(I'll leave it as an exercise to resolve the triple
negative.)

Anyway, it is my opinion that code believed to be
dubious should be fixed and that it is an error to add
more code that carries the same potential flaw until
either the flaw is resolved or proven insignificant.
That includes flaws in style or code cleanliness.

If the flaw is easily fixed, then it would seem vastly
better to fix it once now rather than twice (or more)
later - particularly if there is any risk that copied
flaws could be forgotten. Forgotten temporary code is
an excellent breeding-ground for bugs.

There's also a potential for friction as there is a
very understandable unease when it comes to knowingly
adding brokenness to the mainstream kernel if it's not
necessary, again even if that isn't brokenness in
terms of logic but merely in some aspect of how it's
represented.

On the flip-side, if we waited for code to be perfect,
we'd still be waiting for Alan Turing to finish the
world's first stored program.

--- Thomas Koeller <thomas.koeller@baslerweb.com>
wrote:

> On Tuesday 22 August 2006 02:59, Yoichi Yuasa wrote:
> Hi Yoichi,
> 
> so far nobody commented on my recent mail, in which
> I explained why I
> think that the AU1X00 code in 8250.c is not entirely
> correct, so I assume
> nobody cares. I therefore modified my code to take
> the same approach,
> although I still have my doubts about it. Here's the
> updated patch:


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
