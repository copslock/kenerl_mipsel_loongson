Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 17:46:24 +0000 (GMT)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:53973 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225562AbUCZRqX>; Fri, 26 Mar 2004 17:46:23 +0000
Received: (qmail 18756 invoked from network); 26 Mar 2004 17:46:16 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 26 Mar 2004 17:46:16 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id i2QHkDb6008920;
	Fri, 26 Mar 2004 09:46:14 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <GNPZK4KG>; Fri, 26 Mar 2004 09:46:13 -0800
Message-ID: <9DFF23E1E33391449FDC324526D1F259022534BB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From: Manish Lachwani <Manish_Lachwani@pmc-sierra.com>
To: "'Thomas Koeller'" <thomas.koeller@baslerweb.com>
Cc: linux-mips@linux-mips.org
Subject: RE: titan ethernet driver
Date: Fri, 26 Mar 2004 09:39:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Manish_Lachwani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Manish_Lachwani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hello !

Like I mentioned in my previous mail, the first version of the driver in the linux-mips tree has not been updated. I have a local version of the driver that needs to be checked in the tree. In the meantime, if you wish I can send the local working version of the driver that I have.

Thanks
Manish

-----Original Message-----
From: Thomas Koeller [mailto:thomas.koeller@baslerweb.com]
Sent: Friday, March 26, 2004 6:12 AM
To: Manish Lachwani
Cc: linux-mips@linux-mips.org
Subject: titan ethernet driver


Hi Manish,

I am trying to use your titan ethernet driver. I
found that I could not compile it for a 2.6.4
kernel, because it uses 2.4 kernel APIs. When
fixing that I found that the code contains
obvious errors; it does not even compile unchanged.
This makes me a bit uneasy. Would you mind
commenting on the state of this driver? Are there
any newer sources than those contained in CVS at
linux-mips.org?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
