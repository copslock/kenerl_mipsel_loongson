Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 05:05:51 +0000 (GMT)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:62203 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8224807AbVBPFFf>; Wed, 16 Feb 2005 05:05:35 +0000
Received: (qmail 6952 invoked by uid 101); 16 Feb 2005 05:05:27 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 16 Feb 2005 05:05:27 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id j1G55LAt027566;
	Tue, 15 Feb 2005 21:05:22 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <CPW14K6S>; Tue, 15 Feb 2005 21:05:21 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDCA0@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Brad Larson <Brad_Larson@pmc-sierra.com>
To:	"'Fredrik'" <fcn-sub@noon.org>, linux-mips@linux-mips.org
Subject: RE: kernel for custom MV64341 board?
Date:	Tue, 15 Feb 2005 21:05:19 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Fredrik,

MontaVista completed a 2.4 port to Ocelot-III with RM7900 (or RM7000C) and Discovery-3 (MV64440).  Ocelot-III is ATX form factor while previous Ocelot, Ocelot-C and Ocelot-G were CPCI.  This is probably close to the board you are describing.  Any board dependent changes should have been committed to linux-mips.org by now.

--Brad

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Fredrik
Sent: Tuesday, February 15, 2005 5:56 PM
To: linux-mips@linux-mips.org
Subject: kernel for custom MV64341 board?


Howdy,

I'm getting a custom board going: it sports an RM7000 and Marvell
MV64341 system controller (alas, no external UART!).  I've hacked
U-Boot to the point where I can TFTP a kernel image and (start to)
boot it.

So far I've been using an old 2.4 kernel I used for some Ocelot-G
work, just to get past the TFTP-load stage. MY QUESTION IS: What would
be the best kernel version for me to now start customizing for my
board?  Is 2.6 too bleeding-edge, 2.4 too moldy, or what?  Dealing
with the MV64341 will be most of the effort, of course.

The Ocelot boards seem well supported, but there looks to be a lot of
code that would have to change (different system controller, different
memory map--though I'm flexible--a lot of assumptions about the
goodies available on-board, etc.).  This is the first time I'll be
porting the kernel, so it might be more productive for me to start
from a minimalist configuration and add-in what I need.  Enough code
to set up the memory configuration would be a big help.

Suggestions?

/Fredrik

+----------------------------------------------------------------+
|            Fredrik Noon,   Senior Software Engineer            |
|            Hifn, Inc.      www.hifn.com                        |
|            fnoon@hifn.com  +1 408 399 3630                     |
|-------------------+--------------------------------------------|
|  pgp key: <http://noon.org/keys/pgpkey.txt> 7840AC55           |
+----------------------------------------------------------------+
