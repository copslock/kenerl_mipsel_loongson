Received:  by oss.sgi.com id <S305165AbQAOPrU>;
	Sat, 15 Jan 2000 07:47:20 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:32842 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305155AbQAOPrD>;
	Sat, 15 Jan 2000 07:47:03 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03103; Sat, 15 Jan 2000 07:48:36 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA41693
	for linux-list;
	Sat, 15 Jan 2000 07:36:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA56250;
	Sat, 15 Jan 2000 07:36:26 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from mail.rpi.edu (mail.rpi.edu [128.113.100.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA02516; Sat, 15 Jan 2000 07:36:23 -0800 (PST)
	mail_from (clemej@rpi.edu)
Received: from cortez.sss.rpi.edu (clemej@cortez.sss.rpi.edu [128.113.113.33])
	by mail.rpi.edu (8.9.3/8.9.3) with SMTP id KAA38130;
	Sat, 15 Jan 2000 10:36:08 -0500
Date:   Sat, 15 Jan 2000 10:36:07 -0500 (EST)
From:   John Michael Clemens <clemej@rpi.edu>
X-Sender: clemej@cortez.sss.rpi.edu
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        "Soren S. Jorvang" <soren@wheel.dk>, linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs / PROM Console..
In-Reply-To: <20000115124726.B11241@uni-koblenz.de>
Message-ID: <Pine.A41.3.96.1000115103023.114964D-100000@cortez.sss.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


FWIW,

I tried the PROM console last nigth and it was a no-go.  kernel downloaded
from the bootp server and just sat there, nothing on console, nothing on
serial.  When I hit CTRL-C to get a prompt back, however, I discovered
that my font had changed to black-on-black, so SOMETHING happened.

This is on an Indigo2-R4400, which boots just fine over the serial
console, and CONFIG_SGI_PROM_CONSOLE asserted (after a little modification
to the config.in to take it OUT of the DEC only section, ala what Mr.
Weaver mentioned earlier, and the extraneous "NULL" removed from
setup_console in arch/mips/sgi/setup.c) 

john.c

- --
/* John Clemens     http://www.rpi.edu/~clemej _/ "I Hate Quotes"       */
/* ICQ: 7175925     clemej@rpi.edu           _/    -- Samuel L. Clemens */ 
/* RPI Comp. Eng. 2000, Linux Parallel/Network/OS/Driver Specialist     */
