Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2005 13:45:42 +0100 (BST)
Received: from mail58.messagelabs.com ([IPv6:::ffff:193.109.255.35]:30395 "HELO
	mail58.messagelabs.com") by linux-mips.org with SMTP
	id <S8226360AbVDVMp1>; Fri, 22 Apr 2005 13:45:27 +0100
X-VirusChecked:	Checked
X-Env-Sender: martin.nichols@oxinst.co.uk
X-Msg-Ref: server-9.tower-58.messagelabs.com!1114173920!67412617!1
X-StarScan-Version: 5.4.11; banners=-,-,-
X-Originating-IP: [194.200.52.193]
Received: (qmail 11519 invoked from network); 22 Apr 2005 12:45:20 -0000
Received: from smtp1.oxinst.co.uk (HELO ukhontx01.oxinst.co.uk) (194.200.52.193)
  by server-9.tower-58.messagelabs.com with SMTP; 22 Apr 2005 12:45:20 -0000
Received: by UKHONTX01 with Internet Mail Service (5.5.2653.19)
	id <J17AS11D>; Fri, 22 Apr 2005 13:45:19 +0100
Message-ID: <DEF431FFDB15C1488464F0E57D5506642AA6B7@MEDNT02>
From:	martin.nichols@oxinst.co.uk
To:	linux-mips@linux-mips.org
Subject: Common Flash Memory Interface
Date:	Fri, 22 Apr 2005 13:48:02 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <martin.nichols@oxinst.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.nichols@oxinst.co.uk
Precedence: bulk
X-list: linux-mips

Hi all,

Can anyone out there help?

I'm in the process of designing an Au1100 based board and this question has
both hardware
and software aspects.

I've arranged for a pair of Spansion S29GL256N 256Mbit flash roms to be
connected to the
Au1100 static bus. These devices are each 16bits wide and are connected to
upper and lower
halves of the 32 bit static bus at an address such that the boot code can
reside in them.
After boot, we want to use the remainder of the devices as flash disk using
one of the wear
leveling file systems. Each flash chip implements the Common Flash Memory
Interface standard,
but as they are arranged as 32 bits wide the devices are effectively
interleaved.

Can Linux support this arrangement?
If not, what do other folks do?

I think I could arrange the flash chips as 32M x 16 rather than 16M x 32 and
force the CPU
to boot from 16 bit wide ROM using the ROMSIZE pin on the Au1100. There is
obviously a
significant performance loss in doing this.

Finally, this email is not confidential and is for all Linux-Mips
addressees.

Regards and thanks,

Martin Nichols.

 ###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ### 

Unless stated above to be non-confidential, this E-mail and any 
attachments are private and confidential and are for the addressee 
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt 
and delete it from your records. Internet communications are not secure 
and Oxford Instruments is not responsible for their abuse by third 
parties nor for any alteration or corruption in transmission. 
