Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0RIaBc30412
	for linux-mips-outgoing; Sun, 27 Jan 2002 10:36:11 -0800
Received: from mta7.pltn13.pbi.net (mta7.pltn13.pbi.net [64.164.98.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0RIa8P30399
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 10:36:08 -0800
Received: from [10.2.2.61] ([63.194.214.47])
 by mta7.pltn13.pbi.net (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GQL00H94Y864C@mta7.pltn13.pbi.net> for linux-mips@oss.sgi.com;
 Sun, 27 Jan 2002 09:36:06 -0800 (PST)
Date: Sun, 27 Jan 2002 09:33:02 -0800
From: Pete Popov <ppopov@mvista.com>
Subject: Re: Help with OOPSes, anyone?
In-reply-to: <20020127002242.A11373@momenco.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Message-id: <1012152783.2026.7.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20020127002242.A11373@momenco.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> But, under certain conditions, the kernel OOPSes.  Attached to this message
> are a few of those OOPSes (serial console is wonderful!) along with the
> ksymoops output.  I think the read_lsmod() warning is bogus, because there
> are, actually, no modules loaded.
> 
> My instincts are telling me that these are all being caused by the same
> problem, but I'll be damned if I can figure out what that is.  Caching is a
> good suspect, but that's just because it's always a good suspect.

Native compiles have indeed proven a great way to shake out hardware and
software bugs. 

One suggestion. The rm7k, at least some of the silicon versions, have
hardware erratas with the 'wait' instruction, used in the cpu_idle()
loop.  The CPU I have on one of the EV96100 boards, in combination with
the gt96100, will hang hard every time if I don't disable the use of
'wait'.  So while this bug might not have anything to do with what
you're observing, I would ifdef-out the 'wait' instruction in
check_wait(), just to be sure that that's not the cause or one of the
problems.

Pete
