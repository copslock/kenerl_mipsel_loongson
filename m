Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2LJ9DU10294
	for linux-mips-outgoing; Thu, 21 Mar 2002 11:09:13 -0800
Received: from quicklogic.com (quick1.quicklogic.com [206.184.225.224])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2LJ9Aq10290
	for <linux-mips@oss.sgi.com>; Thu, 21 Mar 2002 11:09:10 -0800
Received: from qldomain-Message_Server by quicklogic.com
	with Novell_GroupWise; Thu, 21 Mar 2002 11:11:32 -0800
Message-Id: <sc99bfe4.043@quicklogic.com>
X-Mailer: Novell GroupWise Internet Agent 5.5.3.1
Date: Thu, 21 Mar 2002 11:10:56 -0800
From: "Dan Aizenstros" <daizenstros@quicklogic.com>
To: <dom@algor.co.uk>, <fxzhang@ict.ac.cn>, <linux-mips@oss.sgi.com>,
   <girishvg@yahoo.com>
Subject: Re: Re: PCI VGA Card Initilization (SIS6326 / PT80)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g2LJ9Aq10291
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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
