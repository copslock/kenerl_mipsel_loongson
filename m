Received:  by oss.sgi.com id <S553757AbQJZHM5>;
	Thu, 26 Oct 2000 00:12:57 -0700
Received: from mx.mips.com ([206.31.31.226]:25519 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553675AbQJZHMs>;
	Thu, 26 Oct 2000 00:12:48 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA27206;
	Thu, 26 Oct 2000 00:12:26 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA22628;
	Thu, 26 Oct 2000 00:12:39 -0700 (PDT)
Message-ID: <004401c03f1c$96a67760$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Nicu Popovici" <octavp@isratech.ro>, <linux-mips@oss.sgi.com>
References: <39F828B2.A662A568@isratech.ro>
Subject: Re: Atlas Board!
Date:   Thu, 26 Oct 2000 09:15:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> I want to ask few questions about an Atlas board. Who has such a board
> maybe will give me some tips to have an working Linux on that machine.

I'm one of the guys who did the 2.2 port, so I hope I can help.

> 1. What type of RAM do I need ?

A PC100 SDRAM SIM - at least, that's what mine has.

> 2. I want to cross - compile the CVS linux kernel for Mips but I failed
> on a i686. Could anyone tell me if I try to compile the kernel on Atlas
> board I will  succeed.

I do all my builds native, either on an Indy or an Algorithmics
board (I've done it on the Atlas to prove it worked, but the other
two are faster).  What you might consider doing would be to
download a 2.2 kernel binary and the NFS installation kit
from the MIPS FTP site, bootstrap install the OS, then 
install the sources and native tools.  

See ftp://ftp.mips.com/pub/linux/mips/.  I've got a web
site at http://www.paralogos.com/mipslinux/ with pointers
to the relevant FTP directories at MIPS, and an HTML
version of the setup and installation procedure.

One word of warning.  The Atlas design uses a Philips
"super I/O" chip that has some bugs.  Specifically, the
ethernet interface is wonky under load.  It works well
enough for the boot PROM monitor (YAMON) to be
able to boot the Linux kernel from your TFTP server
completely reliably, but under serious FTP or NFS
traffic, it tends to lose interrupts/packets.  I *strongly*
recommend putting an AMD PCnet PCI card in the
Atlas' PCI slot.   The driver should already be built
into the kernel binaries on the MIPS FTP site.

            Regards,

            Kevin K.
