Received:  by oss.sgi.com id <S554016AbQLDQ02>;
	Mon, 4 Dec 2000 08:26:28 -0800
Received: from jester.ti.com ([192.94.94.1]:65211 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S553866AbQLDQ0T>;
	Mon, 4 Dec 2000 08:26:19 -0800
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by jester.ti.com (8.11.1/8.11.1) with ESMTP id eB4GQD508983;
	Mon, 4 Dec 2000 10:26:13 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA28421;
	Mon, 4 Dec 2000 10:26:12 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA28405;
	Mon, 4 Dec 2000 10:26:12 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA06285;
	Mon, 4 Dec 2000 10:26:11 -0600 (CST)
Message-ID: <3A2BC5DB.AA1E1E77@ti.com>
Date:   Mon, 04 Dec 2000 09:27:07 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Mike Mattice <mike@milliways.cx>
CC:     linux-mips@oss.sgi.com
Subject: Re: egcs 1.1.2 build with 1.0.2
References: <20001204094231.A6622@milliways.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Mike Mattice wrote:

> I'm trying to build this on a cobalt.
> Quick and dirty summary:
>
> /tmp/ccl2C8g8.s: Assembler messages:
> /tmp/ccl2C8g8.s:182: Internal error!
> Assertion failure in mips_emit_delays at ./config/tc-mips.c line 2231.
> Please report this bug.
>
> gcc -v reports:
> Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux/egcs-2.90.27/specs
> gcc version egcs-2.90.27 980315 (egcs-1.0.2 release)

I ran into this same problem about a month ago (Although I was building 1.0.3
from 1.0.2 on different hardware). I spent about 2 weeks working on it and
found no resolution. There were a couple of suggestions posted to mips-linux
which you might try (search for mips_emit_delays). If you find a solution
I would be very interested.
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
