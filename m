Received:  by oss.sgi.com id <S305157AbQAPBUu>;
	Sat, 15 Jan 2000 17:20:50 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:59766 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305155AbQAPBUX>; Sat, 15 Jan 2000 17:20:23 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA08176; Sat, 15 Jan 2000 17:24:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA67232
	for linux-list;
	Sat, 15 Jan 2000 17:07:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA96646;
	Sat, 15 Jan 2000 17:07:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04333; Sat, 15 Jan 2000 17:07:14 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-20.uni-koblenz.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA08850;
	Sun, 16 Jan 2000 02:07:09 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAPA50>;
	Sun, 16 Jan 2000 01:57:26 +0100
Date:   Sun, 16 Jan 2000 01:57:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     John Michael Clemens <clemej@rpi.edu>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        "Soren S. Jorvang" <soren@wheel.dk>, linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs / PROM Console..
Message-ID: <20000116015726.B12714@uni-koblenz.de>
References: <20000115124726.B11241@uni-koblenz.de> <Pine.A41.3.96.1000115103023.114964D-100000@cortez.sss.rpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.A41.3.96.1000115103023.114964D-100000@cortez.sss.rpi.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Jan 15, 2000 at 10:36:07AM -0500, John Michael Clemens wrote:

> I tried the PROM console last nigth and it was a no-go.  kernel downloaded
> from the bootp server and just sat there, nothing on console, nothing on
> serial.  When I hit CTRL-C to get a prompt back, however, I discovered
> that my font had changed to black-on-black, so SOMETHING happened.
> 
> This is on an Indigo2-R4400, which boots just fine over the serial
> console, and CONFIG_SGI_PROM_CONSOLE asserted (after a little modification
> to the config.in to take it OUT of the DEC only section, ala what Mr.
> Weaver mentioned earlier, and the extraneous "NULL" removed from
> setup_console in arch/mips/sgi/setup.c) 

Ok, something for the to-do list.  Unfortunately at the bottom of the
list ...

  Ralf
