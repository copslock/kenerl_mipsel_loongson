Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3RK6HwJ026650
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 27 Apr 2002 13:06:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3RK6H1I026649
	for linux-mips-outgoing; Sat, 27 Apr 2002 13:06:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mta6.snfc21.pbi.net (mta6.snfc21.pbi.net [206.13.28.240])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3RK6FwJ026644
	for <linux-mips@oss.sgi.com>; Sat, 27 Apr 2002 13:06:15 -0700
Received: from localhost ([63.194.214.47])
 by mta6.snfc21.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GV800I24T7JZH@mta6.snfc21.pbi.net> for linux-mips@oss.sgi.com;
 Sat, 27 Apr 2002 13:06:55 -0700 (PDT)
Date: Sat, 27 Apr 2002 13:05:53 -0700
From: Pete Popov <ppopov@mvista.com>
Subject: Re: reiserfs
In-reply-to: <E171Yfh-0000gA-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1019937954.1260.22.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.0.3
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <E171Yfh-0000gA-00@the-village.bc.nu>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 2002-04-27 at 13:19, Alan Cox wrote:
> > Has anyone been able to run reiserfs on big endian systems?
> 
> Should work on newer 2.4 kernels

Yes, it does. I sent an email yesterday explaining what the problem
was.  The 2.95.3 toolchain is miscompiling the cpu_to_le16 and
le16_to_cpu functions. The problem appears to be fixed in 2.96 and 3.x
so reiserfs is looking good for both, LE and BE mips systems.

Pete
