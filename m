Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14Al6M07468
	for linux-mips-outgoing; Mon, 4 Feb 2002 02:47:06 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14AkvA07339
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 02:46:58 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g149kma27958;
	Mon, 4 Feb 2002 09:46:50 GMT
From: Dominic Sweetman <dom@algor.co.uk>
Message-ID: <15454.22661.855423.532827@gladsmuir.algor.co.uk>
Date: Mon, 4 Feb 2002 09:46:45 +0000
MIME-Version: 1.0
To: cgd@broadcom.com
Cc: linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <yov5ofj65elj.fsf@broadcom.com>
References: <20020131231714.E32690@lucon.org>
	<Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
	<20020201102943.A11146@lucon.org>
	<20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>
	<20020201222657.A13339@nevyn.them.org>
	<1012676003.1563.6.camel@xyzzy.stargate.net>
	<20020202120354.A1522@lucon.org>
	<mailpost.1012680250.7159@news-sj1-1>
	<yov5ofj65elj.fsf@broadcom.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


cgd@broadcom.com (cgd@broadcom.com) writes:

> Branch-likely instructions probably _do_ buy you something (at
> least, slightly less code size) on some CPUs, probably even some
> CPUs which are still being produced.

Here's how branch likely is used to improve performance in a simple
MIPS CPU, and why it has no effect on code size.

You start off with this:

  loopstart: insn 1
             insn 2
             ....
	     insn last
	     branch to loopstart
             nop

In small loops, the last instruction in the loop might well calculate
the branch condition, so it can't be moved into the delay slot of the
loop-closing branch.  That puts a no-op into every loop iteration.
With branch-likely, you can transform the loop to 
            
  loopstart: insn 1
  loop2:     insn 2
             ....
	     insn last
	     branch-likely loop2
	     insn 1 (copy)

The nop is replaced by a duplicate instruction from the top
of the loop.  Good for performance, no effect on code size.

Builders of clever modern CPUs full of branch prediction hardware,
multiple instruction issue and instruction re-ordering find the
coupling of the branch-likely to the following instruction makes their
CPUs more complicated.  That's why MIPS have warned that the
instructions will be removed from some future version of the MIPS
instruction set.

-- 
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
