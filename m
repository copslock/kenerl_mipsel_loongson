Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Apr 2005 09:39:22 +0100 (BST)
Received: from mail59.messagelabs.com ([IPv6:::ffff:195.245.230.83]:50354 "HELO
	mail59.messagelabs.com") by linux-mips.org with SMTP
	id <S8225409AbVDYIjF>; Mon, 25 Apr 2005 09:39:05 +0100
X-VirusChecked:	Checked
X-Env-Sender: martin.nichols@oxinst.co.uk
X-Msg-Ref: server-7.tower-59.messagelabs.com!1114418337!56038863!1
X-StarScan-Version: 5.4.11; banners=-,-,-
X-Originating-IP: [194.200.52.193]
Received: (qmail 18780 invoked from network); 25 Apr 2005 08:38:58 -0000
Received: from smtp1.oxinst.co.uk (HELO ukhontx01.oxinst.co.uk) (194.200.52.193)
  by server-7.tower-59.messagelabs.com with SMTP; 25 Apr 2005 08:38:58 -0000
Received: by UKHONTX01 with Internet Mail Service (5.5.2653.19)
	id <JTJ3AWY2>; Mon, 25 Apr 2005 09:38:56 +0100
Message-ID: <DEF431FFDB15C1488464F0E57D5506642AA6B8@MEDNT02>
From:	martin.nichols@oxinst.co.uk
To:	wd@denx.de
Cc:	linux-mips@linux-mips.org
Subject: RE: Common Flash Memory Interface 
Date:	Mon, 25 Apr 2005 09:41:47 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <martin.nichols@oxinst.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.nichols@oxinst.co.uk
Precedence: bulk
X-list: linux-mips

Hi Wolfgang,

Many thanks for your reply - You've reassured me that I'm not
doing something in hardware that I'll regret later!

As for the waiver on the disclaimer - I can't win here! It's automatically
attached by our Head Office to all outgoing emails and I don't know of any
way to stop it. Not long ago someone else on this list commented on a
similar
(probably automatically) attached disclaimer without a waiver
http://www.linux-mips.org/archives/linux-mips/2005-03/msg00184.html

Regards,

Martin Nichols,
Thanks again and ...
please ignore the bit that follows - I didn't put it there!




-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: 22 April 2005 16:03
To: martin.nichols@oxinst.co.uk
Cc: linux-mips@linux-mips.org
Subject: Re: Common Flash Memory Interface 


In message <DEF431FFDB15C1488464F0E57D5506642AA6B7@MEDNT02> you wrote:
> 
> I've arranged for a pair of Spansion S29GL256N 256Mbit flash roms to be
> connected to the
> Au1100 static bus. These devices are each 16bits wide and are connected to
> upper and lower
> halves of the 32 bit static bus at an address such that the boot code can
> reside in them.
> After boot, we want to use the remainder of the devices as flash disk
using
> one of the wear
> leveling file systems. Each flash chip implements the Common Flash Memory
> Interface standard,

OK.

> but as they are arranged as 32 bits wide the devices are effectively
> interleaved.

I'd rather say thay are accesses in parallel.

> Can Linux support this arrangement?

Yes, of course. Such a configurationir more or less standard. The MTD
drivers will work just fine.

> Finally, this email is not confidential and is for all Linux-Mips
> addressees.

Then why do you attach such a silly disclaimer?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"...one of the main causes of the fall of the Roman Empire was  that,
lacking  zero,  they had no way to indicate successful termination of
their C programs."                                     - Robert Firth

+++ Virus-scanned by Messagelabs for Oxford Instruments +++

 ###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ### 

Unless stated above to be non-confidential, this E-mail and any 
attachments are private and confidential and are for the addressee 
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt 
and delete it from your records. Internet communications are not secure 
and Oxford Instruments is not responsible for their abuse by third 
parties nor for any alteration or corruption in transmission. 
