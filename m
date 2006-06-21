Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 08:01:25 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:37513 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8126482AbWFUHBP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jun 2006 08:01:15 +0100
Received: (qmail 256 invoked by uid 101); 21 Jun 2006 07:01:04 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 21 Jun 2006 07:01:04 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k5L714is023925;
	Wed, 21 Jun 2006 00:01:04 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF7G5Q3>; Wed, 21 Jun 2006 00:01:03 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D51C29CF@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	"'Roman Mashak'" <mrv@corecom.co.kr>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: RE: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Date:	Wed, 21 Jun 2006 00:01:01 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Roman,

   Just wanted to make sure that you had applied the patch mentioned in my earlier e-mail on top of the linux-2.6.12-rc3_L002.tar.gz release.

-Raj 

-----Original Message-----
From: Roman Mashak [mailto:mrv@corecom.co.kr] 
Sent: Tuesday, June 20, 2006 5:35 PM
To: Raj Palani; Ralf Baechle
Cc: linux-mips@linux-mips.org
Subject: Re: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)

Hello, Raj!
You wrote to "Ralf Baechle" <ralf@linux-mips.org>; "Roman Mashak" 
<mrv@corecom.co.kr> on Tue, 20 Jun 2006 09:15:56 -0700:

 RP> I would request that you take a look at our current GE driver  RP> (msp85x0_ge.c) for the Sequoia platform and send us your feedback.
 RP> This is currently available on our ftp site ftp.pmc-sierra.com under  RP> /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.  The driver has been  RP> completely re-written and we welcome any feedback on the same.
As you could notice in my first message in this thread I reffered to
2.6.12-rc3_L002 from PMC ftp site. And Ethernet bridging behavior I described is occurring at that particular kernel.

 RP> The patches that have been generated for fixes that were made after  RP> this release are available under  RP> /pub/linux/2.6.12/patches-2.6.12-rc3_L002.

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
