Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14HkMd07052
	for linux-mips-outgoing; Mon, 4 Feb 2002 09:46:22 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14HkJA06989
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 09:46:19 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g14GkAa11615;
	Mon, 4 Feb 2002 16:46:12 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15454.47823.837119.847975@gladsmuir.algor.co.uk>
Date: Mon, 4 Feb 2002 16:46:07 +0000
To: "H . J . Lu" <hjl@lucon.org>
Cc: Dominic Sweetman <dom@algor.co.uk>, cgd@broadcom.com,
   linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
In-Reply-To: <20020204083115.C13384@lucon.org>
References: <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
	<20020201102943.A11146@lucon.org>
	<20020201180126.A23740@nevyn.them.org>
	<20020201151513.A15913@lucon.org>
	<20020201222657.A13339@nevyn.them.org>
	<1012676003.1563.6.camel@xyzzy.stargate.net>
	<20020202120354.A1522@lucon.org>
	<mailpost.1012680250.7159@news-sj1-1>
	<yov5ofj65elj.fsf@broadcom.com>
	<15454.22661.855423.532827@gladsmuir.algor.co.uk>
	<20020204083115.C13384@lucon.org>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H . J . Lu (hjl@lucon.org) writes:

> I can change glibc not to use branch-likely without using nop. But it
> may require one or two instructions outside of the loop. Should I do
> it given what we know now?

I would not recommend using "branch likely" in assembler coding, if
that's what you're asking.

Dominic 
