Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QBu6k12691
	for linux-mips-outgoing; Tue, 26 Feb 2002 03:56:06 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QBtV912684;
	Tue, 26 Feb 2002 03:55:31 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g1QAtK413844;
	Tue, 26 Feb 2002 10:55:21 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15483.27029.29266.976139@gladsmuir.algor.co.uk>
Date: Tue, 26 Feb 2002 10:55:17 +0000
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Jay Carlson <nop@nop.com>, mad-dev@lists.mars.org,
   Carlo Agostini <carlo.agostini@yacme.com>, linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
In-Reply-To: <20020226060236.A5293@dea.linux-mips.net>
References: <20020225132559.A3500@dea.linux-mips.net>
	<F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com>
	<20020226060236.A5293@dea.linux-mips.net>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralf,

> It's really a major pain.  Softfp isn't defined in the ABI which assumes
> an FPU is available.  As the result there is no provision for mixing
> softfp and fp-less code.
> 
> Something for the binutils to-do list - ld should make mixing hard-fp
> and soft-fp binaries impossible.

Incremental changes to the ABI are pretty bad news.  Isn't it
avoidable in this case?

It seems to me that soft-float programs are either carefully
controlled test cases, or used as part of a 100% soft-float system.

In the first case the programmer had better take care, and in the
second the kernel should have been changed to kill any program with an
FP op-code.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
