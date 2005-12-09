Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2005 18:29:51 +0000 (GMT)
Received: from mailserver.c-lab.de ([131.234.80.230]:30339 "EHLO
	mailserver.c-lab.de") by ftp.linux-mips.org with ESMTP
	id S3458520AbVLIS3e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Dec 2005 18:29:34 +0000
Received: from tintin.c-lab.de (tintin.c-lab.de [131.234.80.96])
	by mailserver.c-lab.de (8.13.4/8.13.4/Debian-3) with SMTP id jB9ITOiQ017634;
	Fri, 9 Dec 2005 19:29:24 +0100
Message-ID: <4399CD04.2781@c-lab.de>
Date:	Fri, 09 Dec 2005 19:29:24 +0100
From:	Michael Joosten <joost@c-lab.de>
Organization: Badlab Construction Services, Inc
X-Mailer: Mozilla 3.04Gold [en] (X11; I; IRIX 6.5 IP32)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	michael.joosten@c-lab.de
Subject: SGI O2: working framebuffer/X11 modes? 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.51 on 131.234.80.230
Return-Path: <joost@c-lab.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joost@c-lab.de
Precedence: bulk
X-list: linux-mips

Hello,

this actually not really a SGI MIPS question, but a rather one about the
SGI 320 VisWS, which is a dual PIII thing, but it shares a lot of the
framebuffer code (sgivwfb.c) with the O2 one (gbefb.c) - and I'm 
writing this on an O2 with IRIX.

We've still have such a beast here, and I'm trying to set up a baseline
of required patches for current kernels in order to get a running
configuration out of the box. Because gbefb was derived from sgivwfb
somewhen back in 2002, it is therefore quite interesting to see how
things are going on the MIPS side, as both gfx hardware implementations
are supposed to be very similar (the visws one using hardware from O2
GBE). 

Currently, the only VisWS mode that works under X11 is Depth 15bit,
using the 2 byte/16bit ARGB5 mode in sgivwfb.c, with 1280x1024 
or higher with the 1600sw LCD panel. Surprisingly, Depth 16 in
/etc/X11/xorg.conf is not completely OK anymore, perhaps due 
to problems with the transparency bit. Anything else like 24 
or 8 bit looks decidedly odd, and hard to read at all. 
Namely 24/32bit is completely broken, the width of the
display is only 2/3 of the screen, though timing is still OK. 

Back to the question: What mode(s) are usable on a Linux O2? 
Did 24bit work at ANY time on the O2?

Kind regards, Michael
-- 
Michael Joosten, SBS C-LAB, joost@c-lab.de
Fuerstenallee 11, 33094 Paderborn, Germany
Phone: +49 5251 606127, Fax: +49 5251 606065
C-LAB is a cooperation of University Paderborn & SIEMENS
