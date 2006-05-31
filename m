Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 18:07:07 +0200 (CEST)
Received: from father.pmc-sierra.com ([216.241.224.13]:48551 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133490AbWEaQG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 May 2006 18:06:57 +0200
Received: (qmail 2068 invoked by uid 101); 31 May 2006 16:06:51 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 31 May 2006 16:06:51 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k4VG6owg031350;
	Wed, 31 May 2006 09:06:50 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF6RP9P>; Wed, 31 May 2006 09:06:50 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D5273E4F@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Roman Mashak <mrv@corecom.co.kr>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: RE: compiling BCM5700 driver
Date:	Wed, 31 May 2006 09:06:44 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Roman, 
 
> I'm more concerned with Titan GE driver on "Sequoia" board 
> (by PMC-sierra). 
> What's the status of this driver in 2.4.26? If I understand 
> correct - it's maintained now only in 2.6.x? Upon compilation 
> of 2.4.26 for Sequoia" board and installation on to target, 
> we observed a lot of CRC errors on gigabit ethernet (we used 
> SmartBit for testing). Is the driver in this version broken?

Yes.  We are currently maintaining the Titan GE driver on "Sequoia" only in 2.6.x.  The GE driver in Sequoia has been renamed to msp85xx_ge.c.  We are in the process of generating a patchset to add support for Sequoia (MSP8510/MSP8520) in the Linux/MIPS 2.6 tree.

Our most recent Linux 2.6 tree for Sequoia is available on our ftp site (ftp.pmc-sierra.com) under /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.

-Raj
