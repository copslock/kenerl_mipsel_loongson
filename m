Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 17:35:19 +0100 (BST)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:46546 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225967AbUEMQfR>; Thu, 13 May 2004 17:35:17 +0100
Received: (qmail 27608 invoked from network); 13 May 2004 16:35:06 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 13 May 2004 16:35:06 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id i4DGZ0Kr029978;
	Thu, 13 May 2004 09:35:00 -0700
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <KPDYDPMB>; Thu, 13 May 2004 09:35:00 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259022536FB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
From: Manish Lachwani <Manish_Lachwani@pmc-sierra.com>
To: "'Thomas Koeller'" <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Subject: RE: titan ethernet driver
Date: Thu, 13 May 2004 09:26:50 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Manish_Lachwani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Manish_Lachwani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Are you referring to 2.4 or 2.6? You have already downloaded 2.4.26 and 2.4.21 versions (with source code) from the PMC-Sierra ftp site. These are fully functional and several customers are using it from the last 3-4 months now. The patches for 2.4 have been sent out to Ralf. 

As far as 2.6 goes, when it is ready, we will let you know

-----Original Message-----
From: Thomas Koeller [mailto:thomas.koeller@baslerweb.com]
Sent: Thursday, May 13, 2004 7:44 AM
To: linux-mips@linux-mips.org
Cc: Ralf Baechle; Manish Lachwani
Subject: Re: titan ethernet driver


On Friday, March 26th, 2004 Ralf Baechle wrote:
> On Fri, Mar 26, 2004 at 03:12:06PM +0100, Thomas Koeller wrote:
> > I am trying to use your titan ethernet driver. I
> > found that I could not compile it for a 2.6.4
> > kernel, because it uses 2.4 kernel APIs. When
> > fixing that I found that the code contains
> > obvious errors; it does not even compile unchanged.
> > This makes me a bit uneasy. Would you mind
> > commenting on the state of this driver? Are there
> > any newer sources than those contained in CVS at
> > linux-mips.org?
>
> I'm going to fix Yosemite / Titan support in 2.6 asap - as soon as I get
> the board which should be somewhen next week.
>
>   Ralf

I see work going on for the titan ge driver, but AFAIK the only
platform supporting this hardware is the yosemite board, and the
board support has not been updated for months and is still
non-functional. So I wonder how these changes are tested - or
am I missing something?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
