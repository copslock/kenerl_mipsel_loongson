Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PIBCx23669
	for linux-mips-outgoing; Mon, 25 Mar 2002 10:11:12 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PIB6q23666
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 10:11:07 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g2PIDL200387;
	Mon, 25 Mar 2002 18:13:25 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15519.26814.797026.923001@gladsmuir.algor.co.uk>
Date: Mon, 25 Mar 2002 18:13:18 +0000
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Mips16 toolchain?
In-Reply-To: <20020325135834.GA1736@convergence.de>
References: <20020325135834.GA1736@convergence.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Johannes Stezenbach (js@convergence.de) writes:

> Since I'm developing for an embedded target, I wanted to
> check out mips16 code generation for the userspace apps.
> Unfortunately my gcc aborts with an internal error
> on even the simplest test program:

No surprise, really.

> I saw that the algorithmics toolchain (which Dominic Sweetman
> offered to the Linux/MIPS community here a month ago) claims
> to have full support for the mips16 instruction set.

It does.  If you want an 'embedded' toolchain (to generate software to
run standalone or in general without position-independent shared
libraries) then it's a mature product.

We are also developing a compiler from the same source tree, but
configured for Linux.  That was the compiler we'll be looking for
beta-testers for in the next couple of months.

If you want to be able to build MIPS16 applications and then run them
on Linux, this is more challenging.  You have to build everything
static: then it works mostly, and some people at MIPS have built and
run some programs.

It seems likely we'll be doing some development work over the
spring/summer to make this more robust and less painful.

> How about gcc-3.x from CVS?

We believe not.  We'd like to converge our compiler (currently 2.96+
based) back to gcc 3.x so we can get most of our MIPS changes into the
mainstream tree, but it's not going to be easy.

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
