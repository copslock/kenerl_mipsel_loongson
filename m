Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14AWqY24591
	for linux-mips-outgoing; Mon, 4 Feb 2002 02:32:52 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14AWjA24547
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 02:32:45 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g149Waa27266;
	Mon, 4 Feb 2002 09:32:37 GMT
From: Dominic Sweetman <dom@algor.co.uk>
Message-ID: <15454.21812.39310.478616@gladsmuir.algor.co.uk>
Date: Mon, 4 Feb 2002 09:32:36 +0000
MIME-Version: 1.0
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: hjl@lucon.org, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <20020202.113717.68552217.machida@sm.sony.co.jp>
References: <20020201102943.A11146@lucon.org>
	<20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>
	<20020202.113717.68552217.machida@sm.sony.co.jp>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hiroyuki Machida (machida@sm.sony.co.jp) writes:

> I think we can assume CPU has branch-likely insns, if CPU has MIPS
> ISA 2 or greater ISA..

"MIPS II" is officially the instruction set introduced for the long
lost R6000 CPU.

But "MIPS II" is now used to mean "the 32-bit subset of MIPS III"
(which is extremely close to the same thing, but I'm never quite sure
about the last details of the R6000 - Kevin would remember better,
probably).

OK: branch-likely is definitely part of MIPS II and MIPS32.  There are
still MIPS CPUs in regular use which are based on MIPS I and don't
provide them.  Generally the advantages of MIPS II are slight, so if
you want to build a kernel which will not require instruction-set
variants, it's no big deal to restrict it to MIPS I.

> (FYI: we can't assume CPU has LL/SC even if CPU has branch-likely
> insns. )

LL/SC is also part of MIPS III (and the 32-bit variants are thus taken
to be in MIPS II).  Unfortunately, the documentation of LL/SC gave the
impression that they were useful only in multiprocessor systems, so
they were omitted by NEC building the Vr41xx and Toshiba's R59xx.
In both cases it's a bug - but since it isn't about to be fixed, you
need workarounds.

In these more enlightened days, CPU vendors are more likely to ask an
operating system person before they leave out bits of the instruction
set, so we hope it won't happen again!

Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
