Received:  by oss.sgi.com id <S42322AbQFTNDz>;
	Tue, 20 Jun 2000 06:03:55 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:27216 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42229AbQFTNDt>; Tue, 20 Jun 2000 06:03:49 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id GAA08396
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 06:08:57 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA30069
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 20 Jun 2000 06:03:16 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [62.161.177.33] (mailhost.mipsys.com [62.161.177.33]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA00936
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Jun 2000 06:03:05 -0700 (PDT)
	mail_from (bh40@calva.net)
Received: from [192.168.1.19] by [192.168.1.2]
     with SMTP (QuickMail Pro Server for Mac 2.0); 20 JUN 00 15:04:28 UT
From:   Benjamin Herrenschmidt <bh40@calva.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>,
        Linux kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: Proposal: non-PC ISA bus support
Date:   Tue, 20 Jun 2000 15:02:38 +0200
Message-Id: <20000620130238.15357@mailhost.mipsys.com>
In-Reply-To: <Pine.GSO.4.10.10006201438290.8592-100000@dandelion.sonytel.be>
References: <Pine.GSO.4.10.10006201438290.8592-100000@dandelion.sonytel.be>
X-Mailer: CTM PowerMail 3.0.3 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jun 20, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>Concatenating the I/O spaces seems like the best solution to me as well.

Would work if the ranges you are passing via /proc/bus/isa/xxxx are
kernel virtual addresses and not physical addresses (I didn't check if
this is the case).

>Hmmm... If you can live with only one video card with legacy support, what
>about a kernel option to specify which of the 3 busses will be the first?

I've been thinking about it. That would be a solution. Also, the fbdev's
we use for cards in the AGP slot (ATI Rage 128 for now) can handle this
fine, and XFree has already been more or less hacked when to handle it
too when running on top of fbdev.

>Else, we'll have to work around this in XFree86.

Well, we'll have to find a workaround one way or another. The only
solution I can see for this problem is a way for each individual card
driver to "ask" the kernel for an iobase which is specific to this card,
given in parameter as much infos as the driver can regarding the device
(like the pci_dev for a pci device). The kernel would then be able to
locate the device in the OF tree, walk the tree up to the nearest brige
and figure out the correct IO range. (It already does something similar
for config space accesses since we have the same problem of 3 different
config space access registers). For in-kernel drivers, this can be done
at the PCI fixup level provided that the driver uses the io resources
given to it "as is", but exposing this to userland may require more than
a /proc entry.

Ben.
