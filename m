Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2MBgqk17164
	for linux-mips-outgoing; Fri, 22 Mar 2002 03:42:52 -0800
Received: from smtp011.mail.yahoo.com (smtp011.mail.yahoo.com [216.136.173.31])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2MBgjq17161
	for <linux-mips@oss.sgi.com>; Fri, 22 Mar 2002 03:42:45 -0800
Received: from girishvg (AUTH login) at i205206.ppp.asahi-net.or.jp (HELO nazneen) (girishvg@61.125.205.206)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 22 Mar 2002 11:45:08 -0000
Message-ID: <00c001c1d197$4a5c14a0$cecd7d3d@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "Dan Aizenstros" <daizenstros@quicklogic.com>, <dom@algor.co.uk>,
   <fxzhang@ict.ac.cn>, <linux-mips@oss.sgi.com>
References: <sc99bfe4.044@quicklogic.com>
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
Date: Fri, 22 Mar 2002 20:47:02 +0900
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


hello, all
thank you very much for all these reply mails.
my saga of VGA initialization continues. it occurs to me that the x86
emulation for the VGA bios is a long process. SiS6326 chipset has support
inside XFree86 & digging out the BIOS code from here is also a big story.
hence i was looking for a rather quickish solution. currently i'm trying to
use sis_*.c files from XFree86 source. dont know how but my monitor displays
2 red & 1 green vertical lines. the sis_bios source code searched for the
mode, memory references inside the BIOS at 0x20A offset & it failed to find
the mode & other info. AOpen BIOS version is 2.25.
could anybody of you please share your success story of VGA initialization
on MIPS board with me??
many thanks in advance.
regards,
girish.



----- Original Message -----
From: "Dan Aizenstros" <daizenstros@quicklogic.com>
To: <dom@algor.co.uk>; <fxzhang@ict.ac.cn>; <linux-mips@oss.sgi.com>;
<girishvg@yahoo.com>
Sent: Friday, March 22, 2002 4:10 AM
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)


Hello Dominic,

Actually it was Girish Gulawani who said he used the
MILO bios not Zhang. He said he was using the files
vgaraw1.c and vgaraw2.c from MILO. Those files do not
use the x86emu BIOS emulator but try to directly
initialize the VGA adapter.

Dan Aizenstros
Software Project Manager
QuickLogic Canada

>>> Dominic Sweetman <dom@algor.co.uk> 03/21/02 08:28 AM >>>

Dan,

> Is Algorithmics BIOS emulator not the x86emu code
> that can be found in the Alpha MILO and the XFree86
> code base as Alan Cox mentioned?

It's an entirely indepedent invention of the same idea.  I've no idea
whether it's any better/worse, but it sounded like our binary was
working for Zhang better than the MILO he'd built.

Dominic
Algorithmics Ltd


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
