Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LHSVH01947
	for linux-mips-outgoing; Thu, 21 Mar 2002 09:28:31 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LHSOq01939
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 09:28:24 -0800
Received: from quicklogic.com (quick1.quicklogic.com [206.184.225.224]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id HAA06077
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 07:50:11 -0800 (PST)
	mail_from (daizenstros@quicklogic.com)
Received: from qldomain-Message_Server by quicklogic.com
	with Novell_GroupWise; Thu, 21 Mar 2002 07:22:36 -0800
Message-Id: <sc998a3c.062@quicklogic.com>
X-Mailer: Novell GroupWise Internet Agent 5.5.3.1
Date: Thu, 21 Mar 2002 07:22:02 -0800
From: "Dan Aizenstros" <daizenstros@quicklogic.com>
To: <dom@algor.co.uk>, <fxzhang@ict.ac.cn>, <linux-mips@oss.sgi.com>,
   <girishvg@yahoo.com>
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2LHSOq01940
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello Dominic,

Is Algorithmics BIOS emulator not the x86emu code
that can be found in the Alpha MILO and the XFree86
code base as Alan Cox mentioned?

That code was originally under GPL but was changed
to a BSD style license when Kendall Bennett took
over the project.

The code is available at the SciTech ftp site
ftp.scitechsoft.com/devel/x86emu/x86emu-0.8.tar.gz

Dan Aizenstros
Software Project Manager
QuickLogic Canada


>>> Dominic Sweetman <dom@algor.co.uk> 03/21/02 02:39 AM >>>

Zhang Fuxin (fxzhang@ict.ac.cn) writes:

> We have tried several cards on Algor P6032 board,but only matrox
> Gxxx cards (G450 needs the latest code) can be used by linux kernel
> without vga bios executed. With a x86 emulator we are able to use
> Riva TNT2,and probably more can work. Unfortunately that emulator is
> an executable from Algor, as a kindly help. We can't get more
> control on it and finally give up...

Just a note: Zhang, if you want source code of the Algorithmics
simulator, we've no problem at all supplying it on our standard
license.  

Whether that source is useful to you is another question: the BIOS
emulator was created out of pieces of a complete x86 emulator, and
it's a fairly complicated bit of software.

One of my colleagues saw Zhang's request and said he'd consult, and
then the message got lost - sorry.

Our standard license is not GPL and it does have one restriction - if
you build our software into something you sell, we ask you to get a
further license from us before you take the money from your customers.

We can be persuaded to put software out on GPL instead (as we did with
the floting-point emulation code).  But generally some commercial
organisation - the difference only matters then, right? - has to ask
nicely...

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone +44 1223 706200/fax +44 1223 706250/direct +44 1223 706205
http://www.algor.co.uk
