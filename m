Received:  by oss.sgi.com id <S42237AbQJJDVw>;
	Mon, 9 Oct 2000 20:21:52 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:12399 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42236AbQJJDVd>; Mon, 9 Oct 2000 20:21:33 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id UAA09281
	for <linux-mips@oss.sgi.com>; Mon, 9 Oct 2000 20:27:42 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA04624 for <linux-mips@oss.sgi.com>; Tue, 10 Oct 2000 14:19:17 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Linux on MIPS <linux-mips@oss.sgi.com>
Subject: Re: sgiserial.c 
In-reply-to: Your message of "Tue, 10 Oct 2000 05:13:48 +0200."
             <20001010051348.A36498@wo1133.wohnheim.uni-wuerzburg.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 10 Oct 2000 14:19:17 +1100
Message-ID: <3417.971147957@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, 10 Oct 2000 05:13:48 +0200, 
Marcus Herbert <rhoenie@spam-filter.de> wrote:
>SUPPORTED SPEEDS
>     The serial ports of all SGI systems support several standard rates
>     up through 38400 bps (see termio(7) for these standard rates).
>     The serial ports on O2, OCTANE, Origin2000, Onyx2 and Origin200
>     systems also support
>     
>                                31250   57600
>                                76800   115200

FWIW, O2's may be rated at 115200 but I can kill my O2 by feeding it
the output from a Linux serial console at 115200.  No diagnostics, just
a solid machine hang.
