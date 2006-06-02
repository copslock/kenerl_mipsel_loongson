Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2006 01:28:53 +0200 (CEST)
Received: from father.pmc-sierra.com ([216.241.224.13]:56503 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133809AbWFBX2m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Jun 2006 01:28:42 +0200
Received: (qmail 12393 invoked by uid 101); 2 Jun 2006 23:28:30 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 2 Jun 2006 23:28:30 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k52NSPjB012580;
	Fri, 2 Jun 2006 16:28:25 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF64PT4>; Fri, 2 Jun 2006 16:28:24 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D5274123@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Roman Mashak <mrv@corecom.co.kr>, linux-mips@linux-mips.org
Cc:	Kiran Thota <Kiran_Thota@pmc-sierra.com>
Subject: RE: booting 64bit kernel on RM9150
Date:	Fri, 2 Jun 2006 16:28:17 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Roman,

   The patch for 64-bit support for Sequoia would follow the patch for the base support for Sequoia in the Linux/MIPS tree.

-Raj 

> -----Original Message-----
> From: Roman Mashak [mailto:mrv@corecom.co.kr] 
> Sent: Thursday, June 01, 2006 11:33 PM
> To: linux-mips@linux-mips.org
> Cc: Raj Palani; Kiran Thota
> Subject: booting 64bit kernel on RM9150
> 
> Hello,
> 
> I succesfully compiled 2.6.12-rc3 (patched by PMC-sierra), 
> but failed to boot it on Sequoia evaluation board. Firmware 
> version is: PMON2000 1.9 (SEQUOIA-EB).
> 
> What I understood is PMON can't deal with 64-bit images, 
> that's why kernel image should be "objcopy'd" into ELF32 (so, 
> result is two images: 64bit 'vmlinux' and 32bit 
> 'vmlinux.32'). So upon booting 'vmlinux.32' - board gets hang up:
> 
> Loading file: tftp://192.168.11.43/vmlinux.32 (elf)
> 0x80100000/2088944 + 0x80300000/774278 + 0x803bd086/139162(z) 
> + 4044 syms-
> 
> 
> With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
> 
> 
