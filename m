Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5FLElnC012189
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 15 Jun 2002 14:14:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5FLElJl012188
	for linux-mips-outgoing; Sat, 15 Jun 2002 14:14:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from smtp.inreach.com (smtp.inreach.com [209.142.2.34])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5FLEgnC012185
	for <linux-mips@oss.sgi.com>; Sat, 15 Jun 2002 14:14:42 -0700
Received: (qmail 24331 invoked by uid 512); 15 Jun 2002 21:17:23 -0000
Received: from dpchrist@holgerdanske.com by smtp.inreach.com by uid 509 with qmail-scanner-1.11 (perlscanner 1.11: clear; processed in 0.056607 secs); 15 Jun 2002 21:17:23 -0000
Received: from unknown (HELO w2k30g) (209.142.39.228)
  by smtp.inreach.com with SMTP; 15 Jun 2002 21:17:22 -0000
Message-ID: <006a01c214b2$22e59280$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Cc: "Domcan Sami" <domca_psg@email.com>
References: <20020615091631.20470.qmail@email.com>
Subject: Re: Kernel - arch support(mips)
Date: Sat, 15 Jun 2002 14:16:13 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

> 1)I'm using is a Galileo Board EV64120A.
> 2)It is a raw embedded target & does not support Linux. I'm trying to
> print a string by compiling code with RM7000 & directing the output
> via Serial Port to a WinNT HyperTerminal.

Searching on Google, it looks like you have a EV64120A-7000 made by
Galileo Technology, Inc..  It is a PCI card that plugs into a PC, and
includes the PMON ROM monitor in flash.  Galileo appears to have been
sold to Marvell (www.marvell.com).  I don't see support or search links
on the Marvell web site.  I don't see Galileo or EV64120A on their
product page.  I suggest you send them an e-mail asking if and what
support is available.


I was going to recommend the SDE-MIPS toolkit by Algorithmics, but I
don't see your board in their Programmer's Guide.  Try asking them if
they support it:

    http://www.algor-uk.com/


To be blunt, trying to make an older, slower, and unsupported board work
is going to be difficult.  It might not be possible.  If you can, get a
current, complete, and well-supported MIPS development system -- board,
ICE/JTAG, ROM monitor/ embedded OS, development toolchain, etc..


David Christensen
dpchrist@holgerdanske.com
