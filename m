Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MAdIN30114
	for linux-mips-outgoing; Tue, 22 Jan 2002 02:39:18 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MAdAP30110;
	Tue, 22 Jan 2002 02:39:11 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0M9bft07359;
	Tue, 22 Jan 2002 09:37:42 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.2/8.11.2) id g0M9bfn01173;
	Tue, 22 Jan 2002 09:37:41 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15437.13028.496595.150427@gladsmuir.algor.co.uk>
Date: Tue, 22 Jan 2002 09:37:40 +0000
To: drepper@redhat.com (Ulrich Drepper)
Cc: "Kevin D. Kissell" <kevink@mips.com>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Mike Uhler" <uhler@mips.com>, <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
In-Reply-To: <m3zo37s0ja.fsf@myware.mynet>
References: <m3elkoa5dw.fsf@myware.mynet>
	<20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020119162415.B31028@dea.linux-mips.net>
	<m3d703thl6.fsf@myware.mynet>
	<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
	<m3zo37s0ja.fsf@myware.mynet>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Kevin asked:

> > I'd very much appreciate it if someone would explain to me just
> > what this register is used for, and why a register needs to be
> > permantly allocated for this purpose.

Ulrich Drepper (drepper@redhat.com) writes:

> Simply look at the ABIs for some less-backward processors.  Read the
> thread-local storage section in the IA-64 ABI specification.

Sometimes when you're busy it's understandable to respond with "RTFM".
But to fail to provide a URL is not very respectful: other people
reading this list are quite smart, they're just smart about different
things from you.

URL please.

Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
