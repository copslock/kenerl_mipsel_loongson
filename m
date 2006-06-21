Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 01:35:16 +0100 (BST)
Received: from [220.76.242.187] ([220.76.242.187]:20146 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S8133814AbWFUAfH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Jun 2006 01:35:07 +0100
Received: from mrv ([192.168.11.157])
	by localhost.localdomain (8.12.8/8.12.8) with SMTP id k5L0a0YV002194;
	Wed, 21 Jun 2006 09:36:18 +0900
Message-ID: <001401c694ca$8cb8e530$9d0ba8c0@mrv>
From:	"Roman Mashak" <mrv@corecom.co.kr>
To:	"Raj Palani" <Rajesh_Palani@pmc-sierra.com>,
	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
References: <478F19F21671F04298A2116393EEC3D531D2D4@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
Subject: Re: Ethernet bridging on 2.6.12-rc3 (PMC-sierra patched)
Date:	Wed, 21 Jun 2006 09:34:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="koi8-r";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
FL-Build: Fidolook 2002 (SL) 6.0.2800.86 - 14/6/2003 22:16:25
Return-Path: <mrv@corecom.co.kr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrv@corecom.co.kr
Precedence: bulk
X-list: linux-mips

Hello, Raj!
You wrote to "Ralf Baechle" <ralf@linux-mips.org>; "Roman Mashak" 
<mrv@corecom.co.kr> on Tue, 20 Jun 2006 09:15:56 -0700:

 RP> I would request that you take a look at our current GE driver
 RP> (msp85x0_ge.c) for the Sequoia platform and send us your feedback.
 RP> This is currently available on our ftp site ftp.pmc-sierra.com under
 RP> /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.  The driver has been
 RP> completely re-written and we welcome any feedback on the same.
As you could notice in my first message in this thread I reffered to 
2.6.12-rc3_L002 from PMC ftp site. And Ethernet bridging behavior I 
described is occurring at that particular kernel.

 RP> The patches that have been generated for fixes that were made after
 RP> this release are available under
 RP> /pub/linux/2.6.12/patches-2.6.12-rc3_L002.

With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
