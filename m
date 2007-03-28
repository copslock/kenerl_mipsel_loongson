Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 17:33:21 +0100 (BST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:15513 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20023091AbXC1QdT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 17:33:19 +0100
Received: (qmail 10475 invoked by uid 101); 28 Mar 2007 16:32:03 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 28 Mar 2007 16:32:03 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2SGVwWr010142;
	Wed, 28 Mar 2007 08:31:58 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCQD2B1>; Wed, 28 Mar 2007 09:31:56 -0800
Message-ID: <5C1FD43E5F1B824E83985A74F396286E048156C4@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Don Hiatt <Don_Hiatt@pmc-sierra.com>
To:	Attila Kinali <attila@kinali.ch>, linux-mips@linux-mips.org
Subject: RE: Power loss and system time when not having a battery backed R
	TC
Date:	Wed, 28 Mar 2007 09:32:08 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Don_Hiatt@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Don_Hiatt@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Attila Kinali
> Sent: Wednesday, March 28, 2007 7:22 AM
> To: Markus Gothe
> Cc: linux-mips@linux-mips.org
> Subject: Re: Power loss and system time when not having a 
> battery backed RTC
> I already thought about storing the last known time somewhere 
> in the flash. But unfortunately the device can be unplugged 
> suddenly w/o correct shutdown (actualy this is the normal case).
> The only way around this i could came up with was to 
> periodically store the current time. But this is then a trade 
> off between jump back period length and how long the flash 
> will last the continous writes, with no sweet spot that looks good.
>
You could also modify your startup script check the date and if it
is 1970 you could set the date to sometime in 2007 (or whatever date
your product will finally ship). Sure the date will still be wrong but
not as wrong. :)

Cheers,

don
