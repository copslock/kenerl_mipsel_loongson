Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g23ENE919517
	for linux-mips-outgoing; Sun, 3 Mar 2002 06:23:14 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g23EN7919513
	for <linux-mips@oss.sgi.com>; Sun, 3 Mar 2002 06:23:07 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g23DN0403097;
	Sun, 3 Mar 2002 13:23:01 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15490.9137.106468.837502@gladsmuir.algor.co.uk>
Date: Sun, 3 Mar 2002 13:22:57 +0000
To: Carsten Langgaard <carstenl@mips.com>
Cc: Muthukumar Ratty <muthur@paul.rutgers.edu>, linux-mips@oss.sgi.com
Subject: Re: Cross toolchain problem??
In-Reply-To: <3C82059D.A8DF389E@mips.com>
References: <Pine.SOL.4.10.10203020958400.27103-100000@paul.rutgers.edu>
	<3C82059D.A8DF389E@mips.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Carsten Langgaard (carstenl@mips.com) writes:

> Hopefully not with the Algorithmics toolchain, otherwise we will like to
> know.

Speaking for Algorithmics: I suspect there may be problems building a
2.4+ kernel with SDE-MIPS v4.0c.  The people who made 2.4 were very
enthusiastic about the latest and greatest language extensions in GCC,
and SDE-MIPS v4.0c is based on quite an old compiler.

2.2 should be fine with SDE-MIPS v4.0c; 2.4+ is known to work with
SDE-MIPS v5.0, which is only in beta so far.  With some makefile
tweaks that should build kernels with no trouble.

Soon there should be a compiler distribution from Algorithmics which
is based on the v5.0 sources, but configured for Linux.  That should
be best.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
